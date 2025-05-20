import 'dart:io';
import 'package:flutter/material.dart';
import 'package:handwriting_app/hive/database.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class AlphabetUploadTile extends StatefulWidget {
  final String letter;

  AlphabetUploadTile({super.key, required this.letter});

  @override
  State<AlphabetUploadTile> createState() => _AlphabetUploadTileState();
}

class _AlphabetUploadTileState extends State<AlphabetUploadTile> {
  bool selected = false;

  Future<void> _pickAndSave(BuildContext context) async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(source: ImageSource.gallery);
      if (picked != null) {
        final bytes = await File(picked.path).readAsBytes();

        await Database.putFontBytes(widget.letter, Uint8List.fromList(bytes));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Image saved for "${widget.letter}" successfully!'),
            duration: Duration(milliseconds: 300),
          ),
        );

        // Save and rebuild UI
        setState(() {
          Database.putFontBytes(widget.letter, Uint8List.fromList(bytes));
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No image selected.'),
            duration: Duration(milliseconds: 300),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to save image: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickAndSave(context),
      child: Card(
        color:
            (Database.getFontBytes(widget.letter) != null)
                ? Colors.green
                : Colors.white,
        child: Center(
          child: Text(widget.letter,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.02,
            ),
          ),
        ),
      ),
    );
  }
}
