import 'package:flutter/material.dart';

class MyPlayList extends StatefulWidget {
  const MyPlayList({super.key});

  @override
  State<MyPlayList> createState() => _MyPlayListState();
}

class _MyPlayListState extends State<MyPlayList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("My Playlist"),
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
                    "https://www.mygodpictures.com/wp-content/uploads/2015/05/Abhay-Charanaravinda-Bhaktivedanta-Swami-Prabhupada-Smiling.jpg",
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.7,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "My Playlist",
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
            ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
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
                                "Title Here",
                                style: TextStyle(color: Colors.orange),
                              ),
                              subtitle: Text("Subtitle Here"),
                              trailing: GestureDetector(
                                onTap: () {
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
                ),
          ],
        ),
      )),
    );
  }
}