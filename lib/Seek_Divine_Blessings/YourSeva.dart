import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:harekrishnagoldentemple/Home/widgets/app_drawer_component.dart';
import 'package:harekrishnagoldentemple/NoInternet.dart';
import 'package:nb_utils/nb_utils.dart';

class YourSevaList extends StatefulWidget {
  const YourSevaList({super.key});

  @override
  State<YourSevaList> createState() => _YourSevaListState();
}

class _YourSevaListState extends State<YourSevaList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Offerings", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.orange.shade300,
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          10.height,
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('Seva-Donation').doc("${FirebaseAuth.instance.currentUser!.uid}").collection("${FirebaseAuth.instance.currentUser!.uid}").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = snapshot.data!.docs[index];
                      return Card(
                        elevation: 5,
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: ListTile(
                          title: Text(
                            'Seva: ${document['Seva']}',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Date of Seva: ${document['DateOfSeva']}',
                            style: TextStyle(fontSize: 16),
                          ),
                          // You can access other fields in your document as well
                          // Example: document['field_name']
                        ),
                      );
                    },
                  );
                }}),
          ),
        ],
      ),
    );
}}