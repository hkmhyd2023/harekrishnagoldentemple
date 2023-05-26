import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:harekrishnagoldentemple/Home/home.dart';
import 'package:harekrishnagoldentemple/Music/music.dart';
import 'package:harekrishnagoldentemple/RoutePages/JapaPage.dart';
import 'package:harekrishnagoldentemple/Settings/Settings.dart';
import 'package:harekrishnagoldentemple/Stories/stories.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:harekrishnagoldentemple/krishna_lila/krishna_lila_entry.dart';

import '../NoInternet.dart';

class NaviBottomNavBar extends StatefulWidget {
  @override
  _NaviBottomNavBarState createState() => _NaviBottomNavBarState();
}

class _NaviBottomNavBarState extends State<NaviBottomNavBar> {
  int currentIndex = 0;

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

  /// Set a type current number a layout class
  Widget callPage(int current) {
    switch (current) {
      case 0:
        return HomeScreen();
      case 1:
        if (FirebaseAuth.instance.currentUser != null) {
          return JapaPage();
        } else {
          return CustomDialogExample3();
        }
      case 2:
        return Music();
      case 3:
        return Settings();
      case 4:
        return KLEntry();
      default:
        return Settings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == ConnectivityResult.none
        ? const NoInternet()
        : Scaffold(
            body: callPage(currentIndex),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.orange.shade300,
              onPressed: () {
                setState(() {
                  currentIndex = 4;
                });
              },
              child: Image.asset(
                "assets/flute.png",
                height: 50,
                width: 50,
              ),
            ),
            bottomNavigationBar: Theme(
                data: Theme.of(context).copyWith(canvasColor: Colors.white, textTheme: TextTheme(headline1: TextStyle(color: Colors.black38.withOpacity(0.5)))),
                child: BottomAppBar(
                  shape: CircularNotchedRectangle(),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            currentIndex = 0;
                          });
                        },
                        icon: Icon(Icons.home)),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          currentIndex = 1;
                        });
                      },
                      icon: Image.asset(
                        "assets/om.png",
                        color: Colors.black,
                        height: 23,
                        width: 23,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          currentIndex = 2;
                        });
                      },
                      icon: Image.asset(
                        "assets/bottom_music.png",
                        color: Colors.black,
                        height: 23,
                        width: 23,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            currentIndex = 3;
                          });
                        },
                        icon: Icon(Icons.person)),
                  ]),
                )),
          );
  }
}
