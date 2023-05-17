
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RDetail extends StatefulWidget {
  final DocumentSnapshot document;

  const RDetail({super.key, required this.document});

  @override
  State<RDetail> createState() => _RDetailState();
}

class _RDetailState extends State<RDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.document['Title']), backgroundColor: Colors.white,),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            
            SizedBox(height: 20),            


            //Image
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Stack(
                children: [
                  Image.network(widget.document['Image'], width: MediaQuery.of(context).size.width, height: 250, fit: BoxFit.cover),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Text(
                      widget.document['Title'],
                      style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            //Food information
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                color: Colors.orange.shade200,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network('https://png.pngtree.com/png-vector/20220915/ourmid/pngtree-calories-png-image_6176429.png', height: 35, width: 35, fit: BoxFit.cover),
                          SizedBox(height: 4),
                          Text('${widget.document['Calories']}', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
                          Text('Calories', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12, color: Colors.black)),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network('https://www.freepnglogos.com/uploads/salt-png/determination-sodium-and-salt-content-food-samples-10.png', height: 35, width: 35, fit: BoxFit.cover),
                          SizedBox(height: 4),
                          Text(widget.document['Salt'], style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
                          Text('Salt', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12, color: Colors.black)),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network('https://www.pngall.com/wp-content/uploads/2016/07/Sugar-Free-Download-PNG.png', height: 35, width: 35, fit: BoxFit.cover),
                          SizedBox(height: 4),
                          Text(widget.document['Sugar'], style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
                          Text('Sugar', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12, color: Colors.black)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),

            //Ingredients title line
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Ingredients', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
              ],
            ),

            SizedBox(height: 16),

Column(children: [
                      StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("RCDetail")
                  .doc(widget.document.id)
                  .collection("Ingredients")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData) {
                  return const Text('No data found');
                }
                return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: (1 / 1.5), mainAxisSpacing: 16, crossAxisSpacing: 16),
        physics:  NeverScrollableScrollPhysics(),
        itemCount: snapshot.data!.size,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
                                final DocumentSnapshot document =
                          snapshot.data!.docs[index];
          return ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: InkWell(
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width / 3 - 16,
                      color: Colors.orange.shade200,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Image.network(
                              document['Image'],
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(document['Title'], style: TextStyle(fontSize: 12, color: Colors.black)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        },
          );
              },
            ),
          ]),

            SizedBox(height: 16),

            Align(
              alignment: Alignment.centerLeft,
              child: Text('Directions', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
            ),

            SizedBox(height: 16),
            
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("RCDetail")
                  .doc(widget.document.id)
                  .collection('Directions')
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
                    return Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.orange.shade200,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                        child: Row(
                          children: [
                            Text((index + 1).toString(), style: TextStyle(color: Colors.orange.shade900, fontSize: 20, fontWeight: FontWeight.w700)),
                            SizedBox(width: 8),
                            Expanded(child: Text(document['Text'], style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500))),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
                  },
                );
              },
            ),

            SizedBox(height: 8),

          ],
        ),
      ),
    );

  }
}