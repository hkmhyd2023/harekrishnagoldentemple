import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:harekrishnagoldentemple/Bottom_Navigation/Bottom_Navigation.dart';
import 'package:harekrishnagoldentemple/Login/custom_widget/space.dart';
import 'package:harekrishnagoldentemple/Settings/EditProfile.dart';
import 'package:harekrishnagoldentemple/main.dart';
import 'package:harekrishnagoldentemple/Home/home.dart';
import 'package:harekrishnagoldentemple/Login/utils/colors.dart';
import 'package:harekrishnagoldentemple/Login/utils/constant.dart';
import 'package:pinput/pinput.dart';
import 'package:toast/toast.dart';

class LOTPVerificationScreen extends StatefulWidget {
  const LOTPVerificationScreen({Key? key}) : super(key: key);

  static String verify = "";

  @override
  State<LOTPVerificationScreen> createState() => _LOTPVerificationScreenState();
}

class _LOTPVerificationScreenState extends State<LOTPVerificationScreen> {
  final _otpFormKey = GlobalKey<FormState>();
  var code = "";

  late double screenHeight;
  late double screenWidth;

  void _showToast(BuildContext context, String text) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text("Wrong OTP"),
        action: SnackBarAction(
            label: 'CLOSE', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        iconTheme: IconThemeData(color: true ? whiteColor : blackColor),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.35,
              width: screenWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "OTP Verification",
                    style: TextStyle(
                        fontSize: mainTitleTextSize,
                        fontWeight: FontWeight.bold),
                  ),
                  Space(16),
                  Text("We have sent OTP to your mobile number",
                      style: TextStyle(fontSize: 16, color: subTitle)),
                ],
              ),
            ),
            Form(
              key: _otpFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Pinput(
                    length: 6,
                    // defaultPinTheme: defaultPinTheme,
                    // focusedPinTheme: focusedPinTheme,
                    // submittedPinTheme: submittedPinTheme,

                    showCursor: true,
                    onChanged: (value) {
                      code = value;
                    },
                  ),
                  Space(40),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(15),
                        textStyle: TextStyle(fontSize: 25),
                        shape: StadiumBorder(),
                      ),
                      onPressed: () async {
                        try {
                          // Create a PhoneAuthCredential with the code
                          PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(
                                  verificationId: LOTPVerificationScreen.verify,
                                  smsCode: code);

                          // Sign the user in (or link) with the credential
                          await FirebaseAuth.instance
                              .signInWithCredential(credential);
                          
                          if (FirebaseAuth.instance.currentUser!.displayName == null) {
                            FirebaseAuth.instance.currentUser!.updateDisplayName("Devotee${Random().nextInt(99)}${Random().nextInt(99)}${Random().nextInt(99)}${Random().nextInt(99)}");
                          }
                          
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => NaviBottomNavBar()),
                            (route) => false,
                          );
                        } catch (e) {
                          _showToast(context, "");
                        }
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
