import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:harekrishnagoldentemple/NoInternet.dart';
import 'package:harekrishnagoldentemple/Satvik-Recipes/Recipes-Category-Detail.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shimmer/shimmer.dart';

class RCategories extends StatefulWidget {
  const RCategories({super.key});

  @override
  State<RCategories> createState() => _RCategoriesState();
}

class _RCategoriesState extends State<RCategories> {

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

  @override
  Widget build(BuildContext context) {
    return  _connectionStatus==ConnectivityResult.none ? NoInternet() : Scaffold(
      appBar: AppBar(
        title: Text("Recipes"),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 40,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("RCategory").snapshots(),
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
                padding: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 16),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final DocumentSnapshot document = snapshot.data!.docs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RCDetail(
                                category: document['Title'],
                              )));
                    },
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: document['Image'],
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
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
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 180,
                          left: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 100,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.black.withOpacity(0.4), shape: StadiumBorder()),
                                  onPressed: () {},
                                  child: Row(
                                    children: [
                                      Icon(Icons.schedule_outlined, color: Colors.white, size: 15),
                                      Text(" " + document['Views'].toString(), style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w300)),
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                document['Title'],
                                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ]),
      ),
    );
  }
}
