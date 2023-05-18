import 'package:flutter/material.dart';
import 'package:harekrishnagoldentemple/Prabhupada/prabhupada_about.dart';
import 'package:harekrishnagoldentemple/Prabhupada/prabhupada_feeds.dart';
import 'package:harekrishnagoldentemple/Prabhupada/prabhupada_quotes.dart';
import 'package:harekrishnagoldentemple/chaitanyaLilamrita/chaitanyaMahaprabhuAbout.dart';
import 'package:harekrishnagoldentemple/chaitanyaLilamrita/chaitanyaMahaprabhuFeeds.dart';
import 'package:nb_utils/nb_utils.dart';

class ChaitanyaMahaPrabhuEntry extends StatefulWidget {
  const ChaitanyaMahaPrabhuEntry({super.key});

  @override
  State<ChaitanyaMahaPrabhuEntry> createState() => _ChaitanyaMahaPrabhuEntryState();
}

class _ChaitanyaMahaPrabhuEntryState extends State<ChaitanyaMahaPrabhuEntry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sri Chaitanya Lila"), backgroundColor: Colors.white,),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          SizedBox(height: 20
          ,),
          InkWell(
                onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const ChaitanyaMahaPrabhuAbout()));     },
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://wallpaperaccess.com/full/8317986.jpg"),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Container(
                    height: 89.0,
                    width: MediaQuery.of(context).size.width / 1.7,
                    decoration: BoxDecoration(
                        color: Colors.black12.withOpacity(0.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 160.0, left: 15.0),
                      child: Text(
                        "Biography",
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
              
SizedBox(height: 20,),
              InkWell(
                onTap: () {
Navigator.push(context, MaterialPageRoute(builder: (context) => const ChaitanyaMahaPrabhuFeeds()));                },
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://hindipath.com/wp-content/uploads/2021/09/chaitanya-mahaprabhu-hindi-life-story-1.jpg"),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Container(
                    height: 89.0,
                    width: MediaQuery.of(context).size.width / 1.7,
                    decoration: BoxDecoration(
                        color: Colors.black12.withOpacity(0.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 160.0, left: 15.0),
                      child: Text(
                        "Feeds",
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
        ]),
      ),
    );
  }
}