import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mi_to_app/03_button_design.dart';
import 'package:mi_to_app/03_register_page.dart';
import 'package:mi_to_app/03_textfield.dart';

import '03_auth_service.dart';
import '03_realtime_changes.dart';

class StartScreen extends StatefulWidget {
  StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final emailCon = TextEditingController();
  final passwordCon = TextEditingController();

  //signin
  void signIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailCon.text,
        password: passwordCon.text,
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage('ログインに失敗しました：$e');
    }
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.deepPurple,
            title: Center(
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final heightStatus = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
              colors: [
                const Color(0xffe4a972).withOpacity(0.6),
                Color.fromARGB(255, 41, 144, 162).withOpacity(0.6),
              ],
              stops: const [
                0.0,
                1.0,
              ],
            ),
          ),
          child: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const UserInformation();
                } else {
                  return LayoutBuilder(builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: constraints.maxHeight),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(height: 50),
                            Container(
                              height: 100,
                              child: Column(
                                children: [
                                  Text(
                                    'Mi-To',
                                    style: TextStyle(
                                        fontSize: 50,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'bananaS'),
                                  ),
                                  Text(
                                    'ミートゥ',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'bananaS'),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 70),

                            SizedBox(
                              height: 250,
                              child: Column(
                                children: [
                                  MyTextField(
                                    controller: emailCon,
                                    keyboardType: 'mail',
                                    hintText: 'メールアドレス',
                                    obscureText: false,
                                  ),
                                  MyTextField(
                                    controller: passwordCon,
                                    keyboardType: 'pass',
                                    hintText: 'パスワード',
                                    obscureText: true,
                                  ),
                                ],
                              ),
                            ),

                            ButtonDesign(
                              text: 'LogIn',
                              toggle: emailCon.text != "" &&
                                      passwordCon.text.length >= 6
                                  ? true
                                  : false,
                              onTap: signIn,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterPage()));
                                },
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                      fontFamily: 'BananaS', fontSize: 20),
                                )),
                            //   Divider(),
                          ],
                        ),
                      ),
                    );
                  });
                }
              }),
        ),
      ),
    );
  }
}

class GoogleSignInWidget extends StatelessWidget {
  const GoogleSignInWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'SIGN UP / SIGN IN',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'bananaS'),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.white, //色
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(1, 1),
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
              ),
              child: InkWell(
                onTap: () => AuthService().signInWithGoogle(),
                splashColor: Colors.red,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image(
                    image: AssetImage("assets/images/google_logo.png"),
                    height: 50.0,
                  ),
                ),
              ),
            ),
          ),
          // ElevatedButton(
          //     onPressed: () async {
          //       UserCredential? userCredential =
          //           await handleSignIn();
          //       if (userCredential != null) {
          //         print(
          //             'Successfully signed in: ${userCredential.user!.displayName}');
          //       } else {
          //         print('Sign in failed.');
          //       }
          //     },
          //     child: Text('s')),
        ],
      ),
    );
  }
}
