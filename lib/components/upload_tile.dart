import 'package:flutter/material.dart';

class UploadTile extends StatelessWidget {
  final Color? color;
  final String text;
  void Function()? onTap;
  UploadTile({super.key, required this.color, required this.text,required this.onTap});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            height: height * 0.18,
            width: width * 0.9,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(child: Text(text,style: TextStyle(
              fontSize: height*0.04
            ),)),
          ),
        ),
      ),
    );
  }
}
