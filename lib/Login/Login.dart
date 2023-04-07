import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:harekrishnagoldentemple/Home/home.dart';
import 'package:harekrishnagoldentemple/Login/otp_login.dart';
import 'package:harekrishnagoldentemple/Login/Register.dart';
import 'package:harekrishnagoldentemple/Login/utils/constant.dart';
import 'package:harekrishnagoldentemple/Login/utils/widgets.dart';

import './custom_widget/space.dart';
import '../main.dart';
import './utils/colors.dart';
import './utils/images.dart';

class LogIn extends StatefulWidget {
  LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _loginFormKey = GlobalKey<FormState>();
  double screenHeight = 0.0;
  double screenWidth = 0.0;

  Country? _selectedCountry;

  @override
  void initState() {
    initCountry();
    super.initState();
  }

  void initCountry() async {
    final country = await getDefaultCountry(context);
    _selectedCountry = country;
    setState(() {});
  }

  bool checkPhoneNumber(String phoneNumber) {
    String regexPattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
    var regExp = RegExp(regexPattern);

    if (phoneNumber.isEmpty) {
      return false;
    } else if (regExp.hasMatch(phoneNumber)) {
      return true;
    }
    return false;
  }

  void _showCountryPicker() async {
    final country = await showCountryPickerSheet(context);
    if (country != null) {
      setState(() {
        _selectedCountry = country;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(statusBarIconBrightness: true ? Brightness.light : Brightness.dark),
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Space(60),
                  Text("Welcome back!", style: TextStyle(fontSize: mainTitleTextSize, fontWeight: FontWeight.bold)),
                  Space(8),
                  Text("Please Login to your account", style: TextStyle(fontSize: 14, color: subTitle)),
                  Space(16),
                  Image.asset(gopuram, width: 150, height: 150, fit: BoxFit.cover),
                ],
              ),
              Space(70),
              Form(
                key: _loginFormKey,
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  style: TextStyle(fontSize: 16),
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                  decoration: commonInputDecoration(
                    hintText: "Enter mobile number",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(16),
                      child: GestureDetector(
                        onTap: () => _showCountryPicker(),
                        child: Text(
                          _selectedCountry == null ? "+91" : _selectedCountry!.callingCode,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Space(16),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(16),
                    textStyle: TextStyle(fontSize: 16),
                    shape: StadiumBorder(),
                    backgroundColor: true ? Colors.black : Colors.black,
                  ),
                  onPressed: () {
                    if (_loginFormKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LOTPVerificationScreen()),
                      );
                    }
                  },
                  child: Text("Log In", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                ),
              ),
              Space(32),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have account?", style: TextStyle(fontSize: 16)),
                    Space(4),
                    Text('Sign Up', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
              ),
         ]),
        ),
      ),
    );
  }
}
