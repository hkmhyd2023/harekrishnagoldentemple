import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:harekrishnagoldentemple/Web_Series/ABP.dart';
import 'package:harekrishnagoldentemple/Web_Series/MNWS.dart';
import 'package:harekrishnagoldentemple/Web_Series/VMWS.dart';
import 'package:nb_utils/nb_utils.dart';

import '../NoInternet.dart';

class WebSeriesEntry extends StatefulWidget {
  const WebSeriesEntry({super.key});

  @override
  State<WebSeriesEntry> createState() => _WebSeriesEntryState();
}

class _WebSeriesEntryState extends State<WebSeriesEntry> {
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
    return _connectionStatus==ConnectivityResult.none ? NoInternet() : Scaffold(
      appBar: AppBar(title: Text("Web Series"), backgroundColor: Colors.white),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            SizedBox(height: 20
            ,),
            InkWell(
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const ABP())); },
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://www.vina.cc/wp-content/uploads/2015/08/jaladuta-1.jpg"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Container(
                      height: 89.0,
                      width: MediaQuery.of(context).size.width / 1.7,
                      decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.6),
                          borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 160.0, left: 15.0),
                        child: Text(
                          "Acharya Bio Pic",
                          style: TextStyle(
                              fontFamily: "Sofia",
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0),
                        ),
                      ),
                    ),
                  ),
                ),
            
                20.height,
                InkWell(
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const VMWS())); },
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://i.ytimg.com/vi/hNkfksVYqoc/maxresdefault.jpg"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Container(
                      height: 89.0,
                      width: MediaQuery.of(context).size.width / 1.7,
                      decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.6),
                          borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 160.0, left: 15.0),
                        child: Text(
                          "Vrindavan & Mathura Web Series",
                          style: TextStyle(
                              fontFamily: "Sofia",
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0),
                        ),
                      ),
                    ),
                  ),
                ),
                20.height,
                InkWell(
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const MNWS())); },
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://t3.ftcdn.net/jpg/05/33/92/36/360_F_533923654_qDHStda4MxTmuVdjiIGWRDr4EKyAFEfi.jpg"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Container(
                      height: 89.0,
                      width: MediaQuery.of(context).size.width / 1.7,
                      decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.6),
                          borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 160.0, left: 15.0),
                        child: Text(
                          "Mayapur & Navadvip Web Series",
                          style: TextStyle(
                              fontFamily: "Sofia",
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0),
                        ),
                      ),
                    ),
                  ),
                ),
                20.height,
          ]),
        ),
      ),
    );
  }
}