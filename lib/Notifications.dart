import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:harekrishnagoldentemple/NoInternet.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shimmer/shimmer.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
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
    return _connectionStatus == ConnectivityResult.none
        ? NoInternet()
        : Scaffold(
            appBar: AppBar(
              title: const Text("Notifications"),
              backgroundColor: Colors.white,
              automaticallyImplyLeading: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection("Messages").snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
                          child: Container(
                            height: 300.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(80.0)),
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
                      if (!snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
                          child: Container(
                            height: 250.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(80.0)),
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
                      return ListView.builder(
                        shrinkWrap: true,
                        reverse: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.size,
                        itemBuilder: (BuildContext context, int index) {
                          final DocumentSnapshot document = snapshot.data!.docs[index];
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: ListTile(
                                    title: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(document['Title'], style: boldTextStyle()),
                                        SizedBox(height: 8),
                                        Text(document['Description'], style: secondaryTextStyle()),
                                        SizedBox(height: 8),
                                      ],
                                    ),
                                    leading: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                        document['Icon'],
                                      ),
                                    ),
                                  ),
                                ),
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
            ),
          );
  }
}
