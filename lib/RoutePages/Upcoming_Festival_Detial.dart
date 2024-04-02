import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:harekrishnagoldentemple/NoInternet.dart';
import 'package:harekrishnagoldentemple/Seek_Divine_Blessings/Seek_Divine_Blessings_LIS.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Upcoming_Festival_Detail extends StatefulWidget {
  @override
  Upcoming_Festival_Detail({required this.image_url, required this.title, required this.date, required this.description});

  String image_url;
  String? title;
  String? date;
  String? description;

  _Upcoming_Festival_DetailState createState() => _Upcoming_Festival_DetailState();
}

class _Upcoming_Festival_DetailState extends State<Upcoming_Festival_Detail> {
  /// Check user
  bool _checkUser = true;

  String? _nama, _photoProfile, _email;

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
      log('Couldn\'t check connectivity status', error: e);
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

  @override
  Widget build(BuildContext context) {
    String _book = "Bookmark";

    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return _connectionStatus == ConnectivityResult.none
        ? NoInternet()
        : Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: CustomScrollView(
                scrollDirection: Axis.vertical,
                slivers: <Widget>[
                  /// AppBar
                  SliverPersistentHeader(
                    delegate: MySliverAppBar(
                      expandedHeight: _height - 30.0,
                      img: widget.image_url,
                      id: "id-${widget.title}",
                      title: widget.title,
                    ),
                    pinned: true,
                  ),

                  SliverToBoxAdapter(
                      child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                    // StreamBuilder(
                    //   stream: Firestore.instance
                    //       .collection('users')
                    //       .document(widget.userId)
                    //       .snapshots(),
                    //   builder: (context, snapshot) {
                    //     if (!snapshot.hasData) {
                    //       return new Text("Loading");
                    //     } else {
                    //       var userDocument = snapshot.data;
                    //       _nama = userDocument["name"];
                    //       _email = userDocument["email"];
                    //       _photoProfile = userDocument["photoProfile"];
                    //     }

                    //     var userDocument = snapshot.data;
                    //     return Container();
                    //   },
                    // ),

                    Container(
                      height: 2.0,
                      width: double.infinity,
                      color: Colors.black12.withOpacity(0.03),
                    ),

                    SizedBox(
                      height: 15.0,
                    ),

                    Container(
                      height: 20.0,
                      width: double.infinity,
                      color: Colors.black12.withOpacity(0.03),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),

                    /// Description
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
                      child: Text(
                        "Description",
                        style: TextStyle(fontFamily: "Sofia", fontSize: 20.0, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0, bottom: 0.0),
                      child: Text(
                        widget.description!,
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontFamily: "Sofia", color: Colors.black54, fontSize: 18.0),
                        overflow: TextOverflow.clip,
                      ),
                    ),

                    /// service

                    //Text(_nama),

                    SizedBox(
                      height: 60.0,
                    ),

                    /// Button
                   Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const SDBLIS())); 
                            },
                            child: Container(
                              height: 55.0,
                              width: MediaQuery.of(context).size.width / 1.1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  gradient: LinearGradient(
                                      colors: [Colors.orange, Colors.deepOrange],
                                      begin: const FractionalOffset(0.0, 0.0),
                                      end: const FractionalOffset(1.0, 0.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp)),
                              child: Center(
                                child: Text(
                                  "Offer Seva",
                                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 19.0, fontFamily: "Sofia", fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ])),
                ],
              ),
            ),
          );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  String? img, id, title, location;
  num? price;
  double? ratting;

  MySliverAppBar({required this.expandedHeight, this.img, this.id, this.title, this.price, this.location, this.ratting});

  var _txtStyleTitle = TextStyle(
    color: Colors.black54,
    fontFamily: "Sofia",
    fontSize: 20.0,
    fontWeight: FontWeight.w800,
  );

  var _txtStyleSub = TextStyle(
    color: Colors.black26,
    fontFamily: "Sofia",
    fontSize: 12.5,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          height: 50.0,
          width: double.infinity,
          color: Colors.white,
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            "${title}",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Gotik",
              fontWeight: FontWeight.w700,
              fontSize: (expandedHeight / 40) - (shrinkOffset / 40) + 18,
            ),
          ),
        ),
        Opacity(
          opacity: (1 - shrinkOffset / expandedHeight),
          child: Hero(
            tag: 'hero-tag-${id}',
            child: new DecoratedBox(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: new NetworkImage(img!),
                ),
                shape: BoxShape.rectangle,
              ),
              child: Container(
                margin: EdgeInsets.only(top: 620.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(0.0, 1.0),
                    stops: [0.0, 1.0],
                    colors: <Color>[
                      Color(0x00FFFFFF),
                      Color(0xFFFFFFFF),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0, bottom: 40.0),
              child: Container(
                height: 210.0,
                width: double.infinity,
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10.0)), color: Colors.white.withOpacity(0.85)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0, right: 2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                    width: 270.0,
                                    child: Text(
                                      title!,
                                      style: _txtStyleTitle.copyWith(fontSize: 27.0),
                                      overflow: TextOverflow.clip,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                      child: Container(
                          height: 35.0,
                          width: 35.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(40.0),
                            ),
                            color: Colors.white70,
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          )),
                    ))),
            SizedBox(
              width: 36.0,
            )
          ],
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
