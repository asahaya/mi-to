import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '03_auth_service.dart';
import '03_realtime_changes.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
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
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                              'ミートゥー',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'bananaS'),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Expanded(
                        flex: 3,
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
                                      image: AssetImage(
                                          "assets/images/google_logo.png"),
                                      height: 70.0,
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
                      ),
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }
}
