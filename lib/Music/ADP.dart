import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:harekrishnagoldentemple/Music/Song.dart';
import 'package:harekrishnagoldentemple/NoInternet.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shimmer/shimmer.dart';

class ADP extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  ADP({super.key, required this.documentSnapshot});

  @override
  State<ADP> createState() => _ADPState();
}

class _ADPState extends State<ADP> {
  bool isPlay = true;

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
      log('Couldn\'t check connectivity status', );
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
        backgroundColor: Colors.white,
        title: Text(widget.documentSnapshot['Title']),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    widget.documentSnapshot['Image'],
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.7,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  widget.documentSnapshot['Title'],
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Music")
                  .where('Album', isEqualTo: widget.documentSnapshot["Title"])
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
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
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.size,
                  itemBuilder: (BuildContext context, int index) {
                    final DocumentSnapshot document =
                        snapshot.data!.docs[index];
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(15.0)),
                          child: ListTile(
                              leading: Text(
                                '${index + 1}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                              ),
                              title: Text(
                                document['Title'],
                                style: TextStyle(color: Colors.orange),
                              ),
                              subtitle: Text("${document['Likes']} Likes"),
                              trailing: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Song(documentSnapshot: document)));
                                },
                                child: Icon(
                                  Icons.play_circle,
                                  color: Colors.orange,
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      )),
    );
  }
}
