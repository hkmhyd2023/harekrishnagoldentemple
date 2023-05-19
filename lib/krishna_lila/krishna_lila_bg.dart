import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class KLBG extends StatefulWidget {
  const KLBG({super.key});

  @override
  State<KLBG> createState() => _KLBGState();
}

class _KLBGState extends State<KLBG> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bhagavad Gita"), backgroundColor: Colors.white,),

      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Column(children: [
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("KLBG").snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData) {
                  return const Text('No data found');
                }
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.size,
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
                                        Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: Row(
                                            
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text (""),
                                                        Text(document['Date'], style: TextStyle(),)
                                                      ],
                                                    ),
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
      
        ],),
      )),
    );
  }
}