import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class YatraDetail extends StatefulWidget {
  final String title;
  final String image;
  final String DaysN;
  final String MaxPeople;
  final String location;
  final String Description;
  final String Cost;

  const YatraDetail({super.key, required this.title, required this.image, required this.DaysN, required this.MaxPeople, required this.location, required this.Description, required this.Cost});

  @override
  State<YatraDetail> createState() => _YatraDetailState();
}

class _YatraDetailState extends State<YatraDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
            appBar: AppBar(automaticallyImplyLeading: true, backgroundColor: Colors.white, title: Text(widget.title),),

      body: Builder(builder: (BuildContext context) {
        double heightFromWhiteBg =
            MediaQuery.of(context).size.height - 300.0; // height for white section
        return SingleChildScrollView(
          child: Column(children: [Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Positioned(
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: NetworkImage(
                            "${widget.image}"),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 350.0,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    height: heightFromWhiteBg,
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 20.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.title,
                              style: TextStyle(
                                fontSize: 23.0,
                                height: 1.5,
                                fontFamily: "Sofia",
                                color: Color.fromRGBO(33, 45, 82, 1),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
Row(children: [
                        //Property features
                        item(Icons.people_alt, widget.MaxPeople),
          SizedBox(
            width: 10.0,
          ),
          item(Icons.lock_clock, widget.DaysN)],),

                        SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          widget.Description,
                          style: TextStyle(
                            fontSize: 16.0,
                            height: 1.5,
                            fontFamily: "Sofia",
                            color: Colors.black45,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        Container(
                          width: double.infinity,
                          height: 50,
                          padding: EdgeInsets.only(left: 16.0, right: 5.0),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 123, 0),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "\₹${widget.Cost} / ",
                                      style: TextStyle(
                                        fontSize: 19.0,
                                        height: 1.5,
                                        fontFamily: "Sofia",
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " Exclusive of Flight Charges",
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        height: 1.5,
                                        fontFamily: "Sofia",
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),],)
        );
      }
      ),);

  }


Widget item(IconData icon, String text) {
  return Expanded(
    child: Container(
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16.0,
            color: Color(0xFF494A6A),
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(text,
              style: TextStyle(
                  fontFamily: "Sofia", fontSize: 12.0, color: Colors.grey))
        ],
      ),
    ),
  );
}

}