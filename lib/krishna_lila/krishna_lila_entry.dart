import 'package:flutter/material.dart';
import 'package:harekrishnagoldentemple/krishna_lila/krishna_lila_bg.dart';
import 'package:harekrishnagoldentemple/krishna_lila/krishna_lila_dwaraka.dart';
import 'package:harekrishnagoldentemple/krishna_lila/krishna_lila_mathura.dart';
import 'package:harekrishnagoldentemple/krishna_lila/krishna_lila_vrindavan.dart';

class KLEntry extends StatefulWidget {
  const KLEntry({super.key});

  @override
  State<KLEntry> createState() => _KLEntryState();
}

class _KLEntryState extends State<KLEntry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sri Krishna Lila"), backgroundColor: Colors.white,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            SizedBox(height: 20,),
            InkWell(
                  onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const KLBG()));                },
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://bhagavadgita.io/static/images/gita/bhagavadgita-6.jpg"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Container(
                      height: 89.0,
                      width: MediaQuery.of(context).size.width / 1.7,
                      decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 160.0, left: 15.0),
                        child: Text(
                          "Bhagavad Gita",
                          style: TextStyle(
                              fontFamily: "Sofia",
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0),
                        ),
                      ),
                    ),
                  ),
                ),
            SizedBox(height: 20
            ,),
            InkWell(
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const KLVrindavan()));     },
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://images.unsplash.com/photo-1583134993393-07aa230888f9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dnJpbmRhdmFuJTJDJTIwaW5kaWF8ZW58MHx8MHx8&w=1000&q=80"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Container(
                      height: 89.0,
                      width: MediaQuery.of(context).size.width / 1.7,
                      decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 160.0, left: 15.0),
                        child: Text(
                          "Vrindavan Lila",
                          style: TextStyle(
                              fontFamily: "Sofia",
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0),
                        ),
                      ),
                    ),
                  ),
                ),
                
      SizedBox(height: 20,),
                InkWell(
                  onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const KLMathura()));                },
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://cdn.wallpapersafari.com/40/49/fRLBY4.jpg"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Container(
                      height: 89.0,
                      width: MediaQuery.of(context).size.width / 1.7,
                      decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 160.0, left: 15.0),
                        child: Text(
                          "Mathura Lila",
                          style: TextStyle(
                              fontFamily: "Sofia",
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                 InkWell(
                  onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const KLDwaraka()));                },
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://i.pinimg.com/736x/54/9b/94/549b947d0c903dc43354251a3eaa48e3.jpg"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Container(
                      height: 89.0,
                      width: MediaQuery.of(context).size.width / 1.7,
                      decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 160.0, left: 15.0),
                        child: Text(
                          "Dwaraka Lila",
                          style: TextStyle(
                              fontFamily: "Sofia",
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0),
                        ),
                      ),
                    ),
                  ),
                ),
          ]),
        ),
      ),
    );
  }
}