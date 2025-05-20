import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:handwriting_app/components/my_drawer.dart';
import 'package:handwriting_app/components/textfield.dart';
import 'package:handwriting_app/pages/output_page.dart';
import 'package:handwriting_app/pages/uploadpage.dart';
import 'package:marquee/marquee.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();
  String backGroundImage = "assets/background.jpg";

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 238, 160, 44),
        title: Text("Text to Handwriting "),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backGroundImage),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Container(
                  width: double.infinity, // Full screen width
                  height: MediaQuery.of(context).size.height * 0.10,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 238, 160, 44),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(28),
                      bottomRight: Radius.circular(28),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 50,
                    child: Marquee(
                      text:
                          '            😢 Tired of assignment?                        Your bro got your back 🫡                         Copy paste all those ChatGPT stuff 🤖            ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: const Color.fromARGB(255, 14, 10, 238),
                      ),

                      scrollAxis: Axis.horizontal,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      blankSpace: 20.0,
                      velocity: 50.0,
                      pauseAfterRound: Duration(milliseconds: 500),
                      startPadding: 10.0,
                      accelerationDuration: Duration(seconds: 2),
                      accelerationCurve: Curves.linear,
                      decelerationDuration: Duration(milliseconds: 500),
                      decelerationCurve: Curves.easeOut,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 14, left: 8, right: 8),
                  child: Container(
                    width: double.infinity, // Full screen width
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 250, 81, 81),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.01,
                        left: 8,
                        right: 8,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("👉🏻", style: TextStyle(fontSize: 30)),
                              AnimatedButton(
                                text: "Upload Handwriting",
                                onPress: () async {
                                  await Future.delayed(Duration(seconds: 1));
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UploadPage(),
                                    ),
                                  );
                                },
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                width: 200,
                                isReverse: true,
                                selectedTextColor: Colors.black,
                                transitionType:
                                    TransitionType.LEFT_CENTER_ROUNDER,
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  250,
                                  81,
                                  81,
                                ),
                                borderColor: const Color.fromARGB(
                                  255,
                                  241,
                                  76,
                                  76,
                                ),
                                borderRadius: 30,
                                borderWidth: 3,
                              ),
                              Text("👈🏻", style: TextStyle(fontSize: 30)),
                            ],
                          ),

                          Padding(
                            padding: EdgeInsets.only(top: height * 0.01),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    "First Time ?",
                                    style: TextStyle(
                                      color: Colors.yellowAccent,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(
                    top: height * 0.02,
                    left: 8,
                    right: 8,
                  ),
                  child: Container(
                    height: height * 0.25, // set desired height
                    width: double.infinity, // or a fixed width like 300
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                        image: AssetImage("assets/blackboard.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              "Paste here 👇🏻",
                              style: TextStyle(
                                letterSpacing: 1,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.029,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          DynamicTextFieldSafe(controller: controller),
                        ],
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top : 30),
                  child: AnimatedButton.strip(
                    onPress: () async {
                      await Future.delayed(Duration(milliseconds: 500));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OutputPage(text: controller.text),
                        ),
                      );
                    },
                    width: width * 0.5,
                    gradient: LinearGradient(colors: [Colors.green.shade500,Colors.green.shade700,Colors.green.shade900]),
                    height: height * 0.07,
                    text: 'Output',
                    selectedText: "Lets see 🤩",
                    isReverse: true,
                    selectedTextColor: Colors.black,
                    stripTransitionType: StripTransitionType.LEFT_TO_RIGHT,
                    selectedBackgroundColor: Colors.white,
                    textStyle: GoogleFonts.nunito(
                      fontSize: 28,
                      letterSpacing: 5,
                      color: const Color.fromARGB(255, 11, 11, 11),
                      fontWeight: FontWeight.w600,
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
