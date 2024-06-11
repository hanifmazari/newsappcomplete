import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:newsapp/utils/extenstion.dart';
import 'package:newsapp/view/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home()));
    });
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/splash.json', fit: BoxFit.fitWidth),
          (height * .05).h,
          Text("BaKhabbar News",
              style: GoogleFonts.roboto(
                  letterSpacing: .6,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.deepOrange[400])),
          (height * .1).h,
           Center(
              child: SpinKitWaveSpinner(
                color: Colors.deepOrange,
            trackColor: Colors.white,
            waveColor: Colors.blue,
            size: width*0.4,
            duration: const Duration(milliseconds: 4000),
            
          )),
        ],
      ),
    );
  }
}
