import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handwriting_app/pages/home_page.dart';
import 'package:handwriting_app/pages/settings_page.dart';
import 'package:handwriting_app/pages/uploadpage.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
Widget build(BuildContext context) {
  final double width = MediaQuery.of(context).size.width;
  return Drawer(
    width: width * 0.75,
    child: Padding(
      padding: EdgeInsets.only(top: 8.0, bottom: 8),
      child: Column(
        children: [
          DrawerHeader(child: Image.asset(
        'assets/logo.png',
        width: 200,
        height: 200,
        fit: BoxFit.contain,
      ),),
          Expanded(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.home),
                  title: Padding(
                    padding: EdgeInsets.only(left: width * 0.04),
                    child: Text("Home", style: TextStyle(fontSize: width * 0.045)),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.upload),
                  title: Padding(
                    padding: EdgeInsets.only(left: width * 0.04),
                    child: Text("Upload", style: TextStyle(fontSize: width * 0.045)),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UploadPage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Padding(
                    padding: EdgeInsets.only(left: width * 0.04),
                    child: Text("Settings", style: TextStyle(fontSize: width * 0.045)),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  },
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.only(bottom: width*0.05),
            child: ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Padding(
                padding: EdgeInsets.only(left: width * 0.04),
                child: Text("Exit", style: TextStyle(fontSize: width * 0.045)),
              ),
              onTap: () {
                SystemNavigator.pop();
              },
            ),
          ),
        ],
      ),
    ),
  );
}

}
