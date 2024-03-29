import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:harekrishnagoldentemple/Seek_Divine_Blessings/YourSeva.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class SevaDetail extends StatefulWidget {
  final String dropdown_title;
  SevaDetail({Key? key, required this.dropdown_title}) : super(key: key);

  @override
  State<SevaDetail> createState() => _SevaDetailState();
}

class _SevaDetailState extends State<SevaDetail> {
  String _selectedItem = '';
  String _selectedItemPrice = '';
  List<String> _items = [];
  List<String> _prices = [];
  TextEditingController userNameController = TextEditingController();
  TextEditingController userGotraController = TextEditingController();
  TextEditingController userNakshatraController = TextEditingController();
  TextEditingController userDateOfSevaController = TextEditingController();

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();

  DateTime? selectedDate;

  bool eightyg_status = false;

  @override
  void initState() {
    super.initState();
    _fetchItemsFromFirestore();
  }

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
     _firestore.collection('Seva-Donation').doc("${FirebaseAuth.instance.currentUser!.uid}").collection("${FirebaseAuth.instance.currentUser!.uid}").doc('${FirebaseAuth.instance.currentUser!.uid}-${DateTime.now()}').set({
        'payid': response.paymentId,
        '80GREQ': eightyg_status,
        'Seva': _selectedItem,
        'DateOfSeva': userDateOfSevaController.text.toString(),
        'Email': '${FirebaseAuth.instance.currentUser!.email}',
        'Gotram': userGotraController.text.toString(),
        'Nakshatram': userNakshatraController.text.toString(),
        'Name': userNameController.text.toString(),
        'PhoneNo': '${FirebaseAuth.instance.currentUser!.phoneNumber}',
      });
      Navigator.of(context).push(MaterialPageRoute(
                                    builder: ((context) => YourSevaList())));
     
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    print ('Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}');
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {},
    );
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  String formatDate(String? dateTime,
      {String format = 'd MMM, yyyy',
      bool isFromMicrosecondsSinceEpoch = false}) {
    if (isFromMicrosecondsSinceEpoch) {
      return DateFormat(format).format(DateTime.fromMicrosecondsSinceEpoch(
          dateTime.validate().toInt() * 1000));
    } else {
      return DateFormat(format).format(DateTime.parse(dateTime.validate()));
    }
  }

  void selectDateAndTime(BuildContext context) async {
    selectedDate = DateTime.now();
    await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
      builder: (_, child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    ).then((date) async {
      if (date != null) {
        selectedDate = date;
        userDateOfSevaController.text =
            "${formatDate(selectedDate.toString(), format: 'd MMM, yyyy')}";
      }
    }).catchError((e) {
      toast(e.toString());
    });
  }

  Future<void> _fetchItemsFromFirestore() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Seva-Dropdown').doc(widget.dropdown_title).collection(widget.dropdown_title).get();

      setState(() {
        _items =
            querySnapshot.docs.map((doc) => doc['Title'] as String).toList();
        _prices =
            querySnapshot.docs.map((doc) => doc['Price'] as String).toList();
      });
    } catch (error) {
      print('Error fetching items: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        foregroundColor: black,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topCenter,
              colors: [
                Colors.deepOrange.withOpacity(0.9),
                Colors.white,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 1.12,
                child: Column(children: [
                  Text(
                    "Personalised seva's from anywhere!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Seva",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "*",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.red),
                      ),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: boxDecorationWithRoundedCorners(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(color: Colors.orange),
                            backgroundColor:
                                false ? cardDarkColor : Colors.transparent,
                          ),
                          padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            hint: Text('Select an Seva'),
                            underline: Container(
                              height: 0,
                              color: Colors.deepPurpleAccent,
                            ),
                            value:
                                _selectedItem.isNotEmpty ? _selectedItem : null,
                            onChanged: (String? value) {
  setState(() {
    _selectedItem = value ?? '';
    int index = _items.indexOf(value!);
    if (index != -1 && index < _prices.length) {
      _selectedItemPrice = _prices[index];
      print("Selected Item: $_selectedItem, Price: $_selectedItemPrice");
    } else {
      _selectedItemPrice = ''; // Set to empty string if price not found
      print("Price not found for $_selectedItem");
    }
  });
},

                            items: _items.map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                          ))),
    
                  SizedBox(height: 40),
                  Row(
                    children: [
                      Text(
                        "Name",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "*",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.red),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.orange)),
                      child: TextField(
                        controller: userNameController,
                        focusNode: f1,
                        keyboardType: TextInputType.name,
                        decoration: inputDecoration(
                          context,
                          hintText: "Name",
                          suffixIcon: Icon(Icons.person,
                              size: 16, color: false ? white : gray),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "Gotra",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.orange)),
                      child: TextField(
                        controller: userGotraController,
                        focusNode: f2,
                        keyboardType: TextInputType.name,
                        decoration: inputDecoration(
                          context,
                          hintText: "Gotra",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "Nakshatra",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.orange)),
                      child: TextField(
                        controller: userNakshatraController,
                        focusNode: f3,
                        keyboardType: TextInputType.name,
                        decoration: inputDecoration(
                          context,
                          hintText: "Nakshatra",
                          suffixIcon: Icon(Icons.star,
                              size: 16, color: false ? white : gray),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Text(
                        "Date Of Seva",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "*",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.red),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.orange)),
                      child: TextField(
                        controller: userDateOfSevaController,
                        focusNode: f4,
                        readOnly: true,
                        onTap: () {
                          selectDateAndTime(context);
                        },
                        decoration: inputDecoration(
                          context,
                          hintText: "Date of Seva",
                          suffixIcon: Icon(Icons.calendar_month_rounded,
                              size: 16, color: false ? white : gray),
                        ),
                      ),
                    ),
                  ),
                  30.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: eightyg_status,
                        onChanged: (value) => {
                          setState(
                            () {
                              eightyg_status = value!;
                            },
                          )
                        },
                      ),
                      Text(
                        "Include 80G Certificate",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      )
                    ],
                  ),
                  10.height,
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Razorpay razorpay = Razorpay();
                        var options = {
                          'key': 'rzp_live_D28gZ8qbA5LRbq',
                          'amount': '${_selectedItemPrice.toInt()*100}' ,
                          'name': 'Hare Krishna Golden Temple',
                          'description': 'Donating $_selectedItem',
                          'retry': {'enabled': true, 'max_count': 10},
                          'send_sms_hash': true,
                          'prefill': {
                            'name': '${userNameController.text.toString()}',
                            'contact': '${FirebaseAuth.instance.currentUser!.phoneNumber}',
                            'email': '${FirebaseAuth.instance.currentUser!.email}'
                          },
                          'external': {
                            'wallets': ['paytm']
                          },
                          'config': {
'display': {
'hide': [{'method': 'paylater'}]
}
}
                        };
                        razorpay.on(
                            Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                        razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                            handlePaymentSuccessResponse);
                        razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                            handleExternalWalletSelected);
                        razorpay.open(options);
                      },
                      child: Text("PAY NOW"),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            side: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
              ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

InputDecoration inputDecoration(
  BuildContext context, {
  IconData? prefixIcon,
  Widget? suffixIcon,
  String? labelText,
  double? borderRadius,
  String? hintText,
}) {
  return InputDecoration(
    counterText: "",
    contentPadding: EdgeInsets.only(left: 12, bottom: 10, top: 10, right: 10),
    labelText: labelText,
    labelStyle: secondaryTextStyle(),
    alignLabelWithHint: true,
    hintText: hintText.validate(),
    hintStyle: secondaryTextStyle(),
    isDense: true,
    prefixIcon: prefixIcon != null
        ? Icon(prefixIcon, size: 16, color: false ? white : gray)
        : null,
    suffixIcon: suffixIcon.validate(),
    enabledBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.transparent, width: 0.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.red, width: 0.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.red, width: 1.0),
    ),
    errorMaxLines: 2,
    errorStyle: primaryTextStyle(color: Colors.red, size: 12),
    focusedBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.transparent, width: 0.0),
    ),
    filled: true,
    fillColor: false ? cardDarkColor : Colors.transparent,
  );
}
