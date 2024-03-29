import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:harekrishnagoldentemple/NoInternet.dart';
import 'package:harekrishnagoldentemple/Seek_Divine_Blessings/Seva_Detail.dart';
import 'package:harekrishnagoldentemple/Yatra/Yatra_Detail.dart';

class SDBLIS extends StatefulWidget {
  const SDBLIS({super.key});

  @override
  State<SDBLIS> createState() => _SDBLISState();
}

class _SDBLISState extends State<SDBLIS> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  late String dropdown_title1;

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
        title: Text("Seek Divine Blessings"),
        
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("Seva-Slider").snapshots(),
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
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  
                  final DocumentSnapshot document = snapshot.data!.docs[index];
                  return GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                
                              },
                              child: sevaCard(
                              document['Image'],
                              document['Seva-Name'],
                              document['Seva-Caption'],
                              document['Seva-ID'],
                              document['Dropdown_Item'],
                              context)
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


Widget sevaCard(String image, title, caption, id, dropdownTitle,
    BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 5
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: () {},
          child: Hero(
            tag: 'hero-tag-$id',
            child: Material(
              child: Stack(
                children: [
                  // Container for the image with gradient
                  Container(
                    height: 220.0,
                    width: 180.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5.0,
                          color: Colors.black12.withOpacity(0.1),
                          spreadRadius: 2.0,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // Image
                          Image.network(
                            image,
                            fit: BoxFit.cover,
                          ),
                          // Gradient Overlay
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.orange.withOpacity(0.9),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 220.0,
                    width: 160.0,
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          " $title",
                          style: const TextStyle(
                            fontFamily: "Sofia",
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 5, bottom: 5),
                            child: Text(
                              caption,
                              style: const TextStyle(
                                fontFamily: "Sofia",
                                fontWeight: FontWeight.bold,
                                fontSize: 10.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: ElevatedButton(
                            onPressed: () {
                              print("$dropdownTitle");
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SevaDetail(dropdown_title: "$dropdownTitle",)));
                            },
                            child: Text('Donate'),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.deepOrange.withOpacity(0.5)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(
                                      color: Colors.orange.withOpacity(0.2)),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}