import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    const APP_NAME = 'EV SPOT';
const DEFAULT_RADIUS = 10.0;

const COMPANY_TERMS =
    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\`s standard dummy text ever sine 1500s, when an unknown printer took a gallery type and scrambled it to make a type specimen book.';
const TERMS_CONDITIONS =
    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry.';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: false ? Colors.white : Colors.black),
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: false ? Colors.black : Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Terms & Conditions', style: boldTextStyle(size: 22)),
            SizedBox(height: 30),
            Text('Company\'s Terms of use', style: secondaryTextStyle(size: 16)),
            SizedBox(height: 8),
            Text(COMPANY_TERMS, style: primaryTextStyle(), textAlign: TextAlign.justify, strutStyle: StrutStyle(fontSize: 18)),
            SizedBox(height: 30),
            Text('Terms & Conditions', style: secondaryTextStyle(size: 16)),
            SizedBox(height: 8),
            Text(TERMS_CONDITIONS, style: primaryTextStyle(), textAlign: TextAlign.justify, strutStyle: StrutStyle(fontSize: 18)),
            SizedBox(height: 16),
            Text(TERMS_CONDITIONS, style: primaryTextStyle(), textAlign: TextAlign.justify, strutStyle: StrutStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
