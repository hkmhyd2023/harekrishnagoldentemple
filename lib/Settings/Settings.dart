import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:harekrishnagoldentemple/Bottom_Navigation/Bottom_Navigation.dart';
import 'package:harekrishnagoldentemple/Home/home.dart';
import 'package:harekrishnagoldentemple/Home/widgets/app_drawer_component.dart';
import 'package:harekrishnagoldentemple/Login/Login.dart';
import 'package:harekrishnagoldentemple/Settings/BecomeVolunteer.dart';
import 'package:harekrishnagoldentemple/Settings/EditProfile.dart';
import 'package:harekrishnagoldentemple/faq_screen.dart';
import 'package:harekrishnagoldentemple/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path/path.dart';
import 'package:shimmer/shimmer.dart';

class CustomDialogExample2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: context.cardColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0)),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('Dear Devotee',
                      style: boldTextStyle(color: Colors.black, size: 22)),
                ),
                GestureDetector(
                  onTap: () {
                    finish(context);
                  },
                  child: Container(
                      padding: EdgeInsets.all(16),
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.close, color: Colors.black)),
                ),
              ],
            ),
            Image(
                image: NetworkImage('https://media.istockphoto.com/id/498126333/photo/time-concept.jpg?s=612x612&w=0&k=20&c=glaehSks9NM-SadXPSUFu481PeOKcbI6RLTfxNbGIXQ='),
                height: 100,
                width: 170,
                fit: BoxFit.cover),
            24.height,
            Text('Hare Krishna 🙏🏻',
                style: boldTextStyle(color: Colors.black, size: 24)),
            16.height,
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text("Session Expiered Please Re-Login To Delete Account",
                  style: secondaryTextStyle(color: Colors.black)),
            ),
            30.height,
          ],
        ),
      ),
    );
  }
}

class CustomDialogExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: context.cardColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0)),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('Dear Devotee 🙏🏻',
                      style: boldTextStyle(color: Colors.black, size: 22)),
                ),
                GestureDetector(
                  onTap: () {
                    finish(context);
                  },
                  child: Container(
                      padding: EdgeInsets.all(16),
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.close, color: Colors.black)),
                ),
              ],
            ),
            Image(
                image: AssetImage('assets/widgettrophy.png'),
                height: 120,
                width: 190,
                fit: BoxFit.cover),
            24.height,
            Text('Hare Krishna 🙏🏻',
                style: boldTextStyle(color: Colors.black, size: 24)),
            16.height,
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text(
                  "We will really miss you a lot, do you still want to leave us? Can you Give Us A Second Chance?",
                  style: secondaryTextStyle(color: Colors.black)),
            ),
            30.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(""),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        finish(context);
                      },
                      child: Text(
                        "CANCEL",
                        style: TextStyle(color: Colors.green),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, elevation: 0),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        FirebaseFirestore.instance
                            .collection("Japa")
                            .doc('${FirebaseAuth.instance.currentUser?.uid}')
                            .delete();

                        FirebaseFirestore.instance
                            .collection("Users")
                            .doc('${FirebaseAuth.instance.currentUser?.uid}')
                            .delete();
                        // Delete the user account
                        try {
                          await FirebaseAuth.instance.currentUser!.delete();
                          
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: ((context) => LogIn())));
                        } catch (
                          e
                        ) {
showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomDialogExample2());
                        }
                      },
                      child: Text(
                        "DELETE",
                        style: TextStyle(color: Colors.red),
                      ),
                      style: ElevatedButton.styleFrom(
                          elevation: 0, backgroundColor: Colors.white),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SettingItemWidget extends StatelessWidget {
  final String title;
  final double? width;
  final String? subTitle;
  final Widget? leading;
  final Widget? trailing;
  final TextStyle? titleTextStyle;
  final TextStyle? subTitleTextStyle;
  final Function? onTap;
  final EdgeInsets? padding;
  final int paddingAfterLeading;
  final int paddingBeforeTrailing;
  final Color? titleTextColor;
  final Color? subTitleTextColor;
  final Color? hoverColor;
  final Color? splashColor;
  final Decoration? decoration;
  final double? borderRadius;
  final BorderRadius? radius;

  SettingItemWidget({
    required this.title,
    this.onTap,
    this.width,
    this.subTitle = '',
    this.leading,
    this.trailing,
    this.titleTextStyle,
    this.subTitleTextStyle,
    this.padding,
    this.paddingAfterLeading = 16,
    this.paddingBeforeTrailing = 16,
    this.titleTextColor,
    this.subTitleTextColor,
    this.decoration,
    this.borderRadius,
    this.hoverColor,
    this.splashColor,
    this.radius,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: decoration ?? BoxDecoration(),
      child: Row(
        children: [
          leading ?? SizedBox(),
          if (leading != null) paddingAfterLeading.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.validate(),
                style: titleTextStyle ??
                    boldTextStyle(
                        color: titleTextColor ?? textPrimaryColorGlobal),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              4.height.visible(subTitle.validate().isNotEmpty),
              if (subTitle.validate().isNotEmpty)
                Text(
                  subTitle!,
                  style: subTitleTextStyle ??
                      secondaryTextStyle(
                        color: subTitleTextColor ?? textSecondaryColorGlobal,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ).expand(),
          if (trailing != null) paddingBeforeTrailing.width,
          trailing ?? SizedBox(),
        ],
      ),
    ).onTap(
      onTap,
      borderRadius: radius ?? (BorderRadius.circular(borderRadius.validate())),
      hoverColor: hoverColor,
      splashColor: splashColor,
    );
  }
}

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  TextStyle boldTextStyle({
    int? size,
    Color? color,
    FontWeight? weight,
    String? fontFamily,
    double? letterSpacing,
    FontStyle? fontStyle,
    double? wordSpacing,
    TextDecoration? decoration,
    TextDecorationStyle? textDecorationStyle,
    TextBaseline? textBaseline,
    Color? decorationColor,
    Color? backgroundColor,
    double? height,
  }) {
    return TextStyle(
      fontSize: size != null ? size.toDouble() : 16,
      color: color ?? Colors.black,
      fontWeight: weight ?? FontWeight.w500,
      letterSpacing: letterSpacing,
      fontStyle: fontStyle,
      decoration: decoration,
      decorationStyle: textDecorationStyle,
      decorationColor: decorationColor,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      backgroundColor: backgroundColor,
      height: height,
    );
  }

  final picker = ImagePicker();
  File? _imageFile;
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(color: white),),
        backgroundColor: Colors.blue.shade300,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            SizedBox(height: 16),
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: FirebaseAuth.instance.currentUser?.photoURL ??
                      "https://cdn.pixabay.com/photo/2016/01/03/00/43/upload-1118929__340.png",
                  imageBuilder: (context, imageProvider) => Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                    ),
                  ),
                  height: 100,
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(color: Colors.black.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: GestureDetector(
                      child: Icon(Icons.edit, color: Colors.white, size: 16),
                      onTap: () async {
                        if (FirebaseAuth.instance.currentUser != null) {
                          final picker = ImagePicker();
                        final pickedFile =
                            await picker.getImage(source: ImageSource.gallery);

                        if (pickedFile != null) {
                          File image = File(pickedFile.path);

                          String fileName =
                              DateTime.now().millisecondsSinceEpoch.toString();
                          Reference reference = FirebaseStorage.instance
                              .ref()
                              .child('ProfileImages')
                              .child(fileName);

                          await reference.putFile(image);
                          String downloadURL = await reference.getDownloadURL();
                          FirebaseAuth.instance.currentUser
                              ?.updatePhotoURL(downloadURL);
                          print('Download URL: $downloadURL');
                        }
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NaviBottomNavBar()));
                        } else {
                          showDialog(context: context, builder: (BuildContext context) => CustomDialogExample3());
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(FirebaseAuth.instance.currentUser?.displayName ?? "Devotee",
                style: boldTextStyle(size: 18)),
            SizedBox(height: 8),
            Text(FirebaseAuth.instance.currentUser?.phoneNumber ??
                ""),
            SizedBox(height: 16),
            Divider(height: 0),
            SizedBox(height: 16),
            SettingItemWidget(
              leading: Icon(Icons.person_outline, color: context.iconColor),
              title: "Edit Profile",
              titleTextStyle: boldTextStyle(),
              onTap: () {
                if (FirebaseAuth.instance.currentUser == null) {
                  showDialog(context: context, builder: (BuildContext context) => CustomDialogExample3());
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditProfile()));
                }
                
              },
              trailing: Icon(Icons.arrow_forward_ios_rounded,
                  size: 18, color: context.iconColor),
            ),
            SettingItemWidget(
              leading: Icon(Icons.question_answer, color: context.iconColor),
              title: "Faqs",
              titleTextStyle: boldTextStyle(),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => FaqScreen()));
              },
              trailing: Icon(Icons.arrow_forward_ios_rounded,
                  size: 18, color: context.iconColor),
            ),
            SettingItemWidget(
              leading: Icon(Icons.library_add, color: context.iconColor),
              title: "My Playlist",
              titleTextStyle: boldTextStyle(),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ComingSoonPage()));
              },
              trailing: Icon(Icons.arrow_forward_ios_rounded,
                  size: 18, color: context.iconColor),
            ),
            SettingItemWidget(
              leading: Icon(Icons.handshake, color: context.iconColor),
              title: "Become a Volunteer",
              titleTextStyle: boldTextStyle(),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => BAV()));
              },
              trailing: Icon(Icons.arrow_forward_ios_rounded,
                  size: 18, color: context.iconColor),
            ),
            SettingItemWidget(
              leading: Icon(Icons.logout, color: context.iconColor),
              title: "Logout",
              titleTextStyle: boldTextStyle(),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: ((context) => LogIn())));
              },
              trailing: Icon(Icons.arrow_forward_ios_rounded,
                  size: 18, color: context.iconColor),
            ),
            SettingItemWidget(
              leading: FaIcon(FontAwesomeIcons.trash, color: context.iconColor),
              title: "Delete Account",
              titleTextStyle: boldTextStyle(),
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomDialogExample());
              },
              trailing: Icon(Icons.arrow_forward_ios_rounded,
                  size: 18, color: context.iconColor),
            ),
            SizedBox(
              height: 0,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 210,
                    width: context.width(),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                            color: context.cardColor,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/gopuram.png',
                                color: Colors.blue,
                                height: 40,
                                width: 40,
                              ),
                              8.height,
                              Text('HKM Hyderabad',
                                  style: boldTextStyle(size: 20)),
                              8.height,
                              Text(
                                'Hare Krishna Golden Temple',
                                style: TextStyle(fontSize: 12),
                              ),
                              8.height,
                              TextIcon(
                                edgeInsets: EdgeInsets.only(
                                    left: 0, right: 8, bottom: 4, top: 4),
                                prefix: Icon(Icons.call, size: 14),
                                text: "+91 04023326999",
                                textStyle: primaryTextStyle(size: 14),
                              ),
                              TextIcon(
                                edgeInsets: EdgeInsets.only(
                                    left: 0, right: 8, bottom: 4, top: 4),
                                prefix: Icon(Icons.web, size: 14),
                                text: "www.hkmhyderabad.org",
                                textStyle: primaryTextStyle(size: 14),
                              ),
                              TextIcon(
                                edgeInsets: EdgeInsets.only(
                                    left: 0, right: 8, bottom: 4, top: 4),
                                prefix:
                                    Icon(Icons.location_on_outlined, size: 14),
                                text: "Hyderabad, Telangana",
                                textStyle: primaryTextStyle(size: 14),
                              ),
                            ],
                          ),
                        ).expand(),
                        Container(
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    } else {
return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            SizedBox(height: 16),
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: FirebaseAuth.instance.currentUser?.photoURL ??
                      "https://cdn.pixabay.com/photo/2016/01/03/00/43/upload-1118929__340.png",
                  imageBuilder: (context, imageProvider) => Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                    ),
                  ),
                  height: 100,
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(color: Colors.black.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: GestureDetector(
                      child: Icon(Icons.edit, color: Colors.white, size: 16),
                      onTap: () async {
                        if (FirebaseAuth.instance.currentUser != null) {
                          final picker = ImagePicker();
                        final pickedFile =
                            await picker.getImage(source: ImageSource.gallery);

                        if (pickedFile != null) {
                          File image = File(pickedFile.path);

                          String fileName =
                              DateTime.now().millisecondsSinceEpoch.toString();
                          Reference reference = FirebaseStorage.instance
                              .ref()
                              .child('ProfileImages')
                              .child(fileName);

                          await reference.putFile(image);
                          String downloadURL = await reference.getDownloadURL();
                          FirebaseAuth.instance.currentUser
                              ?.updatePhotoURL(downloadURL);
                          print('Download URL: $downloadURL');
                        }
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NaviBottomNavBar()));
                        } else {
                          showDialog(context: context, builder: (BuildContext context) => CustomDialogExample3());
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(FirebaseAuth.instance.currentUser?.displayName ?? "Devotee",
                style: boldTextStyle(size: 18)),
            SizedBox(height: 8),
            Text(FirebaseAuth.instance.currentUser?.phoneNumber ??
                ""),
            SizedBox(height: 16),
            Divider(height: 0),
            SizedBox(height: 16),
            SettingItemWidget(
              leading: Icon(Icons.person_outline, color: context.iconColor),
              title: "Edit Profile",
              titleTextStyle: boldTextStyle(),
              onTap: () {
                if (FirebaseAuth.instance.currentUser == null) {
                  showDialog(context: context, builder: (BuildContext context) => CustomDialogExample3());
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditProfile()));
                }
                
              },
              trailing: Icon(Icons.arrow_forward_ios_rounded,
                  size: 18, color: context.iconColor),
            ),
            SettingItemWidget(
              leading: Icon(Icons.question_answer, color: context.iconColor),
              title: "Faqs",
              titleTextStyle: boldTextStyle(),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => FaqScreen()));
              },
              trailing: Icon(Icons.arrow_forward_ios_rounded,
                  size: 18, color: context.iconColor),
            ),
            SettingItemWidget(
              leading: Icon(Icons.library_add, color: context.iconColor),
              title: "My Playlist",
              titleTextStyle: boldTextStyle(),
              onTap: () {
                if (FirebaseAuth.instance.currentUser == null) {
                  showDialog(context: context, builder: (BuildContext context) => CustomDialogExample3());
                }
              },
              trailing: Icon(Icons.arrow_forward_ios_rounded,
                  size: 18, color: context.iconColor),
            ),
            SettingItemWidget(
              leading: Icon(Icons.handshake, color: context.iconColor),
              title: "Become a Volunteer",
              titleTextStyle: boldTextStyle(),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => BAV()));
              },
              trailing: Icon(Icons.arrow_forward_ios_rounded,
                  size: 18, color: context.iconColor),
            ),
            SettingItemWidget(
              leading: Icon(Icons.logout, color: context.iconColor),
              title: "Log In",
              titleTextStyle: boldTextStyle(),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: ((context) => LogIn())));
              },
              trailing: Icon(Icons.arrow_forward_ios_rounded,
                  size: 18, color: context.iconColor),
            ),
            
            SizedBox(
              height: 0,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 210,
                    width: context.width(),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                            color: context.cardColor,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/gopuram.png',
                                color: Colors.blue,
                                height: 40,
                                width: 40,
                              ),
                              8.height,
                              Text('HKM Hyderabad',
                                  style: boldTextStyle(size: 20)),
                              8.height,
                              Text(
                                'Hare Krishna Golden Temple',
                                style: TextStyle(fontSize: 12),
                              ),
                              8.height,
                              TextIcon(
                                edgeInsets: EdgeInsets.only(
                                    left: 0, right: 8, bottom: 4, top: 4),
                                prefix: Icon(Icons.call, size: 14),
                                text: "+91 04023326999",
                                textStyle: primaryTextStyle(size: 14),
                              ),
                              TextIcon(
                                edgeInsets: EdgeInsets.only(
                                    left: 0, right: 8, bottom: 4, top: 4),
                                prefix: Icon(Icons.web, size: 14),
                                text: "www.hkmhyderabad.org",
                                textStyle: primaryTextStyle(size: 14),
                              ),
                              TextIcon(
                                edgeInsets: EdgeInsets.only(
                                    left: 0, right: 8, bottom: 4, top: 4),
                                prefix:
                                    Icon(Icons.location_on_outlined, size: 14),
                                text: "Hyderabad, Telangana",
                                textStyle: primaryTextStyle(size: 14),
                              ),
                            ],
                          ),
                        ).expand(),
                        Container(
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    };
  } 
}
