import 'package:flutter/material.dart';
import 'package:handwriting_app/components/letter_tile.dart';

class GridBuilder extends StatelessWidget {
  final int ASCII_start;
  final int count ;
  const GridBuilder({super.key,
  required this.count,
  required this.ASCII_start});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: count,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemBuilder: (context,index){
        final char  = String.fromCharCode(ASCII_start+index);

        return AlphabetUploadTile(
          letter: char,
        );

      },
    );
  }
}