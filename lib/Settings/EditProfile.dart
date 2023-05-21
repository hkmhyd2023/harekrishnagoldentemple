import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:harekrishnagoldentemple/Bottom_Navigation/Bottom_Navigation.dart';
import 'package:harekrishnagoldentemple/main.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path/path.dart';
import 'package:restart_app/restart_app.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController first_name = TextEditingController();
  final picker = ImagePicker();
  File? _imageFile;
  bool _isUploading = false;
  String dropdownValue = 'Male';
  String preacherValue = 'Select Japa Coordinator';
  String giftCenterValue = 'Select Gifts Center';

  TextEditingController userNameController = TextEditingController();
  TextEditingController userNickNameController = TextEditingController();
  TextEditingController userDateOfBirthController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userContactNumberController = TextEditingController();
  TextEditingController userGenderController = TextEditingController();
  TextEditingController userDateOfAnniverserryController = TextEditingController();
  DateTime? selectedDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) {
      try {
        setState(() {
        userNameController.text = value['Name'] ?? "";
      userDateOfBirthController.text = value['Date'] ?? "";
      userEmailController.text = value['Email'] ?? "";
      userGenderController.text = value['Gender'] ?? "Male";
      userDateOfAnniverserryController.text = value['DOA'] ?? "";
      dropdownValue = value['Gender'] ?? "Male";
      giftCenterValue = value['Gift-Center'] ?? "Select Gifts Center";
      preacherValue = value['Preacher'] ?? "Select Japa Coordinator";

      });
      } catch(e) {
        print(e);
      }
    });

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
    await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1896),
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
        userDateOfBirthController.text =
            "${formatDate(selectedDate.toString(), format: 'd MMM, yyyy')}";
      }
    }).catchError((e) {
      toast(e.toString());
    });
  }

  void selectDateAndTime2(BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1896),
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
        userDateOfAnniverserryController.text =
            "${formatDate(selectedDate.toString(), format: 'd MMM, yyyy')}";
      }
    }).catchError((e) {
      toast(e.toString());
    });
  }

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();
  FocusNode f5 = FocusNode();
  FocusNode f6 = FocusNode();
  FocusNode f7 = FocusNode();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  Future<void> _pickImageAndUpload() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(pickedFile!.path);
      _isUploading = true;
    });
    final storage = FirebaseStorage.instance;
    final filename = basename(_imageFile!.path);
    final uploadTask = storage
        .ref()
        .putFile(_imageFile!);
    final snapshot = await uploadTask;
    final downloadUrl = await snapshot.ref.getDownloadURL();
    setState(() {
      _isUploading = false;
      _imageFile = null;
    });
    FirebaseAuth.instance.currentUser?.updatePhotoURL(downloadUrl);
    print('Download URL: $downloadUrl');
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _pickImageAndUpload2() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _imageFile = File(pickedFile!.path);
        _isUploading = true;
      });
      final storage = FirebaseStorage.instance;
      final filename = basename(_imageFile!.path);
      final uploadTask = storage
          .ref()
          .putFile(_imageFile!);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        _isUploading = false;
        _imageFile = null;
      });
      FirebaseAuth.instance.currentUser?.updatePhotoURL(downloadUrl);
      print('Download URL: $downloadUrl');
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => NaviBottomNavBar()));
      Restart.restartApp();
    }

    return Scaffold(
      appBar: appBar(context, 'Edit Profile', color: white),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FirebaseAuth.instance.currentUser?.photoURL == null
                        ? CircleAvatar(
                            radius: 90,
                            backgroundColor: Colors.grey[300],
                            child: IconButton(
                              icon: Icon(Icons.add_a_photo),
                              iconSize: 70,
                              onPressed: _pickImageAndUpload,
                            ),
                          )
                        : Stack(
                            alignment: Alignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                      final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File image = File(pickedFile.path);

      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference = FirebaseStorage.instance.ref().child('ProfileImages').child(fileName);

      await reference.putFile(image);
      String downloadURL = await reference.getDownloadURL();
      FirebaseAuth.instance.currentUser?.updatePhotoURL(downloadURL);
      print('Download URL: $downloadURL');
    }
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => NaviBottomNavBar()));
                                },
                                child: CircleAvatar(
                                  radius: 100,
                                  backgroundImage: NetworkImage(
                                      '${FirebaseAuth.instance.currentUser?.photoURL}'),
                                ),
                              ),
                              _isUploading
                                  ? CircularProgressIndicator()
                                  : SizedBox.shrink(),
                            ],
                          ),
                  ],
                ),
                Column(children: [
                  SizedBox(height: 30),
                  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                            padding: EdgeInsets.fromLTRB(10,2,10,2),
              decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(20),
                 border: Border.all(color: Colors.orange)
              ),
              child: TextField(
                keyboardType: TextInputType.name,
                
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Full Name",
                  
                ),
  controller: userNameController,
              ),
            ),
          ),
                  SizedBox(height: 20),
                  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.fromLTRB(10,2,10,2),
              decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(20),
                 border: Border.all(color: Colors.orange)
              ),
              child: TextField(
                    controller: userDateOfBirthController,
                    focusNode: f3,
                    readOnly: true,
                    onTap: () {
                      selectDateAndTime(context);
                    },
                    decoration: inputDecoration(
                      context,
                      hintText: "Date of Birth",
                      suffixIcon: Icon(Icons.calendar_month_rounded,
                          size: 16, color: false ? white : gray),
                    ),
                    
                  ),
                  
            ),
          ),
            Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.fromLTRB(10,2,10,2),
              decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(20),
                 border: Border.all(color: Colors.orange)
              ),
              child: TextField(
                    controller: userDateOfAnniverserryController,
                    focusNode: f7,
                    readOnly: true,
                    onTap: () {
                      selectDateAndTime2(context);
                    },
                    decoration: inputDecoration(
                      context,
                      hintText: "Date Of Anniversary",
                      suffixIcon: Icon(Icons.calendar_month_rounded,
                          size: 16, color: false ? white : gray),
                    ),
                    
                  ),
                  
            ),
          ),      
                  SizedBox(height: 20),
                  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.fromLTRB(10,2,10,2),
              decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(20),
                 border: Border.all(color: Colors.orange)
              ),
              child:  TextField(
                    controller: userEmailController,
                    focusNode: f4,
                    keyboardType: TextInputType.emailAddress,
                    decoration: inputDecoration(
                      context,
                      hintText: "Email",
                      suffixIcon: Icon(Icons.mail_outline_rounded,
                          size: 16, color: false ? white : gray),
                    ),
                  ),
            ),
          ),
                 
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: boxDecorationWithRoundedCorners(
                        borderRadius:
                            BorderRadius.all(Radius.circular(20)),
                        border: Border.all(color: Colors.orange),
                        backgroundColor: false ? cardDarkColor : Color(0xFFF8F8F8),
                      ),
                      padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        elevation: 16,
                        style: primaryTextStyle(),
                        hint: Text('Gender', style: primaryTextStyle()),
                        isExpanded: true,
                        underline: Container(
                          height: 0,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            dropdownValue = newValue.toString();
                          });
                        },
                        items: <String>['Male', 'Female', 'Other']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('Gift-Centers').snapshots(), builder: (context, snapshot) {
                      List<DropdownMenuItem<String>> giftCenterItems = [];

                      if(!snapshot.hasData) {

                      } else {
                        final giftCenter = snapshot.data!.docs.toList();
                        for (var center in giftCenter) {
                          giftCenterItems.add(DropdownMenuItem<String>(value: center['Name'].toString(), child: Text(center['Name'].toString()),));
                        }
                      }
                      return  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: boxDecorationWithRoundedCorners(
                        borderRadius:
                            BorderRadius.all(Radius.circular(20)),
                        border: Border.all(color: Colors.orange),
                        backgroundColor: false ? cardDarkColor : Color(0xFFF8F8F8),
                      ),
                      padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                      child: DropdownButton<String>(
                        value: giftCenterValue,
                        elevation: 16,
                        style: primaryTextStyle(),
                        hint: Text('Select Gifts Center', style: primaryTextStyle()),
                        isExpanded: true,
                        underline: Container(
                          height: 0,
                          color: Colors.deepPurpleAccent,
                        ),

                        onChanged: (newValue) {
                          setState(() {
                            giftCenterValue = newValue.toString();
                            print (giftCenterValue);
                          });
                        },
                        items: giftCenterItems,
                      ),
                    ),
                  );
                  },),
                  StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('Preachers').snapshots(), builder: (context, snapshot) {
                      List<DropdownMenuItem<String>> preacherItems = [];

                      if(!snapshot.hasData) {

                      } else {
                        final preachers = snapshot.data!.docs.toList();
                        for (var preacher in preachers) {
                          preacherItems.add(DropdownMenuItem<String>(value: preacher['Name'].toString(), child: Text(preacher['Name'].toString()),));
                        }
                      }
                      return  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: boxDecorationWithRoundedCorners(
                        borderRadius:
                            BorderRadius.all(Radius.circular(20)),
                        border: Border.all(color: Colors.orange),
                        backgroundColor: false ? cardDarkColor : Color(0xFFF8F8F8),
                      ),
                      padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                      child: DropdownButton<String>(
                        value: preacherValue,
                        elevation: 16,
                        style: primaryTextStyle(),
                        hint: Text('Select Japa Coordinator', style: primaryTextStyle()),
                        isExpanded: true,
                        underline: Container(
                          height: 0,
                          color: Colors.deepPurpleAccent,
                        ),

                        onChanged: (newValue) {
                          setState(() {
                            preacherValue = newValue.toString();
                          });
                        },
                        items: preacherItems,
                      ),
                    ),
                  );
                  },),
                 
                ]),
                
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(onPressed: () async {
                    try {
                      await FirebaseAuth.instance.currentUser?.updateDisplayName(userNameController.text);
                      await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser?.uid).set({
                        "Name": userNameController.text,
                        "Date": userDateOfBirthController.text,
                        "Email": userEmailController.text,
                        "Gender": dropdownValue,
                      });

                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => NaviBottomNavBar()));

                    } catch (e) {
                      print ("E");
                      await FirebaseAuth.instance.currentUser?.updateEmail(userEmailController.text);

                      await FirebaseAuth.instance.currentUser?.updateDisplayName(userNameController.text);
                      await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser?.uid).set({
                        "Name": userNameController.text,
                        "Date": userDateOfBirthController.text,
                        "Email": userEmailController.text,
                        "Gender": dropdownValue,
                        "DOA": userDateOfAnniverserryController,
                        "Gift-Center": giftCenterValue,
                        "Preacher": preacherValue
                      });
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  NaviBottomNavBar()));
                    }
                  }, child: Text("Update", style: TextStyle(color: Colors.white)),           style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange 
                            // This is what you need!
                          ),
                ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget appBarTitleWidget(context, String title,
      {Color? color, Color? textColor}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      color: color,
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: boldTextStyle(color: textColor, size: 20),
            maxLines: 1,
          ).expand(),
        ],
      ),
    );
  }

  AppBar appBar(BuildContext context, String title,
      {List<Widget>? actions,
      bool showBack = true,
      Color? color,
      Color? iconColor,
      Color? textColor}) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: color,
      leading: showBack
          ? IconButton(
              onPressed: () {
                finish(context);
              },
              icon: Icon(Icons.arrow_back, color: false ? white : black),
            )
          : null,
      title:
          appBarTitleWidget(context, title, textColor: textColor, color: color),
      actions: actions,
      elevation: 0.5,
    );
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
      fillColor: false ? cardDarkColor : Color(0xFFF8F8F8),
    );
  }
}
