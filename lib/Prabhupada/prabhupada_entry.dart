import 'package:flutter/material.dart';
import 'package:harekrishnagoldentemple/Prabhupada/prabhupada_about.dart';
import 'package:harekrishnagoldentemple/Prabhupada/prabhupada_feeds.dart';
import 'package:harekrishnagoldentemple/Prabhupada/prabhupada_quotes.dart';
import 'package:nb_utils/nb_utils.dart';

class PrabhupadaEntry extends StatefulWidget {
  const PrabhupadaEntry({super.key});

  @override
  State<PrabhupadaEntry> createState() => _PrabhupadaEntryState();
}

class _PrabhupadaEntryState extends State<PrabhupadaEntry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Srila Prabhupada Lila"), backgroundColor: Colors.white,),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          SizedBox(height: 20
          ,),
          InkWell(
                onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const PrabhupadaAbout()));     },
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://www.mahanidhiswami.com/wp-content/uploads/2018/10/Prabhupada-iskcon.jpeg"),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Container(
                    height: 89.0,
                    width: MediaQuery.of(context).size.width / 1.7,
                    decoration: BoxDecoration(
                        color: Colors.black12.withOpacity(0.2),
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
              20.height,
          InkWell(
                onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const PrabhupadaQuotes()));     },
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://www.srilaprabhupada.co.in/images/abuout-prabhupada.jpg"),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Container(
                    height: 89.0,
                    width: MediaQuery.of(context).size.width / 1.7,
                    decoration: BoxDecoration(
                        color: Colors.black12.withOpacity(0.2),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 160.0, left: 15.0),
                      child: Text(
                        "Quotes",
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
Navigator.push(context, MaterialPageRoute(builder: (context) => const PrabhupadaFeeds()));                },
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://theharekrishnamovement.files.wordpress.com/2022/08/prabhupada-with-books.webp"),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Container(
                    height: 89.0,
                    width: MediaQuery.of(context).size.width / 1.7,
                    decoration: BoxDecoration(
                        color: Colors.black12.withOpacity(0.2),
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