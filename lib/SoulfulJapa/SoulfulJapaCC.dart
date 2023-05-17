import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class SFJCC extends StatefulWidget {
  const SFJCC({super.key});

  @override
  State<SFJCC> createState() => _SFJCCState();
}

class _SFJCCState extends State<SFJCC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cue Cards"), backgroundColor: Colors.white,),

      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Column(children: [
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("SFJCC").snapshots(),
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
                    return Column(
                      children: [
                        ClipRRect(child: Image.network(document['Image']), borderRadius: BorderRadius.circular(20),),
                        20.height,
                      ],
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