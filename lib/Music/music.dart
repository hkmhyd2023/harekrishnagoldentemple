import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:harekrishnagoldentemple/Music/ADP.dart';
import 'package:harekrishnagoldentemple/Music/Song.dart';
import 'package:nb_utils/nb_utils.dart';

class Music extends StatefulWidget {
  const Music({super.key});

  @override
  State<Music> createState() => _MusicState();
}

class _MusicState extends State<Music> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Music"),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Trending Kirtans",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Music")
                .where('Trending', isEqualTo: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (!snapshot.hasData) {
                return const Text('No data found');
              }
              return Container(
                height: 320,
                child: Padding(
                  padding: const EdgeInsets.only(left: 9.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.size,
                    itemBuilder: (BuildContext context, int index) {
                      final DocumentSnapshot document =
                          snapshot.data!.docs[index];
                      return InkWell(
                        onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: ((context) => Song(documentSnapshot: document))));},
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                height: 300,
                                width: MediaQuery.of(context).size.width * 0.55,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            document['Trending-Image']),
                                        fit: BoxFit.cover)),
                              ),
                              Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.47,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      color: Colors.white.withOpacity(0.8)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            document["Title"],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                    color: Colors.orange,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                          Text(
                                            document[
                                                "Trending-Music-Description"],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.play_circle,
                                        color: Colors.orange,
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
          20.height,
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Albums",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Music-Albums")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (!snapshot.hasData) {
                return const Text('No data found');
              }
              return Container(
                
                child: Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final DocumentSnapshot document =
                          snapshot.data!.docs[index];
                      return Container(
                        height: 75,
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(color: Colors.grey.shade200.withOpacity(0.6), borderRadius: BorderRadius.circular(15.0)),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.network(
                              document['Image'],
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 20,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  document['Title'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontWeight: FontWeight.bold, color: Colors.orange),
                                ),
                                Text(
                                  "Kirtans",
                                  maxLines: 2,
                                  style: Theme.of(context).textTheme.bodySmall,
                                )
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () 
                            {Navigator.of(context).push(MaterialPageRoute(builder: ((context) => ADP(documentSnapshot: document))));},
                            icon: const Icon(Icons.play_circle),
                            color: Colors.orange,
                          )
                        ]),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      )),
    );
  }
}
