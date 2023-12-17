import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '03_button_design.dart';
import '03_realtime_changes.dart';
import '03_textfield.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailCon = TextEditingController();
  final passwordCon = TextEditingController();
  final confirmCon = TextEditingController();

//signin
  void signUp() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
// /text.contains("World")
    try {
      if (passwordCon.text == confirmCon.text &&
          passwordCon.text.length >= 6 &&
          emailCon.text.contains('@')) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailCon.text,
          password: passwordCon.text,
        );
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailCon.text,
          password: passwordCon.text,
        );
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => UserInformation()));
        showErrorMessage('アカウントを生成しました');
      } else {
        //showErrorMes
        showErrorMessage('メールアドレスorパスワードが相違しています');
        // Navigator.pop(context);
      }

      // Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      showErrorMessage(e.code);
      Navigator.pop(context);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.greenAccent,
            title: Center(
              child: Text(
                message,
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height,
      child: Scaffold(
        // appBar: AppBar(
        //   flexibleSpace: Container(
        //     decoration: BoxDecoration(
        //       gradient: LinearGradient(
        //         colors: [Colors.redAccent, Colors.orangeAccent],
        //       ),
        //     ),
        //   ),
        //   title: Text(
        //     '新規登録',
        //     style: TextStyle(fontFamily: 'BananaS'),
        //   ),
        // ),
        body: SafeArea(
          child: Center(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
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
                                constraints: BoxConstraints(
                                    minHeight: constraints.maxHeight),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(height: 40),
                                    Text(
                                      //ttttttt@gmail.com
                                      'メールアドレスとパスワードを入力してください',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'bananaS'),
                                    ),
                                    SizedBox(
                                      height: 350,
                                      child: Column(
                                        children: [
                                          MyTextField(
                                            controller: emailCon,
                                            hintText:
                                                'メールアドレス ex)xxx@gmail.com',
                                            obscureText: false,
                                            keyboardType: 'mail',
                                          ),
                                          MyTextField(
                                            controller: passwordCon,
                                            hintText: 'パスワード ex)6文字以上',
                                            keyboardType: 'pass',
                                            obscureText: true,
                                          ),
                                          MyTextField(
                                            controller: confirmCon,
                                            hintText: 'もう1度同じパスワードを入力してください',
                                            keyboardType: 'pass',
                                            obscureText: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                    ButtonDesign(
                                      text: 'Sign Up',
                                      toggle: emailCon.text != "" &&
                                              passwordCon.text.length >= 6 &&
                                              passwordCon.text ==
                                                  confirmCon.text
                                          ? true
                                          : false,
                                      onTap: emailCon.text != "" &&
                                              passwordCon.text.length >= 6 &&
                                              passwordCon.text ==
                                                  confirmCon.text
                                          ? signUp
                                          : null,
                                    ),
                                    SizedBox(height: 10),
                                    ButtonDesign(
                                        toggle: true,
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        text: '戻る')
                                  ],
                                ),
                              ),
                            );
                          });
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//abc@gmail.com
