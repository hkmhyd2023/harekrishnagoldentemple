// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, annotate_overrides

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class KLVrindavan extends StatefulWidget {
  const KLVrindavan({super.key});

  @override
  State<KLVrindavan> createState() => _KLVrindavanState();
}

class _KLVrindavanState extends State<KLVrindavan> {
  Color _prabhupada_color = Colors.red;
  Map likes = {};
  int likeCount = 0;
  bool isLiked = false;
  List docID = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vrindavan Lila"),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          10.height,
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("KV-Lila").snapshots(),
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
                  physics: NeverScrollableScrollPhysics(),
                  reverse: true,
                  itemCount: snapshot.data!.size,
                  itemBuilder: (BuildContext context, int index) {
                    final DocumentSnapshot document =
                        snapshot.data!.docs[index];
                    return Card(
                      color: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection('KV-Lila')
                              .doc(document.id)
                              .update({"Views": FieldValue.increment(1)});
                        },
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16)),
                                child: Image.network(document["Image"],
                                    height: 250,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover),
                              ),
                              10.height,
                              Padding(
                                padding: EdgeInsets.only(left: 16, right: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "${document["Likes"]} Likes, ${document["Views"]} Views"),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            bool _isLiked = likes[FirebaseAuth
                                                    .instance
                                                    .currentUser!
                                                    .uid] ==
                                                true;
                                            if (_isLiked) {
                                              FirebaseFirestore.instance
                                                  .collection('KV-Lila')
                                                  .doc(document.id)
                                                  .update({
                                                "Likes":
                                                    FieldValue.increment(-1)
                                              });
                                              setState(() {
                                                likeCount -= 1;
                                                isLiked = false;
                                                docID.add(document.id);
                                                likes[FirebaseAuth.instance
                                                    .currentUser!.uid] = false;
                                              });
                                            } else if (!_isLiked) {
                                              FirebaseFirestore.instance
                                                  .collection('KV-Lila')
                                                  .doc(document.id)
                                                  .update({
                                                "Likes": FieldValue.increment(1)
                                              });
                                              setState(() {
                                                likeCount += 1;
                                                docID.add(document.id);
                                                isLiked = true;
                                                likes[FirebaseAuth.instance
                                                    .currentUser!.uid] = true;
                                              });
                                            }
                                          },
                                          icon: Icon(
                                            Icons.favorite,
                                            color: _prabhupada_color,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              10.height,
                              Padding(
                                padding: EdgeInsets.only(left: 16, right: 16),
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
                              SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, right: 16.0),
                                child: Text(
                                  "Ref: ${document["Ref"]}",
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
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
          )
        ]),
      ),
    );
  }
}
