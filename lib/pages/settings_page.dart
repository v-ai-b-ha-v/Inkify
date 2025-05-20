import 'package:flutter/material.dart';
import 'package:handwriting_app/hive/database.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings ⚙️"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: width*0.2 , right: width*0.2 , top: height*0.1),
        child: GestureDetector(
          onTap: (){
            onTap(context);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(colors: [Colors.red.shade300, Colors.red.shade500, Colors.red.shade900],
)
            ),
            height: height*0.08,
            width: width*0.7,
            child: Center(child: Text("Delete all fonts ⚠️",style: TextStyle(
              fontSize: height*0.03
            ),)),
          ),
        ),
      ),
    );
  }

  Future<void> onTap(BuildContext context) async{
      return showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: Center(child: Text("Last step")),
      content: Text("Are you sure want to delete all fonts ?"),
      actions: [
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MaterialButton(
          child: Text("Cancel", style: TextStyle(
            fontSize: 15
          ),),
          onPressed: () {
            Navigator.of(context).pop(); 
          },
        ),
        MaterialButton(
          child: Text("Delete", style: TextStyle(
            fontSize: 15
          ),),
          onPressed: () {
            
            Database.clearBox();
            Navigator.of(context).pop();
          },
        ),
          ],
        )
      ],
    );
  },
);

  }

}