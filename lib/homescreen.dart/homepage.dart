import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_realtime_database_crud_tutorial/models/student_model.dart';
import 'package:flutter/material.dart';

import '../model/fbrecord.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  final TextEditingController name = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController description = TextEditingController();

  List<Student> studentList = [];

  bool updateStudent = false;


  @override
  void initState() {
    super.initState();

    retrieveFirebaseData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Idel Directory"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for(int i = 0 ; i < studentList.length ; i++)
              studentWidget(studentList[i])
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        name.text = "";
        age.text = "";
        description.text = "";
        updateStudent = false;
        studentDialog();
      },child: const Icon(Icons.add),),
    );
  }

  void studentDialog({String? key}) {
    showDialog(context: context, builder: (context){
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Color(0xFF02B9EB),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Center(child: Text("Details",style:  TextStyle(color: Colors.black,fontSize: 25))),
              ),
        
              TextField(
                controller: name,
                decoration: const InputDecoration(labelText: "name",enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                focusedErrorBorder: OutlineInputBorder(),
                fillColor: Color(0xFFFCFCFC),filled: true),
                keyboardType: TextInputType.text),
                
              const SizedBox(height: 10,),
        
              TextField(
                controller: age,
                decoration: const InputDecoration(labelText: "age",enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                focusedErrorBorder: OutlineInputBorder(),
                fillColor: Color(0xFFFCFAFA),filled: true),
                keyboardType: TextInputType.number,),
        
               const SizedBox(height: 10,),
        
              TextField(
                controller: description,
                decoration: const InputDecoration(labelText: "description",enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                focusedErrorBorder: OutlineInputBorder(),
                fillColor: Color(0xFFFEFDFD),filled: true),
                keyboardType: TextInputType.text),
        
              ElevatedButton(onPressed: (){
                // send the input data firebaseDB...
                Map<String,dynamic> data = {
                  "name": name.text.toString(),
                  "age": age.text.toString(),
                  "subject": description.text.toString()
                };
                // update the data FirebaseDB...
                if(updateStudent){
                  dbRef.child("Myrecord").child(key!).update(data).then((value) {
                    int index = studentList.indexWhere((element) => element.key == key);
                    studentList.removeAt(index);
                    print("removed myindex--- $index");
                    studentList.insert(index,Student(key: key, studentData: StudentData.fromJson(data)));
                    print("updated data--- $data");
                    setState(() {
        
                    });
                    Navigator.of(context).pop();
                  });
                }
                else{
                  // push the data to fbDB...
                  dbRef.child("Myrecord").push().set(data).then((value){
                    print("Insert data--- $data");
                    Navigator.of(context).pop();
                  });
                }
                
        
                
              }, child: Text(updateStudent ? "Update Data" : "Save Data"))
            ],
          ),
        ),
      );
    });
  }

// get data from Fdb....
  void retrieveFirebaseData() {
    dbRef.child("Myrecord").onChildAdded.listen((data) {
      StudentData studentData = StudentData.fromJson(data.snapshot.value as Map);
      Student student = Student(key: data.snapshot.key, studentData: studentData);
      studentList.add(student);
      print("added mylist--- $studentList");
      setState(() {});
    });
  }

// list the data from Fdb...datas design...
  Widget studentWidget(Student student) {
    return
    InkWell(
      onTap: (){
        name.text = student.studentData!.name!;
        age.text = student.studentData!.age!;
        description.text = student.studentData!.subject!;
        updateStudent = true;
        // popup dialoge design...
        studentDialog(key: student.key);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(top:5,left: 10,right: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.black)),
         child: ListTile(title: Text(student.studentData!.name!),
        subtitle: Text(student.studentData!.subject!),
        leading: CircleAvatar(child: Text(student.studentData!.age!,style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
        trailing: CircleAvatar(backgroundColor:Color(0xFFECECEC),
          child: IconButton(onPressed: (){
            // delete data to Fdb...
            dbRef.child("Myrecord").child(student.key!).remove().then((value){
                  int index = studentList.indexWhere((element) => element.key == student.key!);
                  studentList.removeAt(index);
                  setState(() {});
                  print("deleted myindex--- $index");
                });
          }, icon: const Icon(Icons.delete,color: Colors.red,)),
        ),),
      ),
    );
  }
}










        // child: Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //   children: [
        //     Column(

        //       mainAxisSize: MainAxisSize.min,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Text(student.studentData!.name!),
        //         Text(student.studentData!.age!),
        //         Text(student.studentData!.subject!),
        //       ],
        //     ),
    
        //     InkWell(onTap:(){
        //       dbRef.child("Myrecord").child(student.key!).remove().then((value){
        //         int index = studentList.indexWhere((element) => element.key == student.key!);
        //         studentList.removeAt(index);
        //         setState(() {});
        //       });
        //     },child: const Icon(Icons.delete,color: Colors.red,))
        //   ],
        // ),