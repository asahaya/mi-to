import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TryToDo extends StatefulWidget {
  const TryToDo({super.key});

  @override
  State<TryToDo> createState() => _TryToDoState();
}
FirebaseFirestore firestore= FirebaseFirestore.instance;
Future<String> getDoc()async{
  DocumentSnapshot<Map<String,dynamic>>ss=await firestore.collection('users').doc().get();
  if(ss.data()!=null){}
  
  return ss.data()!['full_name'];
}

class _TryToDoState extends State<TryToDo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getDoc(),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return Text(snapshot.data);
          }else{
            return const Center(
              child: Text("not data"),
            );
          }
        },
        ),
    );
  }
}