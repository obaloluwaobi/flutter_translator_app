import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';

class TexttoSpeech extends StatefulWidget {
  const TexttoSpeech({super.key});

  @override
  State<TexttoSpeech> createState() => _TexttoSpeechState();
}

class _TexttoSpeechState extends State<TexttoSpeech> {
  final TextEditingController controller = TextEditingController();
  final flutterTts = FlutterTts();
  final bool _play = true;
  double setVolume = 1.0;
  double setPitch = 1.0;
  double setSpeed = 1.0;
  Future get(String text) async {
    // await flutterTts.setSharedInstance(true);
    await flutterTts.setPitch(setPitch);
    await flutterTts.setVolume(setVolume);
    await flutterTts.setSpeechRate(setSpeed);
    await flutterTts.speak(text);
    // await flutterTts.synthesizeToFile(text, "hi.wav");
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   get(controller.text);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff151716),
        title: Text(
          'Text to speech',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
      ),
      backgroundColor: const Color(0xff151716),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
            child: TextFormField(
              style: GoogleFonts.poppins(color: Colors.white),
              maxLines: null,
              minLines: null,
              onChanged: (value) {
                setState(() {
                  value = controller.text;
                });
              },
              controller: controller,
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
                  hintText: 'Type something...',
                  hintStyle: GoogleFonts.poppins(color: Colors.white),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Speed',
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Slider.adaptive(
                      min: 0.0,
                      max: 1.0,
                      value: setSpeed,
                      onChanged: (value) {
                        setState(() {
                          setSpeed = value;
                        });
                      }),
                ),
                Text('${setSpeed.toStringAsFixed(1)}x',
                    style: GoogleFonts.poppins(color: Colors.white))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pitch ',
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                Slider.adaptive(
                    value: setPitch,
                    min: 0.5,
                    max: 2,
                    onChanged: (value) {
                      setState(() {
                        setPitch = value;
                      });
                    }),
                Text('${setPitch.toStringAsFixed(1)}',
                    style: GoogleFonts.poppins(color: Colors.white))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Volume',
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Slider.adaptive(
                      value: setVolume,
                      min: 0,
                      max: 1,
                      onChanged: (value) {
                        setState(() {
                          setVolume = value;
                        });
                      }),
                ),
                const Icon(
                  Icons.volume_up_outlined,
                  color: Colors.white,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: IconButton(
              onPressed: () async {
                get(controller.text);
              },
              icon: const Icon(
                Icons.play_arrow,
                color: Colors.white,
              ),
              iconSize: 40,
            ),
          ),
        ],
      ),
    );
  }
}
