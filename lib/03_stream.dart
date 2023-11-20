import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final Stream<QuerySnapshot<Map<String, dynamic>>> usersStreamSUN =
    FirebaseFirestore.instance
        .collection('users')
        .where('textYoubiList', arrayContains: "日")
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('re_startTime', descending: false)
        .snapshots();
final Stream<QuerySnapshot<Map<String, dynamic>>> usersStreamMON =
    FirebaseFirestore.instance
        .collection('users')
        .where('textYoubiList', arrayContains: "月")
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('re_startTime', descending: false)
        .snapshots();
final Stream<QuerySnapshot<Map<String, dynamic>>> usersStreamTUE =
    FirebaseFirestore.instance
        .collection('users')
        .where('textYoubiList', arrayContains: "火")
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('re_startTime', descending: false)
        .snapshots();
final Stream<QuerySnapshot<Map<String, dynamic>>> usersStreamWED =
    FirebaseFirestore.instance
        .collection('users')
        .where('textYoubiList', arrayContains: "水")
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('re_startTime', descending: false)
        .snapshots();

final Stream<QuerySnapshot<Map<String, dynamic>>> usersStreamTHU =
    FirebaseFirestore.instance
        .collection('users')
        .where('textYoubiList', arrayContains: "木")
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('re_startTime', descending: false)
        .snapshots();
final Stream<QuerySnapshot<Map<String, dynamic>>> usersStreamFRI =
    FirebaseFirestore.instance
        .collection('users')
        .where('textYoubiList', arrayContains: "金")
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('re_startTime', descending: false)
        .snapshots();
final Stream<QuerySnapshot<Map<String, dynamic>>> usersStreamSAT =
    FirebaseFirestore.instance
        .collection('users')
        .where('textYoubiList', arrayContains: "土")
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('re_startTime', descending: false)
        .snapshots();

    
final Stream<QuerySnapshot<Map<String, dynamic>>> streamSUN =
    FirebaseFirestore.instance
        .collection('users')
        .where('textYoubiList', arrayContains: "日")
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('re_startTime', descending: false)
        .snapshots();
final Stream<QuerySnapshot<Map<String, dynamic>>> streamMON =
    FirebaseFirestore.instance
        .collection('users')
        .where('textYoubiList', arrayContains: "月")
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('re_startTime', descending: false)
        .snapshots();
final Stream<QuerySnapshot<Map<String, dynamic>>> streamTUE =
    FirebaseFirestore.instance
        .collection('users')
        .where('textYoubiList', arrayContains: "火")
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('re_startTime', descending: false)
        .snapshots();
final Stream<QuerySnapshot<Map<String, dynamic>>> streamWED =
    FirebaseFirestore.instance
        .collection('users')
        .where('textYoubiList', arrayContains: "水")
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('re_startTime', descending: false)
        .snapshots();

final Stream<QuerySnapshot<Map<String, dynamic>>> streamTHU =
    FirebaseFirestore.instance
        .collection('users')
        .where('textYoubiList', arrayContains: "木")
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('re_startTime', descending: false)
        .snapshots();
final Stream<QuerySnapshot<Map<String, dynamic>>> streamFRI =
    FirebaseFirestore.instance
        .collection('users')
        .where('textYoubiList', arrayContains: "金")
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('re_startTime', descending: false)
        .snapshots();
final Stream<QuerySnapshot<Map<String, dynamic>>> streamSAT =
    FirebaseFirestore.instance
        .collection('users')
        .where('textYoubiList', arrayContains: "土")
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('re_startTime', descending: false)
        .snapshots();

    