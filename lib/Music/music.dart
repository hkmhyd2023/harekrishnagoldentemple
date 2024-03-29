// ignore_for_file: unrelated_type_equality_checks

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:harekrishnagoldentemple/Music/ADP.dart';
import 'package:harekrishnagoldentemple/Music/Song.dart';
import 'package:harekrishnagoldentemple/NoInternet.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shimmer/shimmer.dart';

class Music extends StatefulWidget {
  const Music({super.key});

  @override
  State<Music> createState() => _MusicState();
}

class _MusicState extends State<Music> {

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
      log('Couldn\'t check connectivity status',);
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

    return _connectionStatus==ConnectivityResult.none? NoInternet() : Scaffold(
      appBar: AppBar(
        title: Text("Music", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue.shade300,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Trending Kirtans",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Music")
                .where('Trending', isEqualTo: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
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
              return Container(
                height: 320,
                child: Padding(
                  padding: const EdgeInsets.only(left: 9.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.size,
                    itemBuilder: (BuildContext context, int index) {
                      final DocumentSnapshot document =
                          snapshot.data!.docs[index];
                      return InkWell(
                        onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: ((context) => Song(documentSnapshot: document))));},
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              
                              Container(
                                height: 300,
                                width: MediaQuery.of(context).size.width * 0.55,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            document['Trending-Image']),
                                        fit: BoxFit.cover)),
                              ),
                              Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.47,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      color: Colors.white.withOpacity(0.8)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            document["Title"],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                    color: Colors.blue,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                          Text(
                                            document[
                                                "Trending-Music-Description"],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.play_circle,
                                        color: Colors.blue,
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
          20.height,
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Albums",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Music-Albums")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (!snapshot.hasData) {
                return const Text('No data found');
              }
              return Container(
                
                child: Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final DocumentSnapshot document =
                          snapshot.data!.docs[index];
                      return Container(
                        height: 75,
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(color: Colors.grey.shade200.withOpacity(0.6), borderRadius: BorderRadius.circular(15.0)),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                          CachedNetworkImage(
                                
                                imageUrl: document['Image'],
  imageBuilder: (context, imageProvider) => Container(
height: 50,
width: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      
      image: DecorationImage(
        
        image: imageProvider, fit: BoxFit.cover, ),
    ),
  ),
                                
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                ),
                                height: 50,
                                width: 50,
                                
                              ),
                          SizedBox(width: 20,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  document['Title'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontWeight: FontWeight.bold, color: Colors.blue),
                                ),
                                Text(
                                  "Kirtans",
                                  maxLines: 2,
                                  style: Theme.of(context).textTheme.bodySmall,
                                )
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () 
                            {Navigator.of(context).push(MaterialPageRoute(builder: ((context) => ADP(documentSnapshot: document))));},
                            icon: const Icon(Icons.play_circle),
                            color: Colors.blue,
                          )
                        ]),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      )),
    );
  }
    }

