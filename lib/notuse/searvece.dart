// import 'package:cloud_firestore/cloud_firestore.dart';

// class FirestoreService{
//   final db= FirebaseFirestore.instance;

//   Future<void> create()async{
//     await db.collection('songs').doc('S01').set(
//       { //これで１ドキュメント
//         'title':'Poker Face',
//         'artist':'レディーガガ',
//         'released':2008,
//         'genre':'エレクトロポップ',
//       },

//     );
//      await db.collection('songs').doc('S02').set(
//       {
//         'title': '米津玄師',
//         'artist': 'Lemon',
//         'released': 2018,
//         'genre': 'J-POP',
//       },
//     );
//     await db.collection('songs').doc('S03').set(
//       {
//         'title': 'クリスマス・イブ',
//         'artist': '山下達郎',
//         'released': 1983,
//         'genre': 'J-POP',
//       },
//     );
//     await db.collection('songs').doc('S04').set(
//       {
//         'title': 'Shape of you',
//         'artist': 'エド シーラン',
//         'released': 2017,
//         'genre': 'トロピカルハウス',
//       },
//     );
//     await db.collection('songs').doc('S05').set(
//       {
//         'title': 'Wonderwall',
//         'artist': 'オアシス',
//         'released': 1995,
//         'genre': 'ブリットポップ',
//       },
//     );
//     await db.collection('songs').doc('S06').set(
//       {
//         'title': 'ブルーバード',
//         'artist': 'いきものがかり',
//         'released': 2008,
//         'genre': 'J-POP',
//       },
//     );
//     await db.collection('songs').doc('S07').set(
//       {
//         'title': 'Beat it',
//         'artist': 'マイケル ジャクソン',
//         'released': 1983,
//         'genre': 'ハードロック',
//       },
//     );
//     await db.collection('songs').doc('S08').set(
//       {
//         'title': 'STAY',
//         'artist': 'ザ キッド ラロイ',
//         'released': 2021,
//         'genre': 'ポップラップ',
//       },
//     );
//     await db.collection('songs').doc('S09').set(
//       {
//         'title': 'チェリー',
//         'artist': 'スピッツ',
//         'released': 1996,
//         'genre': 'J-POP',
//       },
//     );
//     await db.collection('songs').doc('S10').set(
//       {
//         'title': 'ミックスナッツ',
//         'artist': 'Official髭男dism',
//         'released': 2022,
//         'genre': 'J-POP',
//       },
//     );
//   }
//   Future<void> read()async{
//     final doc=await db.collection('songs').doc('S07').get();
//   }
//   Future<void> update()async{
//     await db.collection('songs').doc('S09').update({
//       'genre':'ロック',
//     });
//   }
//   Future<void> delete()async{
//     await db.collection('songs').doc('S02').delete();
//   }
//   Future<void> create1()async{ 

//    }
//   Future<void> create2()async{
//     //new+old
//     await db.collection('songs').doc('S10').set({
//         'title': '新時代',
//         'artist': 'Ado',
//     },
//     //古い方を消す
//     SetOptions(merge: false),
//     );
//     }
//   Future<void> create3()async{
//     await db.collection('songs').doc('S10').set({
//         'released':2022,
//         'genre': 'J-POP',
//         'artist': 'ウタ',
//     },
//     //古い方と合体 同じキーは塗り替え
//     SetOptions(merge: true),
//     );
//     }
//     Future<void> read123()async{
//       final snapshot =await db.collection('songs').where(
//         'genre',isEqualTo: 'J-POP')
//         .orderBy('released')
//         .limit(3)  //3つ取り出す
//         .get();

//         final docs =snapshot.docs.map((e) => e.data().toString(),
//         );
//       final songs =docs.join();
//       print(songs);
//     }
// }