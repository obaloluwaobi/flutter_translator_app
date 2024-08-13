import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final style = GoogleFonts.poppins(color: Colors.white, fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 20,
              )),
          title: Text(
            'About',
            style: style,
          ),
          backgroundColor: const Color(0xff151716),
        ),
        backgroundColor: const Color(0xff151716),
        body: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
                height: 150,
                width: 150,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('assets/profile.png'),
                      fit: BoxFit.contain),
                )),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              color: Colors.grey[900],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Adewoga Samuel Idowu',
                    style: style,
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    'Edu2002013',
                    style: style,
                  ),
                  Text(
                    'Computer science ',
                    style: style,
                  ),
                  Text(
                    'Olabisi Onabanjo University',
                    style: style,
                  ),
                  Text(
                    '+234 807 580 4938',
                    style: style,
                  ),
                  Text(
                    'Developer: hubstech0@gmail.com',
                    style: style,
                  ),
                ],
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //   child: Text(
            //     'About project',
            //     style: style,
            //   ),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            Container(
              color: Colors.grey[900],
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Text(
                'Translate and TTS is a versatile mobile application developed using Flutter, designed to provide seamless translation services coupled with text-to-speech functionality. This app, created as a school project, aims to break down language barriers and improve pronunciation skills for users across different languages.\n\n Key Features:\n\n1. Text Translation: Supports translation between multiple languages.\n2. Text-to-Speech (TTS): Converts translated text into spoken words for better understanding and pronunciation practice.\n4. History: Allows users to save and revisit their previous translations.\n5. Login: Allows users to log in and sign up\n\nTechnical Highlights:\n\n- Developed using Flutter framework for cross-platform compatibility \n- Integrates with popular translation APIs for accurate and up-to-date translations\n- Utilizes device\'s native TTS capabilities and cloud-based services for high-quality voice output\n - Implements efficient caching mechanisms for improved performance\n - Uses Flutter\'s state management solutions for a responsive user interface\n\nTarget Audience:\nTravelers, language learners, international students, business professionals, and anyone needing quick and reliable translation services.',
                style: style,
              ),
            ),
          ],
        ));
  }
}
