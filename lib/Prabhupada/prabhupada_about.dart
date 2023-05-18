import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class PrabhupadaAbout extends StatefulWidget {
  const PrabhupadaAbout({super.key});

  @override
  State<PrabhupadaAbout> createState() => _PrabhupadaAboutState();
}

class _PrabhupadaAboutState extends State<PrabhupadaAbout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            /// AppBar
            SliverPersistentHeader(
              delegate: MySliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.height - 30.0,
                  img:
                      "https://www.iskconbangalore.org/wp-content/uploads/2016/05/srila-prabhupada-103.jpg",
                  id: "id-${"Srila Prabhupada"}",
                  title: "Srila Prabhupada",),
              pinned: true,
            ),

            SliverToBoxAdapter(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  // StreamBuilder(
                  //   stream: Firestore.instance
                  //       .collection('users')
                  //       .document(widget.userId)
                  //       .snapshots(),
                  //   builder: (context, snapshot) {
                  //     if (!snapshot.hasData) {
                  //       return new Text("Loading");
                  //     } else {
                  //       var userDocument = snapshot.data;
                  //       _nama = userDocument["name"];
                  //       _email = userDocument["email"];
                  //       _photoProfile = userDocument["photoProfile"];
                  //     }

                  //     var userDocument = snapshot.data;
                  //     return Container();
                  //   },
                  // ),

                  Container(
                    height: 2.0,
                    width: double.infinity,
                    color: Colors.black12.withOpacity(0.03),
                  ),

                  SizedBox(
                    height: 15.0,
                  ),

                  Container(
                    height: 20.0,
                    width: double.infinity,
                    color: Colors.black12.withOpacity(0.03),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),

                  /// Description
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
                    child: Text(
                      "Description",
                      style: TextStyle(
                          fontFamily: "Sofia",
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0.0, left: 20.0, right: 20.0, bottom: 0.0),
                    child: Text(
                      ''''Srila Prabhupada – At various times people have called him a scholar, a philosopher, a cultural ambassador, a prolific author, a religious leader, a spiritual teacher, a social critic, and a holy man. In truth, he was all these things and more.

Over five hundred years ago, Lord Sri Krishna appeared as Sri Chaitanya Mahaprabhu in Navadvipa, a village in West Bengal. The purpose of His appearance was to inaugurate the Sankirtana Movement, the Yuga Dharma for this age of Kali. He declared that the chanting of His holy names would spread beyond the shores of India to every town and village in the world. He predicted that His commander-in-chief would appear to accomplish this mission.

Yes… Srila Prabhupada appeared to fulfill this prophecy.

On September 01, 1896, the day after Janmashtami (the auspicious appearance day of Lord Sri Krishna) in a little house in the Tollygunge suburb of Calcutta, a male child was born. His father, Gour Mohan De, and his mother Rajani, named him Abhay Charan (one who is fearless – having taken shelter at the lotus feet of Lord Krishna).

An astrologer prepared the horoscope for the baby and revealed: When this child reaches the age of seventy, he will cross the ocean, become a great teacher of religion and establish 108 Krishna temples.

And this is exactly what happened.

Srila Prabhupada set out to America in 1965 and established the International Society for Krishna Consciousness at the age of sixty-nine. He travelled around the world fourteen times, established more than 100 temples of Krishna and initiated more than 10000 disciples into Krishna consciousness.''',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontFamily: "Sofia",
                          color: Colors.black54,
                          fontSize: 18.0),
                      overflow: TextOverflow.clip,
                    ),
                  ),


                  /// service

                  //Text(_nama),

                  SizedBox(
                    height: 60.0,
                  ),

                  /// Button
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        
                        InkWell(
                          
                          onTap: () async {},
                          child: Container(
                            height: 55.0,
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.orange,
                                      Colors.deepOrange
                                    ],
                                    begin: const FractionalOffset(0.0, 0.0),
                                    end: const FractionalOffset(1.0, 0.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp)),
                            child: Center(
                              child: Text(
                                "Know More ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19.0,
                                    fontFamily: "Sofia",
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ])),
          ],
        ),
      ),
    );
  }
}


class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  String? img, id, title, location;
  num? price;
  double? ratting;

  MySliverAppBar(
      {required this.expandedHeight,
      this.img,
      this.id,
      this.title,
      this.price,
      this.location,
      this.ratting});

  var _txtStyleTitle = TextStyle(
    color: Colors.black54,
    fontFamily: "Sofia",
    fontSize: 20.0,
    fontWeight: FontWeight.w800,
  );

  var _txtStyleSub = TextStyle(
    color: Colors.black26,
    fontFamily: "Sofia",
    fontSize: 12.5,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          height: 50.0,
          width: double.infinity,
          color: Colors.white,
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            "${title}",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Gotik",
              fontWeight: FontWeight.w700,
              fontSize: (expandedHeight / 40) - (shrinkOffset / 40) + 18,
            ),
          ),
        ),
        Opacity(
          opacity: (1 - shrinkOffset / expandedHeight),
          child: Hero(
            tag: 'hero-tag-${id}',
            child: new DecoratedBox(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: new NetworkImage(img!),
                ),
                shape: BoxShape.rectangle,
              ),
              child: Container(
                margin: EdgeInsets.only(top: 620.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(0.0, 1.0),
                    stops: [0.0, 1.0],
                    colors: <Color>[
                      Color(0x00FFFFFF),
                      Color(0xFFFFFFFF),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, right: 20.0, left: 20.0, bottom: 40.0),
              child: Container(
                height: 210.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.white.withOpacity(0.85)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                    width: 270.0,
                                    child: Text(
                                      title!,
                                      style: _txtStyleTitle.copyWith(
                                          fontSize: 27.0),
                                      overflow: TextOverflow.clip,
                                    )),
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
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                      child: Container(
                          height: 35.0,
                          width: 35.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(40.0),
                            ),
                            color: Colors.white70,
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          )),
                    ))),
            SizedBox(
              width: 36.0,
            )
          ],
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
