import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ChaitanyaMahaPrabhuAbout extends StatefulWidget {
  const ChaitanyaMahaPrabhuAbout({super.key});

  @override
  State<ChaitanyaMahaPrabhuAbout> createState() => _ChaitanyaMahaPrabhuAboutState();
}

class _ChaitanyaMahaPrabhuAboutState extends State<ChaitanyaMahaPrabhuAbout> {
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
                      "https://www.iskconbangalore.org/wp-content/uploads/2015/10/lord-chaitanya-850x495.jpg",
                  id: "id-${"Chaitanya Mahaprabhu"}",
                  title: "Sri Chaitanya Mahaprabhu",),
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
                      ''''Chaitanya Mahaprabhu was a 15th century Vedic spiritual leader, who is considered an avatar of Lord Krishna by his followers. Chaitanya founded Gaudiya Vaishnavism, which is a religious movement that promotes Vaishnavism or worship of Lord Vishnu as the Supreme Soul. Gaudiya Vaishnavism teaches the acceptance of Bhakti yoga as a method to realize the ultimate truth. Chaitanya Mahaprabhu is credited with popularizing the ‘Maha Mantra’ or ‘Hare Krishna Mantra.’ He is also known for composing in Sanskrit a prayer of eight verses, known as ‘Siksastakam.’ Said to have been born with features similar to that of Lord Krishna, Chaitanya Mahaprabhu was a child prodigy, and became a scholar at a very young age. He even opened a school and had thousands of followers very early in his life. Though not much about his sudden and mysterious disappearance or demise is known, a few scholars and researchers believe that he might have died of epilepsy. However, this conclusion is still debatable as there are other accounts that suggest various other theories, including a theory of murder and magical disappearance.''',
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
