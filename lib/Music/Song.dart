import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Song extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  Song({super.key, required this.documentSnapshot});
  @override
  State<Song> createState() => _SongState();
}

class _SongState extends State<Song> {
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  @override
  void initState() {
    super.initState();

    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {
        isPlaying = event == PlayerState.playing;
      });
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        title: Text(widget.documentSnapshot["Title"]),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.passthrough,
        children: [
          Image.network(widget.documentSnapshot['Image']),
          const _BackgroundFilter(),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.documentSnapshot["Title"],
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.documentSnapshot["SubTitle"],
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.white),
                  maxLines: 2,
                ),
                SizedBox(height: 20,),
                Slider(
                  activeColor: Colors.orange,
                  thumbColor: Colors.white,
                  inactiveColor: Colors.white,
                  min: 0,
                  max: duration.inSeconds.toDouble(),
                  value: position.inSeconds.toDouble(),
                  onChanged: (value) async {
                    final position = Duration(seconds: value.toInt());
                    await audioPlayer.seek(position);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatTime(position),
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        formatTime(duration),
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () async {
                                                    await audioPlayer.pause();
                          Duration targetPosition = position - const Duration(seconds: 5);
                          await audioPlayer.seek(targetPosition);
                          await audioPlayer.resume();
                        },
                        icon: Icon(Icons.fast_rewind),
                        iconSize: 40,
                        color: Colors.white),
                    IconButton(
                      onPressed: () async {
                        if(isPlaying) {
                          await audioPlayer.pause();
                        } else {
                          await audioPlayer.play(UrlSource(widget.documentSnapshot['Song']));
                        }
                      },
                      icon: Icon(
                          isPlaying ? Icons.pause_circle : Icons.play_circle),
                      iconSize: 60,
                      color: Colors.white,
                    ),
                    IconButton(
                        onPressed: () async {
                          await audioPlayer.pause();
                          Duration targetPosition = position + const Duration(seconds: 5);
                          await audioPlayer.seek(targetPosition);
                          await audioPlayer.resume();
                        },
                        icon: Icon(Icons.fast_forward),
                        iconSize: 40,
                        color: Colors.white),
                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [IconButton(onPressed: () {                  FirebaseFirestore.instance.collection("Music").doc(widget.documentSnapshot.id).update({"Likes": FieldValue.increment(1)});
}, icon: Icon(Icons.favorite, color: Colors.red), ), IconButton(onPressed: () {
                }, icon: Icon(Icons.library_add, color: Colors.white,), )],)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BackgroundFilter extends StatelessWidget {
  const _BackgroundFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.white.withOpacity(0.5),
              Colors.white.withOpacity(0.0)
            ],
            stops: const [
              0.0,
              0.4,
              0.6
            ]).createShader(bounds);
      },
      blendMode: BlendMode.dstOut,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.deepOrange.shade500, Colors.orange])),
      ),
    );
  }
}
