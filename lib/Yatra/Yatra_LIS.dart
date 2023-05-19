import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:harekrishnagoldentemple/NoInternet.dart';
import 'package:harekrishnagoldentemple/Yatra/Yatra_Detail.dart';

class ratingbar extends StatelessWidget {
  final int starCount;
  final double? starRating;
  final Color color;
  final double? size;

  ratingbar({this.starCount = 5, this.starRating = 0.0, this.color = Colors.yellow, this.size});

  Widget buildStar(BuildContext context, int index) {
    IconData iconData = Icons.star;
    Color warna = color;

    if (index >= starRating!) {
      iconData = Icons.star;
      warna = Colors.black12.withOpacity(0.1);
    } else if (index > starRating! - 1 && index < starRating!) {
      iconData = Icons.star_half;
    }
    return Icon(iconData, size: 14.0, color: warna);
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: List.generate(starCount, (i) => buildStar(context, i)));
  }
}

class YatraList extends StatefulWidget {
  const YatraList({super.key});

  @override
  State<YatraList> createState() => _YatraListState();
}

class _YatraListState extends State<YatraList> {
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
    return _connectionStatus==ConnectivityResult.none ? NoInternet() : Scaffold(
      appBar: AppBar(
        title: Text("Yatras"),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("Yatras").snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (!snapshot.hasData) {
                return const Text('No data found');
              }
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: (1 / 1.5), mainAxisSpacing: 16, crossAxisSpacing: 16),
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.size,
                padding: EdgeInsets.only(left: 2.4),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final DocumentSnapshot document = snapshot.data!.docs[index];
                  return GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: ((context) => YatraDetail(
                                        title: document['Title'],
                                        image: document['Image'],
                                        DaysN: document['DN'],
                                        MaxPeople: document['MAXP'],
                                        location: document['Location'],
                                        Description: document['Description'],
                                        Cost: document['Cost']))));
                              },
                              child: Container(
                                decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12.withOpacity(0.1), spreadRadius: 0.2, blurRadius: 0.5)]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Hero(
                                      tag: "${document['Title']}",
                                      child: Material(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(PageRouteBuilder(
                                                opaque: false,
                                                pageBuilder: (BuildContext context, _, __) {
                                                  return new Material(
                                                    color: Colors.black54,
                                                    child: Container(
                                                      padding: EdgeInsets.all(30.0),
                                                      child: InkWell(
                                                        child: Hero(
                                                            tag: "${document['Title']}-2nd",
                                                            child: Image.network(
                                                              document['Image'],
                                                              width: 300.0,
                                                              height: 400.0,
                                                              alignment: Alignment.center,
                                                              fit: BoxFit.contain,
                                                            )),
                                                        onTap: () {
                                                          Navigator.pop(context);
                                                        },
                                                      ),
                                                    ),
                                                  );
                                                },
                                                transitionDuration: Duration(milliseconds: 500)));
                                          },
                                          child: SizedBox(
                                            child: Image.network(
                                              document['Image'],
                                              fit: BoxFit.cover,
                                              height: 140.0,
                                              width: MediaQuery.of(context).size.width / 2.1,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8.0, right: 3.0, top: 15.0),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width / 2.7,
                                        child: Text(
                                          document['Title'],
                                          style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w500, fontFamily: "Sofia"),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.0, top: 5.0),
                                      child:
                                          Text("\₹" + document['Cost'], style: TextStyle(fontSize: 15.5, color: Colors.black54, fontWeight: FontWeight.w800, fontFamily: "Sans")),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                                      child: Row(
                                        children: <Widget>[
                                          ratingbar(
                                            starRating: document["Star-Rating"],
                                            color: Colors.orange,
                                          ),
                                          Padding(padding: EdgeInsets.only(left: 5.0)),
                                          Text(
                                            "(" + document['Rating'] + ")",
                                            style: TextStyle(
                                              color: Colors.black26,
                                              fontFamily: "Gotik",
                                              fontSize: 12.5,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 15.0),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.location_on,
                                            size: 11.0,
                                            color: Colors.black38,
                                          ),
                                          Text(
                                            document['Location'],
                                            style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500, fontFamily: "Sans", color: Colors.black38),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      )),
    );
  }
}
