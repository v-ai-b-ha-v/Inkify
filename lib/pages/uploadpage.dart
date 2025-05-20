import 'package:flutter/material.dart';
import 'package:handwriting_app/components/grid_builder.dart';
import 'package:handwriting_app/components/letter_tile.dart';
import 'package:handwriting_app/components/my_drawer.dart';
import 'package:handwriting_app/components/upload_tile.dart';

class UploadPage extends StatelessWidget {
  const UploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Handwriting"),
        centerTitle: true,
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: height * 0.05),
            UploadTile(color: Colors.red, text: "A to Z", onTap: () => {
              _showGridDialog(context, 65, 26, "A to Z")
            },),
            UploadTile(color: Colors.green, text: "a to z", onTap: () => {
              _showGridDialog(context, 97, 26, "a to z")
            }),
            UploadTile(color: Colors.blue, text: "0 to 9", onTap: () => {
              _showGridDialog(context, 48, 10, "0 to 9")
            }),

            UploadTile(color: const Color.fromARGB(255, 248, 236, 20), text: "Special Characters", onTap: () {
              showSpecialDialog(context);
            }),

          ],
        ),
      ),
    );
  }

  void _showGridDialog(BuildContext context, int asciiStart, int count, String title) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Center(child: Text(title)),
      content: SizedBox(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height*0.35,
        child: GridBuilder(
          ASCII_start: asciiStart,
          count: count,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Close'),
        ),
      ],
    ),
  );
}

void showSpecialDialog(BuildContext context){
  const String specialCharacters = r""".,;:?+!=* '"()[]{}-_/@#&$%""";

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Center(child: Text("Special Characters")),
        content: SizedBox(
          width: double.maxFinite,
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: specialCharacters.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final char = specialCharacters[index];
              return AlphabetUploadTile(letter: char,); 
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          )
        ],
      );
    },
  );
}



}
