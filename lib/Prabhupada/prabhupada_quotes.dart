// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, annotate_overrides


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:restart_app/restart_app.dart';
import './lipsum.dart' as lipsum;

class PrabhupadaQuotes extends StatefulWidget {
  const PrabhupadaQuotes({super.key});

  @override
  State<PrabhupadaQuotes> createState() => _PrabhupadaQuotesState();
}

class _PrabhupadaQuotesState extends State<PrabhupadaQuotes> {
  bool color = false;
  Map likes = {};
  int likeCount = 0;
  bool isLiked = false;
  List docID = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quotes"), backgroundColor: Colors.white,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            10.height,
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("Prabhupada-Quotes")
                                .snapshots(),
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
                                itemCount: snapshot.data!.size,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  
                                  final DocumentSnapshot document =
                                      snapshot.data!.docs[index];
                                        return Card(
                                color: white,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                child: InkWell(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                  onTap: () {},
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(16),
                                              topRight: Radius.circular(16)),
                                          child: Image.network(
                                              document["Image"],
                                              height: 360,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              fit: BoxFit.fill),
                                        ),
                                        10.height,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 16, right: 16),
                                                    child: Text(
                                                      "${document["Flowers_Offered"]} Flowers Offered",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    )),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 16, right: 16),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    child: Image.network(
                                                      "https://static.thenounproject.com/png/14177-200.png",
                                                      height: 35,
                                                      width: 35,
                                                      color: Colors.pink,
                                                    ),
                                                    onTap: () {
                                                      bool _isLiked = likes[FirebaseAuth.instance.currentUser!.uid] == true;
    if (_isLiked) {
      FirebaseFirestore.instance.collection('Prabhupada-Quotes').doc(document.id).update({"Flowers_Offered": FieldValue.increment(-1)});
      setState(() {
        likeCount -= 1;
        isLiked = false;
        docID.add( document.id);
        likes[FirebaseAuth.instance.currentUser!.uid] = false;
      });
    } else if (!_isLiked) {
      FirebaseFirestore.instance.collection('Prabhupada-Quotes').doc(document.id).update({"Flowers_Offered": FieldValue.increment(1)});
      setState(() {
        likeCount += 1;
        docID.add( document.id);
        isLiked = true;
        likes[FirebaseAuth.instance.currentUser!.uid] = true;
      });
    }
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                                      },
                              );
                                },
                                    ),
            )]),
        ),
      );
  }
}