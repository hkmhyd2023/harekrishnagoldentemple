import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:harekrishnagoldentemple/Home/controller/controllers.dart';
import 'package:harekrishnagoldentemple/Home/widgets/app_drawer_component.dart';
import 'package:harekrishnagoldentemple/Home/widgets/carousel_loading.dart';
import 'package:harekrishnagoldentemple/Home/widgets/carousel_with_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harekrishnagoldentemple/Login/Login.dart';
import 'package:harekrishnagoldentemple/Music/music.dart';
import 'package:harekrishnagoldentemple/Notifications.dart';
import 'package:harekrishnagoldentemple/Prabhupada/prabhupada_entry.dart';
import 'package:harekrishnagoldentemple/RoutePages/Darshans.dart';
import 'package:harekrishnagoldentemple/RoutePages/Ekadashi_Reminders.dart';
import 'package:harekrishnagoldentemple/RoutePages/JapaPage.dart';
import 'package:harekrishnagoldentemple/Satvik-Recipes/Recipes-Category.dart';
import 'package:harekrishnagoldentemple/SoulfulJapa/SoulfulJapaEntry.dart';
import 'package:harekrishnagoldentemple/SoulfulJapa/SoulfulJapaVideos.dart';
import 'package:harekrishnagoldentemple/RoutePages/Upcoming_Festival_Detial.dart';
import 'package:harekrishnagoldentemple/Stories/stories.dart';
import 'package:harekrishnagoldentemple/Web_Series/web_series_entry.dart';
import 'package:harekrishnagoldentemple/Yatra/Yatra_LIS.dart';
import 'package:harekrishnagoldentemple/chaitanyaLilamrita/chaitanyaMahaprabhuEntry.dart.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

import '../krishna_lila/krishna_lila_entry.dart';

class CustomDialogExample3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: context.cardColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0)),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('Dear Devotee 🙏🏻',
                      style: boldTextStyle(color: Colors.black, size: 22)),
                ),
                GestureDetector(
                  onTap: () {
                    finish(context);
                  },
                  child: Container(
                      padding: EdgeInsets.all(16),
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.close, color: Colors.black)),
                ),
              ],
            ),
            Image(
                image: AssetImage('assets/widgettrophy.png'),
                height: 120,
                width: 190,
                fit: BoxFit.cover),
            24.height,
            Text('Hare Krishna 🙏🏻',
                style: boldTextStyle(color: Colors.black, size: 24)),
            16.height,
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text("Please login to access this feature",
                  style: secondaryTextStyle(color: Colors.black)),
            ),
            30.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(""),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        finish(context);
                      },
                      child: Text(
                        "CANCEL",
                        style: TextStyle(color: Colors.grey),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, elevation: 0),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => LogIn()));
                      },
                      child: Text(
                        "LOG IN",
                        style: TextStyle(color: Colors.orange.shade800),
                      ),
                      style: ElevatedButton.styleFrom(
                          elevation: 0, backgroundColor: Colors.white),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    String user_name = "";

    if (FirebaseAuth.instance.currentUser?.displayName == null) {
      user_name = "User Name";
    } else {
      user_name = FirebaseAuth.instance.currentUser!.displayName ?? "User Name";
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 9,
        toolbarHeight: 50,
        backgroundColor: false ? scaffoldDarkColor : white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hare Krishna 🙏🏻", style: secondaryTextStyle()),
            const SizedBox(height: 5),
            Text("${FirebaseAuth.instance.currentUser?.displayName ?? "Devotee"}", style: boldTextStyle()),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, size: 22, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Notifications()),
              );
            },
          ),
          
          IconButton(
            icon: const Icon(Icons.share, size: 22, color: Colors.black),
            onPressed: () async {
              await Share.share(
                "https://play.google.com/store/apps/details?id=com.hkmhyderabad.harekrishnagoldentemple"
              );
            },
          ),
        ],
      ),
      drawer: const AppDrawerComponent(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Darshan",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Darshans()));
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "View All",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.orange.shade800),
                        ),
                      ))
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Darshans()));
              },
              child: Obx(
                () {
                  if (carouselController.isLoading.value) {
                    return const Center(
                      child: CarouselLoading(),
                    );
                  } else {
                    if (carouselController.carouselItemList.isNotEmpty) {
                      return CarouselWithIndicator(data: carouselController.carouselItemList);
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [Icon(Icons.hourglass_empty), Text("Data not found!")],
                        ),
                      );
                    }
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Upcoming Festival",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection('Upcoming-Festival').doc('w6uTK0hEPNlWKRydt1ho').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
                    child: Container(
                      height: 250.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(80.0)),
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

                final data = snapshot.data!.data() as Map<String, dynamic>?;
                final imageUrl = data?['Image_Url'] as String?;
                final temple = data?['Temple'] as String?;
                final title = data?['Title'] as String?;
                final date = data?['Date'] as String?;
                final description = data?['Description'] as String?;
                if (imageUrl == null) {
                  return const Center(child: Text('No image available'));
                }

                return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: boxDecorationDefault(borderRadius: radius(32), color: context.cardColor),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: imageUrl,
                                imageBuilder: (context, imageProvider) => Container(
                                  width: 80.0,
                                  height: 80.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
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
                                    width: 80, // Adjust the width of the container according to your needs
                                    height: 80, // Adjust the height of the container according to your needs
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                                height: 130,
                              ),
                              16.width,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${title}", style: boldTextStyle(size: 18, weight: FontWeight.w500)),
                                  8.height,
                                  Text('${temple}', style: primaryTextStyle(color: Colors.blue, size: 14)),
                                  8.height,
                                  Text('${date}', style: primaryTextStyle(size: 14))
                                ],
                              ).expand(),
                            ],
                          ),
                          16.height,
                          AppButton(
                            text: 'View Details',
                            textStyle: primaryTextStyle(size: 15),
                            color: Colors.orange.shade300,
                            shapeBorder: RoundedRectangleBorder(borderRadius: radius(16)),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Upcoming_Festival_Detail(
                                            image_url: imageUrl,
                                            title: title,
                                            date: date,
                                            description: description,
                                          )));
                            },
                          )
                        ],
                      ),
                    ));
              },
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Ekadashi Reminders",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Ekadashi_Reminders()));
                      },
                      child: Text(
                        "View All",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.orange.shade800),
                      ))
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("Upcoming-Event").snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
                    child: Container(
                      height: 250.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(80.0)),
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
                          borderRadius: const BorderRadius.all(Radius.circular(80.0)),
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
                return Container(
                  height: 200,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.size,
                    itemBuilder: (BuildContext context, int index) {
                      final DocumentSnapshot document = snapshot.data!.docs[index];
                      return Container(
                        width: 300,
                        margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(left: 46.0),
                              decoration: BoxDecoration(
                                color: context.scaffoldBackgroundColor,
                                shape: BoxShape.rectangle,
                                boxShadow: <BoxShadow>[
                                  const BoxShadow(color: Color(0x95E9EBF0), blurRadius: 0.5, spreadRadius: 0.5),
                                ],
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              child: Container(
                                margin: const EdgeInsets.only(left: 55.0, right: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(document["Title"], style: primaryTextStyle(color: const Color(0xFFfc4a1a)), maxLines: 2),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(document["Date"], style: primaryTextStyle(color: const Color(0xFF8BC34A), size: 16)),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: <Widget>[
                                        CircleAvatar(backgroundImage: AssetImage(document["Gopuram-Image"]), radius: 20),
                                        Container(
                                          margin: const EdgeInsets.only(left: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text("Fast Break", style: primaryTextStyle()),
                                              Text(document['fast-break'], style: secondaryTextStyle(size: 12)),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              alignment: FractionalOffset.centerLeft,
                              child: CachedNetworkImage(
                                imageUrl: document['Main-Image'],
                                imageBuilder: (context, imageProvider) => Container(
                                  width: 80.0,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(48),
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
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(48.0),
                                    ),
                                  ),
                                ),
                                height: 80,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Japa Yagna",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection('Japa-Yagna').doc('D4JgsdNwGRY97dnZclh3').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
                    child: Container(
                      height: 270.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(80.0)),
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

                final data = snapshot.data!.data() as Map<String, dynamic>?;
                final imageUrl = data?['Image'] as String?;
                if (imageUrl == null) {
                  return const Center(child: Text('No image available'));
                }

                return GestureDetector(
                  onTap: () {
                    if (FirebaseAuth.instance.currentUser == null) {
                      showDialog(context: context, builder: (BuildContext context) => CustomDialogExample3());
                    } else {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => JapaPage()));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        height: 270,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
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
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                      ),
                      height: 300,
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Lilamrita",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            card2(MediaQuery.of(context).size.width),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Library",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: Text(
                        "View All",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.orange.shade800),
                      ))
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("Library-Carousel").snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
                    child: Container(
                      height: 250.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(80.0)),
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
                          borderRadius: const BorderRadius.all(Radius.circular(80.0)),
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
                return Container(
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.size,
                      itemBuilder: (BuildContext context, int index) {
                        final DocumentSnapshot document = snapshot.data!.docs[index];
                        return Library_Card(
                          img: document['Image'],
                          txtHeader: document['Header'],
                          txtSize: 48.0,
                          navigatorOntap: () {
                            if (index == 1) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const Stories()));
                            } else if (index == 0) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const WebSeriesEntry()));
                            } else {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const Music()));
                            }
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Soulful Japa",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection('Japa-Yagna').doc('SoulfulJapa').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
                    child: Container(
                      height: 250.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(80.0)),
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

                final data = snapshot.data!.data() as Map<String, dynamic>?;
                final imageUrl = data?['Image'] as String?;
                if (imageUrl == null) {
                  return const Center(child: Text('No image available'));
                }

                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SFJE()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        height: 230,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
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
                          width: double.infinity, // Adjust the width of the container according to your needs
                          height: 230, // Adjust the height of the container according to your needs
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Sattvik Recipes",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RCategories()));
                      },
                      child: Text(
                        "View All",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.orange.shade800),
                      ))
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("Recipes-Carousel").snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
                    child: Container(
                      height: 250.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(80.0)),
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
                          borderRadius: const BorderRadius.all(Radius.circular(80.0)),
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
                return Container(
                  height: 200,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.size,
                    itemBuilder: (BuildContext context, int index) {
                      final DocumentSnapshot document = snapshot.data!.docs[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RCategories()));
                        },
                        child: _recipeCard(document['Image'], document['Title'], document['Time'], document['Calories']),
                      );
                    },
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Yatras",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const YatraList()));
                      },
                      child: Text(
                        "View All",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.orange.shade800),
                      ))
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("Yatra-Slider").snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData) {
                  return const Text('No data found');
                }
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const YatraList()));
                  },
                  child: Container(
                    height: 320,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 9.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.size,
                        itemBuilder: (BuildContext context, int index) {
                          final DocumentSnapshot document = snapshot.data!.docs[index];
                          return yatraCard(document['Image'], document['Title'], document['Location'], document['Rating'], document['ID'], document['Discount'], context);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget yatraCard(String image, title, location, ratting, id, int discount, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: Hero(
              tag: 'hero-tag-${id}',
              child: Material(
                child: Container(
                  height: 220.0,
                  width: 160.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
                      color: Colors.black12,
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      boxShadow: [BoxShadow(blurRadius: 5.0, color: Colors.black12.withOpacity(0.1), spreadRadius: 2.0)]),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            title,
            style: const TextStyle(fontFamily: "Sofia", fontWeight: FontWeight.w600, fontSize: 17.0, color: Colors.black87),
          ),
          const SizedBox(
            height: 2.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(
                Icons.location_on,
                size: 18.0,
                color: Colors.black12,
              ),
              Text(
                location,
                style: const TextStyle(fontFamily: "Sofia", fontWeight: FontWeight.w500, fontSize: 15.0, color: Colors.black26),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.star,
                size: 18.0,
                color: Colors.yellow,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Text(
                  ratting,
                  style: const TextStyle(fontWeight: FontWeight.w700, fontFamily: "Sofia", fontSize: 13.0),
                ),
              ),
              const SizedBox(
                width: 35.0,
              ),
              Container(
                height: 27.0,
                width: 82.0,
                decoration: const BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Center(
                  child: Text("Discount ${discount}%", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 10.0)),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _recipeCard(String image, String title, String time, String calories) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Material(
            color: Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            child: Container(
              height: 110.0,
              width: 180.0,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
                boxShadow: [const BoxShadow(blurRadius: 0.0, color: Colors.black87)],
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                gradient: const LinearGradient(colors: [Colors.white, Colors.white], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: ingredients.map((item) => new Text(item)).toList()),
          Container(
            width: 170.0,
            child: Text(
              title,
              style: const TextStyle(color: Colors.black, fontFamily: "Sofia", fontSize: 16.0, fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            height: 2.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Icon(
                      Icons.query_builder,
                      size: 18.0,
                      color: Colors.black26,
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      time,
                      style: const TextStyle(color: Colors.black45, fontFamily: "Sofia", fontSize: 14.0, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Icon(
                      Icons.whatshot,
                      size: 18.0,
                      color: Colors.black26,
                    ),
                    Text(
                      calories,
                      style: const TextStyle(color: Colors.black45, fontFamily: "Sofia", fontSize: 14.0, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget card2(double _widht) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const KLEntry()));
            },
            child: Container(
              height: 197.0,
              width: 98.0,
              decoration: const BoxDecoration(
                  image: DecorationImage(image: NetworkImage("https://pbs.twimg.com/media/FiET6RNakAE-5_g?format=jpg&name=large"), fit: BoxFit.cover),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Container(
                height: 197.0,
                width: 95.0,
                decoration: BoxDecoration(color: Colors.black12.withOpacity(0.2), borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                child: const Padding(
                  padding: EdgeInsets.only(top: 120.0, left: 10.0),
                  child: Text(
                    "Sri Krishna Lila",
                    style: TextStyle(fontFamily: "Sofia", color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18.0),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ChaitanyaMahaPrabhuEntry()));
                  },
                  child: Container(
                    height: 95.0,
                    width: _widht / 1.7,
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                        image: DecorationImage(image: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/1/14/Nitaigaurangaforwiki.jpg"), fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Container(
                      height: 89.0,
                      width: _widht / 1.7,
                      decoration: BoxDecoration(color: Colors.black12.withOpacity(0.4), borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 60.0, left: 15.0),
                        child: Text(
                          "Sri Chaitanya Lila",
                          style: TextStyle(fontFamily: "Sofia", color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const PrabhupadaEntry()));
                  },
                  child: Container(
                    height: 95.0,
                    width: _widht / 1.7,
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://firebasestorage.googleapis.com/v0/b/hare-krishna-golden-temp-b1785.appspot.com/o/WhatsApp%20Image%202023-05-16%20at%202.06.09%20PM.jpeg?alt=media&token=7830f7a1-a74b-4153-98d1-1b92a9ff1a34"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Container(
                      height: 89.0,
                      width: _widht / 1.7,
                      decoration: BoxDecoration(color: Colors.black12.withOpacity(0.4), borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 65.0, left: 15.0),
                        child: Text(
                          "Srila Prabhupada Lila",
                          style: TextStyle(fontFamily: "Sofia", color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Library_Card extends StatelessWidget {
  @override
  String? img, txtTitle, txtHeader;
  double? txtSize;
  GestureTapCallback? navigatorOntap;

  Library_Card({this.img, this.txtSize, this.navigatorOntap, this.txtHeader});

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 12.0, top: 8.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: navigatorOntap,
            child: Container(
              width: 230.0,
              height: 135.0,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20), image: DecorationImage(image: NetworkImage(img!), fit: BoxFit.cover), color: Colors.white, boxShadow: [
                BoxShadow(
                  color: const Color(0xFF656565).withOpacity(0.15),
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
//           offset: Offset(4.0, 10.0)
                )
              ]),
              child: Center(
                child: Text(
                  txtTitle ?? "",
                  style: TextStyle(fontFamily: 'Amira', color: Colors.white, fontSize: 59.0, letterSpacing: 2.0, shadows: [
                    Shadow(
                      color: Colors.black12.withOpacity(0.1),
                      blurRadius: 2.0,
                    )
                  ]),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 10.0),
            child: Text(
              txtHeader!,
              style: const TextStyle(
                fontFamily: "Sofia",
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
