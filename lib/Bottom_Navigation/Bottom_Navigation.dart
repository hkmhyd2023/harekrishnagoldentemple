import 'package:flutter/material.dart';
import 'package:harekrishnagoldentemple/Home/home.dart';
import 'package:harekrishnagoldentemple/Music/music.dart';
import 'package:harekrishnagoldentemple/RoutePages/JapaPage.dart';
import 'package:harekrishnagoldentemple/Settings/Playlist.dart';
import 'package:harekrishnagoldentemple/Settings/Settings.dart';
import 'package:harekrishnagoldentemple/Stories/stories.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class NaviBottomNavBar extends StatefulWidget {
  @override
  _NaviBottomNavBarState createState() => _NaviBottomNavBarState();
}

class _NaviBottomNavBarState extends State<NaviBottomNavBar> {
  int currentIndex = 0;

  /// Set a type current number a layout class
  Widget callPage(int current) {
    switch (current) {
      case 0:
        return new HomeScreen();
      case 1:
        return new JapaPage();
      case 2:
        return new Music();
      case 3:
        return new Settings();
        break;
      default:
        return Settings();
    }
  }

  /// Build BottomNavigationBar Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: callPage(currentIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange.shade300,
        onPressed: () {},
        child: Image.network("https://firebasestorage.googleapis.com/v0/b/hare-krishna-golden-temp-b1785.appspot.com/o/14-__flute_with_peacock_feather2-1-removebg-preview.png?alt=media&token=e0972325-95ec-4488-b0ae-eaf663f9f69c", height: 50, width: 50,),
      ),
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: Colors.white,
              textTheme: TextTheme(
                  headline1:
                      TextStyle(color: Colors.black38.withOpacity(0.5)))),
          child: BottomAppBar(
            shape: CircularNotchedRectangle(),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                      icon: Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/Om_symbol.svg/1200px-Om_symbol.svg.png", color: Colors.black, height: 23, width: 23,),
                  ),
                
                  IconButton(
                      onPressed: () {
                        setState(() {
                          currentIndex = 2;
                        });
                      },
                      icon: Image.network("https://cdn-icons-png.flaticon.com/512/4430/4430494.png", color: Colors.black, height: 23, width: 23,),
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
