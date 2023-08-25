import 'package:age_calclulator/MyCalculator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WelcomeScreen(),
  ));
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        SizedBox(height: 20),
        Image(image: AssetImage("images/welcomepagePic.jpg")),
        SizedBox(
          height: 40,
        ),
        Text(
          'How Old Am I',
          style: GoogleFonts.varelaRound(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            textStyle: TextStyle(
              color: Color(0xff333300),
            ),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        SizedBox(
          width: 350,
          child: Center(
            child: Text(
              textAlign: TextAlign.center,
              'Check your currunt age based upon your date of date',
              style: GoogleFonts.varelaRound(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                textStyle: TextStyle(
                  color: Color(0xff660000),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 90,
        ),
        InkWell(
          onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return MyCalculator();
              },
            ));
          },
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.black12,
            child: Icon(
              Icons.navigate_next_outlined,
              color: Color(0xff333300),
              size: 30,
            ),
          ),
        )
      ]),
    );
  }
}
