import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebasecrud/homescreen.dart/homepage.dart';
import 'package:flutter/material.dart';


 void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});


//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//   bool updateStudent = false;
//   DatabaseReference dbref = FirebaseDatabase.instance.ref();
//   final TextEditingController name = TextEditingController();
//   final TextEditingController age = TextEditingController();
//   List<dynamic> Myfirebaselist = [];
 
//  @override
//   void initState() {
//     // TODO: implement initState
    
//    retrieveStudentData();
//   }
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//     showDialog(
//   context: context,
//   builder: (BuildContext context) {
//     return AlertDialog(
//       title:  TextField(
//         controller: name,
//         decoration: const InputDecoration(labelText: "name",enabledBorder: OutlineInputBorder(),
//         focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
//         focusedErrorBorder: OutlineInputBorder(),
//         fillColor: Color(0xFFE3E3E3),filled: true),
//         keyboardType: TextInputType.text,
        
      
//       ),
//       content:  TextField(
//         controller: age,
//         decoration: const InputDecoration(labelText: "age",enabledBorder: OutlineInputBorder(),
//         focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
//         focusedErrorBorder: OutlineInputBorder(),
//         fillColor: Color(0xFFE8E7E7),filled: true),
//         keyboardType: TextInputType.phone,
        
//       ),
//       actions: [
//         TextButton(
//           style: TextButton.styleFrom(
//         foregroundColor: Colors.pink),
//           child: const Text("Add"),
//           onPressed: () {
//             print("clicked");
           
//            if(name.text.isNotEmpty && age.text.isNotEmpty){
//               Map<String,dynamic> data = {
//                   "name": name.text.toString(),
//                   "age": age.text.toString(),
//                   "subject":""};
                  
//               // ....data insert query....
//               dbref.child("Myrecord").push().set(data).then((value) => {
//                 print("sucess created => $data"),
//                 print(data.toString()),
//                 Navigator.of(context).pop()
//                 }).catchError((Error){
//                   print(Error);
//                 }); 


//                 //  if(updateStudent){
//                 //   dbref.child("Myrecord").child(Student.key!).update(data).then((value) {
//                 //     int index = Myfirebaselist.indexWhere((element) => element.key == key);
//                 //     Myfirebaselist.removeAt(index);
//                 //     Myfirebaselist.insert(index,Student(key: key, studentData: StudentData.fromJson(data)));
//                 //     setState(() {

//                 //     });
//                 //     Navigator.of(context).pop();
//                 //   });
//                 // }
//                 // else{
//                 //   dbref.child("Students").push().set(data).then((value){
//                 //     Navigator.of(context).pop();
//                 //   });
//                 // }

//             }
//             },
//         )
//       ],
//     );
//   },
// );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body:  Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//         const  Text(
//            "FIREBASE - CRUD",
//            style:  TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 20),
//               ),
//               Flexible(
//                 fit: FlexFit.loose,
//                 child:deletemethod()
//               ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: (){
//           age.clear();name.clear();
//           _incrementCounter();
//         },
//         child: const Icon(Icons.add),
//       ), 
//     );
//   }

//   ListView deletemethod() {
//     return ListView.builder(
//                 shrinkWrap: false,
//                          itemCount: Myfirebaselist.length,
//                          itemBuilder: (BuildContext context,index){
//                            return ListTile(title: Text(Myfirebaselist[index].studentData!.name!),
//                            subtitle: Text(Myfirebaselist[index].studentData!.age!),
//                            leading: IconButton(
//                             onPressed: (){
                              
//             //                   dbref.child("Myrecord").child(student.key!).remove().then((value){
//             //   int index = Myfirebaselist.indexWhere((element) => element.key == student.key!);
//             //   Myfirebaselist.removeAt(index);
//             //   setState(() {});
//             // }
//             // );
//             }, 
//                             icon:const Icon(Icons.delete_sharp)),
//                            onTap: (){print(index);},);
//                          });
//   }

//  void retrieveStudentData() {
//     dbref.child("Myrecord").onChildAdded.listen((data) {
//       StudentData studentData = StudentData.fromJson(data.snapshot.value as Map);
//       Student student = Student(key: data.snapshot.key, studentData: studentData);
//       Myfirebaselist.add(student);
//       print(Myfirebaselist.length);
//       setState(() {});
//     });
//     print("lenth${Myfirebaselist.length}");
//   }


// }