import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pim/shared/constants.dart';
import 'package:snappable/snappable.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c1,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(bottom: 5.0, left: 20.0, right: 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Snappable(
                  snapOnTap: true,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      'assets/icons/pim_new_logo.png',
                      height: 130.0,
                      width: 130.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Pim Core',
                  style: GoogleFonts.handlee(
                    fontSize: 29.0,
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold,
                    wordSpacing: 1.0,
                    letterSpacing: 2.0,
                  ),
                ),
                Text(
                  'V 2.O',
                  style: GoogleFonts.handlee(
                    fontSize: 18.0,
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold,
                    wordSpacing: 1.0,
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'PIM stands for “Personal Information Manager” and is basically a fancy way to say an application  that stores some basic information that most busy, modern people need to know, and allows it to be consumed easily. Before the electronics age, you might have a little notepad with tabs for various bits of information, but it all amounts to about the same thing either way. \n\nWhat data constitutes a PIM can vary, but for most people, there are four primary pieces of information: appointments, contacts, notes, and tasks. There can be others, and there can even be some overlap between those four, but those are generally considered to be the basics, and they are precisely what PIM Book will contain. This application is presenting four “entities,” which are  appointments, contacts, notes, and tasks. It will provide a way for the user to enter items of each type, store them on the cloud firebase, and present a way for them to be viewed, edited, and deleted.',
                  style: GoogleFonts.handlee(
                    fontSize: 18.0,
                    // color: c2,
                    fontWeight: FontWeight.w700,
                    wordSpacing: 1.0,
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'About Developer',
                  style: GoogleFonts.handlee(
                    fontSize: 29.0,
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold,
                    wordSpacing: 1.0,
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Hi, I\'m Ashish Raturi, a Flutter App Developer this is my Second Project. I start this project on 22-Sep-2020 and completed it within 2 progressive weeks. \n\nThanks For Downloading it :)',
                  style: GoogleFonts.handlee(
                    fontSize: 18.0,
                    // color: c2,
                    fontWeight: FontWeight.w700,
                    wordSpacing: 1.0,
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Develop With',
                  style: GoogleFonts.handlee(
                    fontSize: 29.0,
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold,
                    wordSpacing: 1.0,
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(
                  width: 120.0,
                ),
                Snappable(
                  snapOnTap: true,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      'assets/icons/flutter.png',
                      height: 100.0,
                      width: 130.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
