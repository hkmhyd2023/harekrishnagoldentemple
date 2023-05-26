// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, sort_child_properties_last, unnecessary_new, prefer_const_constructors, depend_on_referenced_packages

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:harekrishnagoldentemple/NoInternet.dart';
import 'package:harekrishnagoldentemple/RoutePages/Japathon.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

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
                  child: Text('Rounds Updated',
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
            Text('Hari Bol!!!',
                style: boldTextStyle(color: Colors.black, size: 24)),
            16.height,
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text("You are getting closer to the Lord",
                  style: secondaryTextStyle(color: Colors.black)),
            ),
            30.height,
          ],
        ),
      ),
    );
  }
}

class JapaPage extends StatefulWidget {
  JapaPage({Key? key}) : super(key: key);

  _JapaPageState createState() => _JapaPageState();
}

class _JapaPageState extends State<JapaPage> {

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult connectivityResult;
    try {
      connectivityResult = await _connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile) {
        setState(() {});
      } else if (connectivityResult == ConnectivityResult.wifi) {
        setState(() {});
      } else if (connectivityResult == ConnectivityResult.none) {
        setState(() {});
      }
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status');
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(connectivityResult);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  TextEditingController _date = TextEditingController();
  TextEditingController _rounds = TextEditingController();
  List<DocumentSnapshot> _data = [];
  void _getDataFromFirestore() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('my_collection').get();
    setState(() {
      _data = snapshot.docs;
    });
  }

  Widget mHeading(var value) {
    return Text(value, style: boldTextStyle());
  }

  Widget text(
    String? text, {
    var fontSize = 18.0,
    Color? textColor,
    var fontFamily,
    var isCentered = false,
    var maxLine = 1,
    var latterSpacing = 0.5,
    bool textAllCaps = false,
    var isLongText = false,
    bool lineThrough = false,
  }) {
    return Text(
      textAllCaps ? text!.toUpperCase() : text!,
      textAlign: isCentered ? TextAlign.center : TextAlign.start,
      maxLines: isLongText ? null : maxLine,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        color: textColor,
        height: 1.5,
        letterSpacing: latterSpacing,
        decoration:
            lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var cardHight = (width - 32) * (9 / 16);
      return _connectionStatus==ConnectivityResult.none? NoInternet() : Scaffold(
      backgroundColor: Colors.white,

      ///
      /// Appbar
      ///
      appBar: AppBar(
        title: Text(
          "Japa Yagna",
          style: TextStyle(
              color: Colors.black, fontFamily: "Popins", fontSize: 17.0),
        ),
        centerTitle: true,
        brightness: Brightness.dark,
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.orange),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 5.0,
          ),

          ///
          /// Custom tab bar
          ///
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: new Scaffold(
                backgroundColor: Colors.transparent,
                appBar: PreferredSize(
                  preferredSize:
                      Size.fromHeight(42.0), // here the desired height
                  child: new AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    centerTitle: true,
                    automaticallyImplyLeading: false,
                    title: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(75.0)),
                          border: Border.all(color: Colors.white),
                          color: Colors.black26),
                      child: new TabBar(
                        indicatorColor: Colors.orange,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.white54,
                        indicator: ShapeDecoration.fromBoxDecoration(
                            BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                color: Colors.orange)),
                        tabs: [
                          Tab(
                            child: Text(
                              "Counter",
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          Tab(
                              child: Text(
                            "Cards",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w300,
                            ),
                          )),
                          Tab(
                              child: Text(
                            "Rankings",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w300,
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                ),

                ///
                /// Body tabBar
                ///
                body: TabBarView(
                  children: [
                    Align(child: SingleChildScrollView(child: Padding(padding: EdgeInsets.all(8.0), child: Column(children: [
                      StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection('Japa-Yagna').doc('Detail-Image').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
                    child: Container(
                      height: 250.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(80.0)),
                          boxShadow: [BoxShadow(color: Colors.black12.withOpacity(0.1), blurRadius: 3.0, spreadRadius: 1.0)]),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          width: double.infinity, // Adjust the width of the container according to your needs
                          height: 200, // Adjust the height of the container according to your needs
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  );
                }

                final data = snapshot.data!.data() as Map<String, dynamic>?;
                final imageUrl = data?['Image'] as String?;
                if (imageUrl == null) {
                  return const Center(child: Text('No image available'));
                }

                return GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        height: 255,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
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
                          width: double.infinity, // Adjust the width of the container according to your needs
                          height: 255, // Adjust the height of the container according to your needs
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
                          SizedBox(
                            height: 20,
                          ),
TextField(
                            controller: _rounds,
                            style: primaryTextStyle(),

                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(80)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              labelText: 'No. Of Rounds',
                              labelStyle: primaryTextStyle(size: 14),
                              filled: true,
                            ),
                            // ignore: dead_code
                            cursorColor: false ? white : blackColor,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () async {
                              DateTime? pickeddate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime.now());
                              if (pickeddate != null) {
                                setState(() {
                                  _date.text = DateFormat('yyyy-MM-dd')
                                      .format(pickeddate);
                                });
                              }
                            },
                            child: TextField(
                              controller: _date,
                              style: primaryTextStyle(),
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius:
                                          BorderRadius.circular(80)),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white),
                                  ),
                                  suffixIcon:
                                      Icon(Icons.calendar_today_rounded),
                                  labelText: 'Date',
                                  labelStyle: primaryTextStyle(size: 14),
                                  filled: true,
                                  enabled: false),
                              cursorColor: false ? white : blackColor,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                            ),
                          ),
                          SizedBox(height: 180,),
                          Align(
                            alignment: FractionalOffset.bottomCenter,
                            child: InkWell(
                              onTap: () async {
                                DateTime now = DateTime.now();
                                try {
                                  await FirebaseFirestore.instance
                                      .collection("Japa")
                                      .doc(
                                          '${FirebaseAuth.instance.currentUser?.uid}')
                                      .update({
                                    "NOR": FieldValue.increment(
                                        _rounds.text.toInt()),
                                    "Name":
                                        "${FirebaseAuth.instance.currentUser?.displayName}",
                                    "PURL":
                                        "${FirebaseAuth.instance.currentUser?.photoURL}",
                                    "Date": _date.text,
                                    "LUD": DateFormat('yyyy-MM-dd')
                                        .format(now),
                                  });
                      
                                  _date.text = "";
                                  _rounds.text = "";
                                } catch (e) {
                                  await FirebaseFirestore.instance
                                      .collection("Japa")
                                      .doc(
                                          '${FirebaseAuth.instance.currentUser?.uid}')
                                      .set({
                                    "NOR": FieldValue.increment(
                                        _rounds.text.toInt()),
                                    "Name":
                                        "${FirebaseAuth.instance.currentUser?.displayName}",
                                    "PURL":
                                        "${FirebaseAuth.instance.currentUser?.photoURL}",
                                    "Date": _date.text,
                                    "LUD": DateFormat('yyyy-MM-dd')
                                        .format(now),
                                  });
                                  _date.text = "";
                                  _rounds.text = "";
                                }
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CustomDialogExample(),
                                );
                              },
                              child: Container(
                                height: 55.0,
                                width:
                                    MediaQuery.of(context).size.width / 1.1,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.0)),
                                    gradient: LinearGradient(
                                        colors: [
                                          Colors.orange,
                                          Colors.deepOrange
                                        ],
                                        begin: const FractionalOffset(
                                            0.0, 0.0),
                                        end: const FractionalOffset(
                                            1.0, 0.0),
                                        stops: [0.0, 1.0],
                                        tileMode: TileMode.clamp)),
                                child: Center(
                                  child: Text(
                                    "Update",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 19.0,
                                        fontFamily: "Sofia",
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),

                    ]),)),),
                    Align(
                        child: SingleChildScrollView(
                          child: Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Japa Card",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 10,
                            ),
                            StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Japa')
                                  .doc(
                                      '${FirebaseAuth.instance.currentUser?.uid}')
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 20.0),
                    child: Container(
                      height: 250.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(80.0)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12.withOpacity(0.1),
                                blurRadius: 3.0,
                                spreadRadius: 1.0)
                          ]),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          width: double
                              .infinity, // Adjust the width of the container according to your needs
                          height:
                              200, // Adjust the height of the container according to your needs
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  );
                                }
                        
                                final data = snapshot.data!.data()
                                    as Map<String, dynamic>?;
                                String? lud = "";
                                int NOR;
                        
                                String image = "";
                                String card = "";
                                Color color;
                                try {
                                  lud = data?['LUD'];
                                  NOR = data?['NOR'];
if (NOR < 108) {
                                  image = "assets/bronze.jpeg";
                                  card = "BRONZE";
                                  color = Colors.white;
                                } else if (NOR < 1008) {
                                  image = "assets/silver.jpeg";
                                  card = "SILVER";
                                  color = Colors.black;
                                } else {
                                  image = "assets/gold-bg.jpeg";
                                  card = "PLATINUM";
                                  color = Colors.white;
                                }
                                } catch(e) {
                                  lud = "Not Available";
                                  NOR = 0;

                                                                    image = "assets/bronze.jpeg";
                                  card = "BRONZE";
                                  color = Colors.white;
                                }
                                if (lud == null) {
                                  return Text('No Data');
                                }
                        
                                
                        
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: cardHight,
                                  margin: EdgeInsets.only(bottom: 16.0),
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(image),
                                                fit: BoxFit.fill),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25.0))),
                                        width: double.infinity,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              text("${card} CARD",
                                                  textColor:
                                                      color.withOpacity(0.7),
                                                  fontSize: 18.0),
                                              Image.asset(
                                                "assets/gopuram.png",
                                                width: 40,
                                                height: 40,
                                              )
                                            ],
                                          ),
                                          Expanded(
                                              child: text("**** **** **** 1008",
                                                      textColor: color,
                                                      fontFamily: 'Bold',
                                                      fontSize: 20.0)
                                                  .paddingTop(8.0)),
                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    text("CARD HOLDER",
                                                        textColor: color
                                                            .withOpacity(0.7),
                                                        fontSize: 16.0),
                                                    text(
                                                        "${FirebaseAuth.instance.currentUser?.displayName}".toUpperCase(),
                                                        textColor: color,
                                                        fontSize: 16.0,
                                                        fontFamily: 'Medium'),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  text("EXPIRES",
                                                      textColor:
                                                          color.withOpacity(0.7),
                                                      fontSize: 16.0),
                                                  text("10/90",
                                                      textColor: color,
                                                      fontSize: 16.0,
                                                      fontFamily: 'Medium'),
                                                ],
                                              ).paddingRight(16.0),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  text("CVV",
                                                      textColor:
                                                          color.withOpacity(0.7),
                                                      fontSize: 16.0),
                                                  text("108",
                                                      textColor: color,
                                                      fontSize: 16.0,
                                                      fontFamily: 'Medium'),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ).paddingAll(16.0)
                                    ],
                                  ),
                                );
                              },
                            ),
                            Text("Statistics ",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 10,
                            ),
                            StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Japa')
                                  .doc(
                                      '${FirebaseAuth.instance.currentUser?.uid}')
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 20.0),
                    child: Container(
                      height: 250.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(80.0)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12.withOpacity(0.1),
                                blurRadius: 3.0,
                                spreadRadius: 1.0)
                          ]),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          width: double
                              .infinity, // Adjust the width of the container according to your needs
                          height:
                              200, // Adjust the height of the container according to your needs
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  );
                                }
                        
                                final data = snapshot.data!.data()
                                    as Map<String, dynamic>?;
                                String? lud = "";
                                int NOR = 0;
                        
                                String level = "";
                                if (lud == null) {
                                  return Text('No Data');
                                }
                        
                                
                        try {
                                  lud = data?['LUD'];
                                  NOR = data?['NOR'];
if (NOR < 108) {
                                  level = "Beginner";
                                } else if (NOR < 1008) {
                                  level = "Intermidiate";
                                } else {
                                  level = "Advanced";
                                }
                                } catch(e) {
                                  lud = "Not Available";
                                  NOR = 0;

                                  level = "Beginner";
                                }
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => JapaPage()));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      //overflow: Overflow.visible,
                                      children: [
                                        Container(
                                          width: context.width(),
                                          decoration: boxDecorationDefault(
                                              borderRadius: radius(40),
                                              color: Colors.grey.shade200),
                                          padding: EdgeInsets.only(
                                              top: 80,
                                              bottom: 16,
                                              left: 16,
                                              right: 16),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  '${FirebaseAuth.instance.currentUser?.displayName}'.toUpperCase(),
                                                  style: boldTextStyle(size: 20)),
                                              8.height,
                                              Text('Last Update $lud',
                                                  style: secondaryTextStyle()),
                                              20.height,
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text('Chanter Level: $level',
                                                      style: primaryTextStyle(
                                                          size: 20)),
                                                  4.width,
                                                ],
                                              ),
                                              4.height,
                                              Text('Rounds Chanted: $NOR',
                                                  style: secondaryTextStyle(
                                                      color: Colors.green))
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          top: -26,
                                          child: Container(
                                            decoration: boxDecorationDefault(
                                              borderRadius: radius(16),
                                            ),
                                            height: 100,
                                            width: 80,
                                            child: Image.asset(
                                              "assets/medal.png",
                                              height: 50,
                                              width: 50,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                                                      onTap: () {
                                                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Japathon(image_url: "https://iskconcongregation.com/wp-content/uploads/2019/05/M1.jpg", title: "Japathon", date: "2-3-429", description: "Hari Bol this is the Description")));

                                  },
                                    child: Card(
                                      color: Colors.deepOrangeAccent,
                                      shadowColor: Colors.deepOrangeAccent,
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16))),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Text("Japathon",
                                                style: boldTextStyle(
                                                    size: 16, color: Colors.white)),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: Image.asset('assets/yoga.png', height: 55, width: 55, color: Colors.white,),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Japa')
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final data = snapshot.data!.data() as Map<String, dynamic>?;
                

                return Expanded(
                              flex: 1,
                              child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                ),
                                child: InkWell(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                  onTap: () {},
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 16, right: 16, top: 8),
                                          child: Text(
                                            "Your Last Update Was On \n",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: primaryTextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Divider(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                data?['LUD'] ?? "Not Available",
                                                style: secondaryTextStyle(
                                                    color: Colors.black),
                                              ),
                                              Icon(Icons.date_range,
                                                  color: Colors.black),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
              },
            ),
                                
                              ],
                            ),
                          ],
                                              ),
                                            ),
                        )),
                    Align(child: SingleChildScrollView(child: _buildList()))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
    
  }

  Widget _buildList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Japa")
          .orderBy("NOR", descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData) {
          return const Text('No data found');
        }
        return ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          itemCount: snapshot.data!.size,
          itemBuilder: (BuildContext context, int index) {
            final DocumentSnapshot document = snapshot.data!.docs[index];
            FaIcon LevelBadge = FaIcon(FontAwesomeIcons.trophy);
            Color color = Colors.amber.shade600;
            if (index == 0) {
              LevelBadge = FaIcon(FontAwesomeIcons.trophy, size: 40, color: Colors.amber.shade600,);
              color = Colors.amber.shade600;
            }
            else if (index == 1) {
              LevelBadge = FaIcon(FontAwesomeIcons.trophy, size: 40, color: Colors.grey.shade600,);
              color = Colors.grey.shade600;            }
            else if (index == 2) {
              LevelBadge = FaIcon(FontAwesomeIcons.trophy, size: 40, color: Colors.brown.shade600,);
              color = Colors.brown.shade600;            } else {
                            LevelBadge = FaIcon(FontAwesomeIcons.medal, size: 50, color: Colors.amber.shade600,);
              color = Colors.amber.shade600;
            };
            return Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            height: 40.0,
                            width: 40.0,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.0)),
),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(
                                document['PURL'] != "null" ? document['PURL'] : "https://cdn-icons-png.flaticon.com/512/3048/3048127.png"
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12.0,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                document["Name"].toString().toUpperCase(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.5),
                              ),
                              SizedBox(height: 5,),
                              Text(
                                "Total Rounds Chanted: ${document["NOR"]}",
                                style: TextStyle(color: Colors.black45),
                              )
                            ],
                          ),
                        ],
                      ),
                      LevelBadge
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    height: 0.5,
                    width: double.infinity,
                    color: Colors.black12.withOpacity(0.1),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
