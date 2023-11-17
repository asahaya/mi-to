import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

Future<UserCredential?> handleSignIn() async {
  try {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    // If you want to use Firebase Auth for sign-in
    final UserCredential authResult =
        await _auth.signInWithCredential(credential);

    return authResult;
  } catch (error) {
    print(error);
    return null;
  }
}

class AuthService {
  signInWithGoogle() async {
    //
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    //
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    //
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: signUserOut, icon: Icon(Icons.logout)),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text(user.uid),
            Text(
              "LOGGED IN AS : " + user.email!,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // IconButton(onPressed: signUserOut, icon: Icon(Icons.logout)),
        ],
      ),
      body: Center(
        child: Text(
          "LOGGED IN AS : NOT",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
