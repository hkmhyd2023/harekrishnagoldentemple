import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SFJV extends StatefulWidget {
  const SFJV({super.key});

  @override
  State<SFJV> createState() => _SFJVState();
}

class _SFJVState extends State<SFJV> {
          Map likes = {};
  int likeCount = 0;
  bool isLiked = false;
  List docID = [];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Modules"),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(9.0),
          child: Column(children: [
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("SFJ").snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData) {
                  return const Text('No data found');
                }
                return ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  itemCount: snapshot.data!.size,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final DocumentSnapshot document =
                        snapshot.data!.docs[index];
                    String url = document["Video"];
                    YoutubePlayerController _controller =
                        YoutubePlayerController(
                            initialVideoId: url,
                            flags: YoutubePlayerFlags(
                                autoPlay: false, mute: false));
                    return Card(
                      color: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        onTap: () {},
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16)),
                                child: YoutubePlayer(controller: _controller),
                              ),
                              10.height,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 16, right: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 300,
                                          child: Text(
                                            document["Title"],
                                            style: boldTextStyle(
                                                size: 16, color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                    onTap: () {
                                                                                                                                            bool _isLiked = likes[FirebaseAuth.instance.currentUser!.uid] == true;
    if (_isLiked) {
      FirebaseFirestore.instance.collection('SFJ').doc(document.id).update({"Likes": FieldValue.increment(-1)});
      setState(() {
        likeCount -= 1;
        isLiked = false;
        docID.add( document.id);
        likes[FirebaseAuth.instance.currentUser!.uid] = false;
      });
    } else if (!_isLiked) {
      FirebaseFirestore.instance.collection('SFJ').doc(document.id).update({"Likes": FieldValue.increment(1)});
      setState(() {
        likeCount += 1;
        docID.add( document.id);
        isLiked = true;
        likes[FirebaseAuth.instance.currentUser!.uid] = true;
      });
    }
                                    },
                                  ),
                                  10.width,
                                ],
                              ),
                              10.height,
                              Padding(
                                padding: EdgeInsets.only(left: 16, right: 16),
                                child: ReadMoreText(
                                  document["Description"],
                                  style: secondaryTextStyle(
                                      size: 16, color: Colors.black),
                                  trimLines: 2,
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: '... Read More',
                                  trimExpandedText: ' Read Less',
                                ),
                              ),
                              10.height,
                              Padding(
                                padding:        EdgeInsets.only(left: 16, right: 16),
                                child: Text("${document["Likes"]} Likes"),
                              ),
                              SizedBox(
                                height: 20,
                              )

                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ]),
        ),
      ),
    );;
  }
}