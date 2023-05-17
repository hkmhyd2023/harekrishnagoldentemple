import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harekrishnagoldentemple/Music/Song.dart';
import 'package:nb_utils/nb_utils.dart';

class ADP extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  ADP({super.key, required this.documentSnapshot});

  @override
  State<ADP> createState() => _ADPState();
}

class _ADPState extends State<ADP> {
  bool isPlay = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.documentSnapshot['Title']),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    widget.documentSnapshot['Image'],
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.7,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  widget.documentSnapshot['Title'],
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Music")
                  .where('Album', isEqualTo: widget.documentSnapshot["Title"])
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
                  itemBuilder: (BuildContext context, int index) {
                    final DocumentSnapshot document =
                        snapshot.data!.docs[index];
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(15.0)),
                          child: ListTile(
                              leading: Text(
                                '${index + 1}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                              ),
                              title: Text(
                                document['Title'],
                                style: TextStyle(color: Colors.orange),
                              ),
                              subtitle: Text("${document['Likes']} Likes"),
                              trailing: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Song(documentSnapshot: document)));
                                },
                                child: Icon(
                                  Icons.play_circle,
                                  color: Colors.orange,
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      )),
    );
  }
}
