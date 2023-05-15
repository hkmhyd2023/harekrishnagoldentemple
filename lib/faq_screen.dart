
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: false ? Colors.black : Colors.orange.shade100,
      appBar: AppBar(
        title: Text("FAQs"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: false ? Colors.white : Colors.black),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: false ? Colors.black : Color(0xFFD9F1EA),
          statusBarIconBrightness: false ? Brightness.light : Brightness.dark,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('FAQs', style: boldTextStyle(size: 22)),
                  SizedBox(height: 8),
                  Text('Your Question got answered', style: secondaryTextStyle(size: 16)),
                ],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("FAQs")
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
                    return Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(color: false ? Theme.of(context).colorScheme.surfaceVariant : Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: ExpansionTile(
                    title: Text(document["Question"], style: primaryTextStyle(color: false ? Colors.white : Color(0xFF000000))),
                    children: [
                      ListTile(
                        title: Text(document["Answer"], style: secondaryTextStyle()),
                      ),
                    ],
                  ),
                );
                },
              );
              },
            ),
            ),
          ],
        ),
      ),
    );
  }
}
