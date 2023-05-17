import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Ekadashi_Reminders extends StatefulWidget {
  Ekadashi_Reminders({Key? key}) : super(key: key);

  @override
  _Ekadashi_RemindersState createState() => _Ekadashi_RemindersState();
}

class _Ekadashi_RemindersState extends State<Ekadashi_Reminders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 9,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Ekadasi",
          style: TextStyle(fontFamily: "Sofia"),
        ),
      ),
      body: _buildPopularFashList(),
    );
  }

  Widget _buildPopularFashList() {
    return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Ekadasi")
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
                                      itemCount: snapshot.data!.size,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      padding: EdgeInsets.only(
        left: 40,
        bottom: 16,
        right: 5,
        top: 20,
      ),
      itemBuilder: (context, index) {
                                final DocumentSnapshot document =
                            snapshot.data!.docs[index];
        return InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.only(left: 8, top: 10.0, bottom: 10.0),
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Color(0xFFE9E8FD),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(document['Image']),
                ),
                SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      document['Title'],
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Sofia",
                          fontWeight: FontWeight.w700),
                    ),
                    Container(
                      width: 150.0,
                      child: Text(
                        document["FastBreakTime"],
                        style: TextStyle(
                            fontFamily: "Sofia",
                            fontWeight: FontWeight.w400,
                            color: Colors.black38),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      document["Date"],
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0XFFcc3e12),
                        fontFamily: "Sofia",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
              },
            );
      },
    );
  }
}
