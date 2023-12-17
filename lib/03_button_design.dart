import 'package:flutter/material.dart';

class ButtonDesign extends StatelessWidget {
  final Function()? onTap;
  final String? text;
  final bool toggle;
  const ButtonDesign(
      {super.key,
      required this.onTap,
      required this.text,
      required this.toggle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggle == false ? null : onTap,
      child: Container(
        padding: EdgeInsets.all(25),
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(80),
          gradient: LinearGradient(
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
            colors: [
              toggle == false
                  ? const Color(0xFFFFFF).withOpacity(0.9)
                  : const Color(0xffe4a972).withOpacity(0.9),
              toggle == false
                  ? Color.fromARGB(255, 211, 223, 225).withOpacity(0.6)
                  : Color.fromARGB(255, 41, 144, 162).withOpacity(0.6)
            ],
            stops: const [
              0.0,
              1.0,
            ],
          ),
        ),
        child: Center(
          child: Text(
            text ?? "",
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'bananaS',
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

// BoxDecoration(
//             gradient: LinearGradient(
//               begin: FractionalOffset.topLeft,
//               end: FractionalOffset.bottomRight,
//               colors: [
//                 const Color(0xffe4a972).withOpacity(0.6),
//                 Color.fromARGB(255, 41, 144, 162).withOpacity(0.6),
//               ],
//               stops: const [
//                 0.0,
//                 1.0,
//               ],
//             ),
//           ),