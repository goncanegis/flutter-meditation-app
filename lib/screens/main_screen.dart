import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meditation_app/models/item_model.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();

  int? _playingIndex;

  List<Item> items = [
    Item(
      name: "Forest Sounds",
      imagePath: "assets/meditation_images/forest.jpeg",
      audioPath: "assets/meditation_audios/forest.mp3",
    ),
    Item(
      name: "Ocean Breeze",
      imagePath: "assets/meditation_images/ocean.jpeg",
      audioPath: "assets/meditation_audios/ocean.mp3",
    ),
    Item(
      name: "Night Sounds",
      imagePath: "assets/meditation_images/night.jpeg",
      audioPath: "assets/meditation_audios/night.mp3",
    ),
    Item(
      name: "Windy Evening",
      imagePath: "assets/meditation_images/wind.jpeg",
      audioPath: "assets/meditation_audios/wind.mp3",
    ),
    Item(
      name: "Waterfall",
      imagePath: "assets/meditation_images/waterfall.jpeg",
      audioPath: "assets/meditation_audios/waterfall.mp3",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(items[index].imagePath),
                  ),
                ),
                child: ListTile(
                  leading: BorderedText(
                    strokeWidth: 4.0,
                    child: Text(
                      items[index].name,
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 34,
                          letterSpacing: .5,
                        ),
                      ),
                    ),
                  ),
                  trailing: IconButton(
                    icon: _playingIndex == index
                        ? const FaIcon(FontAwesomeIcons.stopCircle, size: 40)
                        : const FaIcon(FontAwesomeIcons.playCircle, size: 40),
                    onPressed: () async {
                      if (_playingIndex == index) {
                        setState(() {
                          _playingIndex = null;
                        });

                        audioPlayer.stop();
                      } else {
                        try {
                          await audioPlayer.setAsset(items[index].audioPath);

                          audioPlayer.play();

                          setState(() {
                            _playingIndex = index;
                          });
                        } catch (error) {
                          if (error is SocketException) {
                            print("Socket Exception: ${error.toString()}");
                          }
                          print(error);
                        }
                      }
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
