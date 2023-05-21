// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:harekrishnagoldentemple/Bottom_Navigation/Bottom_Navigation.dart';
import 'package:harekrishnagoldentemple/Home/home.dart';
import 'package:harekrishnagoldentemple/Prabhupada/prabhupada_entry.dart';
import 'package:harekrishnagoldentemple/RoutePages/JapaPage.dart';
import 'package:harekrishnagoldentemple/Settings/EditProfile.dart';
import 'package:harekrishnagoldentemple/faq_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:share_plus/share_plus.dart';

class ComingSoonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true,elevation: 0, foregroundColor: Colors.white, backgroundColor: Colors.orange.shade200,),
      backgroundColor: Colors.orange.shade200,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/gopuram.png",
              height: 180,
              width: 180,
            ),
            SizedBox(height: 20),
            Text(
              'Coming Soon',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppDrawerComponent extends StatelessWidget {
  const AppDrawerComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: false ? Colors.black.withAlpha(150) : Colors.white.withAlpha(232),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 260),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: GestureDetector(
                          onTap: () {
                            finish(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser?.photoURL ?? "https://images.pexels.com/photos/274973/pexels-photo-274973.jpeg?cs=srgb&dl=pexels-pixabay-274973.jpg&fm=jpg"), radius: 50),
                              SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${FirebaseAuth.instance.currentUser?.displayName}', style: boldTextStyle(size: 22)),
                                  Icon(Icons.arrow_forward_ios, size: 22),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.home, color: Colors.orange),
                        title: Text('Home', style: primaryTextStyle()),
                        onTap: () {
                          finish(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => NaviBottomNavBar()));
                        },
                      ),
        
                      ListTile(
                        leading: Image.asset('assets/yoga.png', color: Colors.orange, height: 28, width: 28,),
                        title: Text('Our Acharya', style: primaryTextStyle()),
                        onTap: () {
                          finish(context);
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => PrabhupadaEntry()));

                        },
                      ),
                                          ListTile(
                        leading: Image.asset('assets/om.png', color: Colors.orange, height: 22, width: 22,),
                        title: Text('Japa', style: primaryTextStyle()),
                        onTap: () {
                          finish(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => JapaPage()));
                        },
                      ),

                      ListTile(
                        leading: Icon(Icons.help, color: Colors.orange),
                        title: Text('FAQs', style: primaryTextStyle()),
                        onTap: () {
                          finish(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FaqScreen()));
                        },
                      ),
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.donate, color: Colors.orange),
                        title: Text('Sevas', style: primaryTextStyle()),
                        onTap: () {
                          finish(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ComingSoonPage()));
                        },
                      ),
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.share, color: Colors.orange),
                        title: Text('Share', style: primaryTextStyle()),
                        onTap: () async {
                                  await Share.share(
                "https://play.google.com/store/apps/details?id=org.hkmhyderabad.harekrishnagoldentemple"
              );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 25,
                left: 10,
                right: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
              height: 210,
              width: context.width(),
              child: Row(
                      children: [
                        Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                color: context.cardColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/gopuram.png', color: Colors.orange, height: 40, width: 40,),
                  8.height,
                  Text('HKM Hyderabad', style: boldTextStyle(size: 20)),
                  8.height,
                  Text('Hare Krishna Golden Temple', style: TextStyle(fontSize: 12),),
                  8.height,
                  TextIcon(
                    edgeInsets: EdgeInsets.only(left: 0, right: 8, bottom: 4, top: 4),
                    prefix: Icon(Icons.call, size: 14),
                    text: "+91 04023326999",
                    textStyle: primaryTextStyle(size: 14),
                  ),
                  TextIcon(
                    edgeInsets: EdgeInsets.only(left: 0, right: 8, bottom: 4, top: 4),
                    prefix: Icon(Icons.web, size: 14),
                    text: "www.hkmhyderabad.org",
                    textStyle: primaryTextStyle(size: 14),
                  ),
                  TextIcon(
                    edgeInsets: EdgeInsets.only(left: 0, right: 8, bottom: 4, top: 4),
                    prefix: Icon(Icons.location_on_outlined, size: 14),
                    text: "Hyderabad, Telangana",
                    textStyle: primaryTextStyle(size: 14),
                  ),
                ],
              ),
                        ).expand(),
                        Container(
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                color: Colors.orange,
              ),
                        )
                      ],
              ),
                        ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
