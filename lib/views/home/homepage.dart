import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';

import 'package:translator/translator.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? debounce;
  String selectedValuefrom = 'English';
  String selectedValueto = 'Spanish';
  String from = 'en';
  String to = 'es';
  String data = '';
  final user = FirebaseAuth.instance.currentUser;
  final TextEditingController _translateFrom = TextEditingController();
  List<String> languages = [
    'English',
    'Yoruba',
    'Spanish',
    'Japanese',
    'Arabic',
    'French',
    'Russian',
    'Igbo'
  ];
  List<String> languagesCode = ['en', 'yo', 'es', 'ja', 'ar', 'fr', 'ru', 'ig'];
  FlutterTts flutterTts = FlutterTts();
  final translator = GoogleTranslator();
  bool _loading = false;

  translate() async {
    try {
      debounce?.cancel();
      debounce = Timer(const Duration(milliseconds: 800), () async {
        await translator
            .translate(_translateFrom.text, from: from, to: to)
            .then((value) {
          _loading = false;
          setState(() {
            data = value.text;
          });

          print(value);

          //  Future.delayed(const Duration(seconds: 5));
          FirebaseFirestore.instance
              .collection("users")
              .doc(user!.uid)
              .collection("history")
              .add({
            'from': _translateFrom.text,
            'to': data,
            'time': DateTime.now().toString()
          });
        });
      });
    } on SocketException catch (_) {
      _loading = true;
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Icon(
                Icons.warning,
                color: Colors.red,
              ),
              content: Column(
                children: [
                  const Text('No Internet'),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Exit',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  )
                ],
              ),
            );
          });
      setState(() {});
    }
  }
  //final TextEditingController _translateTo = TextEditingController();

  Future speakFromtranslation(_translateFrom) async {
    await flutterTts.speak(_translateFrom.text);
    await flutterTts.setLanguage(from);
  }

  Future speakFromTranslated(data) async {
    await flutterTts.speak(data);
    await flutterTts.setLanguage(to);
  }

  @override
  void initState() {
    translate();
    super.initState();
  }

  @override
  void dispose() {
    //translate().dispose();speakFromtranslation
    debounce?.cancel();
    _translateFrom.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Translator',
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 25),
        ),
        backgroundColor: const Color(0xff151716),
      ),
      backgroundColor: const Color(0xff151716),
      body: Center(
        child: ListView(
          //shrinkWrap: true,
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[900],
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton(
                        icon: Transform.rotate(
                            angle: pi / 2,
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: Colors.white,
                            )),
                        dropdownColor: Colors.grey[800],
                        value: selectedValuefrom,
                        items: languages.map((lang) {
                          return DropdownMenuItem(
                            value: lang,
                            child: Text(
                              lang,
                              style: GoogleFonts.poppins(
                                  fontSize: 20, color: Colors.white),
                            ),
                            onTap: () {
                              if (lang == languages[0]) {
                                from = languagesCode[0];
                              } else if (lang == languages[1]) {
                                from = languagesCode[1];
                              } else if (lang == languages[2]) {
                                from = languagesCode[2];
                              } else if (lang == languages[3]) {
                                from = languagesCode[3];
                              } else if (lang == languages[4]) {
                                from = languagesCode[4];
                              } else if (lang == languages[5]) {
                                from = languagesCode[5];
                              } else if (lang == languages[6]) {
                                from = languagesCode[6];
                              } else if (lang == languages[7]) {
                                from = languagesCode[7];
                              } else if (lang == languages[8]) {
                                from = languagesCode[8];
                              }
                              setState(() {
                                //translate();
                              });
                            },
                          );
                        }).toList(),
                        onChanged: ((value) {
                          selectedValuefrom = value!;
                        }),
                      ),
                      const Icon(
                        Icons.translate_outlined,
                        color: Colors.white,
                      ),
                      DropdownButton(
                        icon: Transform.rotate(
                            angle: pi / 2,
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: Colors.white,
                            )),
                        dropdownColor: Colors.grey[800],
                        value: selectedValueto,
                        items: languages.map((lang) {
                          return DropdownMenuItem(
                            value: lang,
                            child: Text(
                              lang,
                              style: GoogleFonts.poppins(
                                  fontSize: 20, color: Colors.white),
                            ),
                            onTap: () {
                              if (lang == languages[0]) {
                                to = languagesCode[0];
                              } else if (lang == languages[1]) {
                                to = languagesCode[1];
                              } else if (lang == languages[2]) {
                                to = languagesCode[2];
                              } else if (lang == languages[3]) {
                                to = languagesCode[3];
                              } else if (lang == languages[4]) {
                                to = languagesCode[4];
                              } else if (lang == languages[5]) {
                                to = languagesCode[5];
                              } else if (lang == languages[6]) {
                                to = languagesCode[6];
                              } else if (lang == languages[7]) {
                                to = languagesCode[7];
                              } else if (lang == languages[8]) {
                                to = languagesCode[8];
                              }
                              setState(() {
                                translate();
                              });
                            },
                          );
                        }).toList(),
                        onChanged: ((value) {
                          selectedValueto = value!;
                        }),
                      ),
                    ])),
            Container(
              height: 200,
              margin: const EdgeInsets.only(bottom: 20.0),
              decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  //enter your translation here
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        onChanged: (value) async {
                          _translateFrom.text = value;
                          translate();
                        },
                        controller: _translateFrom,
                        textInputAction: TextInputAction.done,
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 20),
                        maxLines: null,
                        //keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey[300]),
                            hintText: 'Translate words...',
                            border: InputBorder.none),
                      ),
                    ),
                  ), //row that contains list of buttons
                  Row(
                    children: [
                      //copy text button
                      IconButton(
                          onPressed: () {
                            setState(() {
                              final data = ClipboardData(
                                  text: _translateFrom.text.trim());
                              Clipboard.setData(data);
                              toastification.show(
                                  alignment: Alignment.center,
                                  style: ToastificationStyle.simple,
                                  type: ToastificationType.success,
                                  context: context,
                                  title: const Text('Text copied'),
                                  autoCloseDuration:
                                      const Duration(seconds: 2));
                            });
                          },
                          icon: const Icon(
                            Icons.copy_outlined,
                            color: Color.fromRGBO(255, 255, 255, 1),
                          )),
                      //speak icon Button
                      IconButton(
                          onPressed: () {
                            speakFromtranslation(_translateFrom.text.trim());
                            toastification.show(
                                alignment: Alignment.center,
                                style: ToastificationStyle.simple,
                                type: ToastificationType.success,
                                context: context,
                                title: const Text('speaker clicked!'),
                                autoCloseDuration: const Duration(seconds: 2));
                          },
                          icon: const Icon(
                            Icons.volume_up,
                            color: Colors.white,
                          )),
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 200,
              margin: const EdgeInsets.only(bottom: 20.0, top: 20),
              decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 20),
                        child: Text(
                          data,
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 20),
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                speakFromTranslated(data);
                              },
                              icon: const Icon(
                                Icons.volume_up,
                                color: Colors.white,
                              )), //copy text from the translated word

                          IconButton(
                              onPressed: () {
                                setState(() {
                                  final copy = ClipboardData(text: data);
                                  Clipboard.setData(copy);
                                  toastification.show(
                                      alignment: Alignment.center,
                                      style: ToastificationStyle.simple,
                                      type: ToastificationType.success,
                                      context: context,
                                      title: const Text('Text copied'),
                                      autoCloseDuration:
                                          const Duration(seconds: 2));
                                });
                              },
                              icon: const Icon(
                                Icons.copy_outlined,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 60,
            )
          ],
        ),
      ),
    );
  }
}
