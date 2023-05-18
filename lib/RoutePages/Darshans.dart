import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:restart_app/restart_app.dart';

class Darshans extends StatefulWidget {
  const Darshans({super.key});

  @override
  State<Darshans> createState() => _DarshansState();
}

class _DarshansState extends State<Darshans> {
      Map likes = {};
    int likeCount = 0;
    bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    Color color = Colors.red;


    List docID = [];
    return Scaffold(
      appBar: AppBar(
        title: Text("Darshans"),
        backgroundColor: Colors.white,
        elevation: 9,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "   Blessings from Sri Sri Radha Govinda",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "   from HKM Hyderabad",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("Darshans").snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData) {
                  return const Text('No data found');
                }
                return ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                   physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.size,
                  itemBuilder: (BuildContext context, int index) {
                    final DocumentSnapshot document =
                        snapshot.data!.docs[index];
                    return Column(
                      children: [
                        Card(
                          color: white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
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
                                    child: Image.network(document['Image'],
                                        height: 200,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover),
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
                                                "${document['Flowers_Offered']} Flowers Offered",
                                                style: TextStyle(fontSize: 15),
                                              )),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                 bool _isLiked = likes[FirebaseAuth
                                                    .instance
                                                    .currentUser!
                                                    .uid] ==
                                                true;
                                            if (_isLiked) {
                                              FirebaseFirestore.instance
                                                  .collection('Darshans')
                                                  .doc(document.id)
                                                  .update({
                                                "Flowers_Offered":
                                                    FieldValue.increment(-1)
                                              });
                                              setState(() {
                                                likeCount -= 1;
                                                isLiked = false;
                                                docID.add(document.id);
                                                likes[FirebaseAuth.instance
                                                    .currentUser!.uid] = false;
                                              });
                                              print (likeCount);
                                              print (isLiked);
                                              print (docID);
                                              print (likes);
                                            } else if (!_isLiked) {
                                              FirebaseFirestore.instance
                                                  .collection('Darshans')
                                                  .doc(document.id)
                                                  .update({
                                                "Flowers_Offered": FieldValue.increment(1)
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
                                              child: Image.network(
                                                "https://static.thenounproject.com/png/14177-200.png",
                                                height: 35,
                                                width: 35,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  10.height,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: Text(
                                          document['Description'],
                                          style: secondaryTextStyle(
                                              size: 16, color: Colors.black45),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: Text(
                                          document['Date'],
                                          style: secondaryTextStyle(
                                              size: 16, color: Colors.black45),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                        ),
                        10.height,
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
