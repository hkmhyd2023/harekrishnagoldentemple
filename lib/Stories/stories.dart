// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:harekrishnagoldentemple/NoInternet.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Stories extends StatefulWidget {
  const Stories({super.key});

  @override
  State<Stories> createState() => _StoriesState();
}

class _StoriesState extends State<Stories> {
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
      log(
        'Couldn\'t check connectivity status',
      );
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

  Map likes = {};
  int likeCount = 0;
  bool isLiked = false;
  List docID = [];

  @override
  Widget build(BuildContext context) {
    return _connectionStatus==ConnectivityResult.none ? NoInternet() : Scaffold(
      appBar: AppBar(
        title: Text("Stories"),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(9.0),
          child: Column(children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("Stories").snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData) {
                  return const Text('No data found');
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.size,
                  itemBuilder: (BuildContext context, int index) {
                    final DocumentSnapshot document = snapshot.data!.docs[index];
                    String url = document["Video"];
                    YoutubePlayerController _controller = YoutubePlayerController(initialVideoId: url, flags: YoutubePlayerFlags(autoPlay: false, mute: false));
                    return Card(
                      color: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        onTap: () {},
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                                child: YoutubePlayer(controller: _controller),
                              ),
                              10.height,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 16, right: 16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 300,
                                          child: Text(
                                            document["Title"],
                                            style: boldTextStyle(size: 16, color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                    onTap: () {
                                      bool _isLiked = likes[FirebaseAuth.instance.currentUser!.uid] == true;
                                      if (_isLiked) {
                                        FirebaseFirestore.instance.collection('Stories').doc(document.id).update({"Likes": FieldValue.increment(-1)});
                                        setState(() {
                                          likeCount -= 1;
                                          isLiked = false;
                                          docID.add(document.id);
                                          likes[FirebaseAuth.instance.currentUser!.uid] = false;
                                        });
                                      } else if (!_isLiked) {
                                        FirebaseFirestore.instance.collection('Stories').doc(document.id).update({"Likes": FieldValue.increment(1)});
                                        setState(() {
                                          likeCount += 1;
                                          docID.add(document.id);
                                          isLiked = true;
                                          likes[FirebaseAuth.instance.currentUser!.uid] = true;
                                        });
                                      }
                                    },
                                  ),
                                  10.width,
                                ],
                              ),
                              10.height,
                              Padding(
                                padding: EdgeInsets.only(left: 16, right: 16),
                                child: ReadMoreText(
                                  document["Description"],
                                  style: secondaryTextStyle(size: 16, color: Colors.black),
                                  trimLines: 2,
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: '... Read More',
                                  trimExpandedText: ' Read Less',
                                ),
                              ),
                              10.height,
                              Padding(
                                padding: EdgeInsets.only(left: 16, right: 16),
                                child: Text("${document["Likes"]} Likes"),
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ]),
        ),
      ),
    );
  }
}
