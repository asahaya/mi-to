

// import 'package:firebase_sample_230914/notuse/searvece.dart';
// import 'package:flutter/material.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int  _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {


//     final c=ElevatedButton(
//       onPressed: ()
//       {
//         final service=FirestoreService();
//         service.create3();
//       },
//       child:const Text('Create') ,);
//     final r=ElevatedButton(
//       onPressed: ()
//       {
//        final service=FirestoreService();
//         service.read123();
//       },
//       child:const Text('read') ,);
//     final u=ElevatedButton(
//       onPressed: ()
//       {
//         final service=FirestoreService();
//         service.update();
//       },
//       child:const Text('update') ,);
//     final d=ElevatedButton(
//       onPressed: ()
//       {
//                final service=FirestoreService();
//         service.delete();
//       },
//       child:const Text('delete') ,);


//     return Scaffold(
//       appBar: AppBar(
//       ),
//       body: Center(
//         child: Column(
//           children: [
//               c,
//               r,
//               u,
//               d,
              
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
