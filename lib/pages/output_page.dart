import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:handwriting_app/hive/database.dart';

class OutputPage extends StatefulWidget {
  final String text;
  const OutputPage({super.key, required this.text});


  @override
  State<OutputPage> createState() => _OutputPageState();
}

class _OutputPageState extends State<OutputPage> {

  

  // Layout constants
  static const double charWidth = 18;
  static const double charHeight = 25;
  static const double pageWidth = 595;
  static const double pageHeight = 842;
  static const int charsPerLine = 90; 
  static const int linesPerPage = 32; 

  late final List<List<List<Uint8List>>> pages; // pages -> lines -> chars
  int currentPageIndex = 0;
  final GlobalKey repaintKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    pages = preprocessText(widget.text);
  }

  List<List<List<Uint8List>>> preprocessText(String text) {
    List<List<List<Uint8List>>> pages = [];
    List<List<Uint8List>> currentPage = [];
    List<Uint8List> currentLine = [];

    int charCount = 0;
    int lineCount = 0;

    for (var char in text.characters) {
      if (char == '\n') {
        if (currentLine.isNotEmpty) {
          currentPage.add(currentLine);
          currentLine = [];
          lineCount++;
          charCount = 0;
        }
        if (lineCount >= linesPerPage) {
          pages.add(currentPage);
          currentPage = [];
          lineCount = 0;
        }
        continue;
      }

      final Uint8List? img = Database.getFontBytes(char);
      if (img != null) {
        currentLine.add(img);
        charCount++;
      }

      if (charCount >= charsPerLine) {
        currentPage.add(currentLine);
        currentLine = [];
        charCount = 0;
        lineCount++;
      }

      if (lineCount >= linesPerPage) {
        pages.add(currentPage);
        currentPage = [];
        lineCount = 0;
      }
    }

    // Add remaining line/page if any
    if (currentLine.isNotEmpty) {
      currentPage.add(currentLine);
      lineCount++;
    }
    if (currentPage.isNotEmpty) {
      pages.add(currentPage);
    }

    return pages;
  }

  void _saveCurrentPage() async {
  PermissionStatus status = await Permission.photos.request();

  if (!status.isGranted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Permission not granted")),
    );
    openAppSettings();
    return;
  }

  try {
    RenderRepaintBoundary boundary =
        repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    // Capture the widget as an image
    var image = await boundary.toImage(pixelRatio: 3.0);

    // Convert the image to bytes (PNG)
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    if (byteData == null) throw Exception("Failed to convert image to bytes.");

    final pngBytes = byteData.buffer.asUint8List();

    // Save the image to gallery
    final result = await ImageGallerySaverPlus.saveImage(
      pngBytes,
      quality: 100,
      name: "handwritten_output_page_${currentPageIndex + 1}",
    );

    if (result['isSuccess']) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Image saved successfully!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to save image.")),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error saving image: $e")),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    if (pages.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("Output")),
        body: const Center(child: Text("No content to display")),
      );
    }

    final currentPage = pages[currentPageIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("Output Page ${currentPageIndex + 1} / ${pages.length}"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.save_alt),
            onPressed: _saveCurrentPage,
          ),
        ],
      ),
      body: Center(
        child: ClipRect(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: RepaintBoundary(
                key: repaintKey,
                child: Container(
                  width: pageWidth,
                  height: pageHeight,
                  padding: const EdgeInsets.all(20),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(currentPage.length, (lineIndex) {
                      final line = currentPage[lineIndex];
                      return Wrap(
                        spacing: -12,
                        runSpacing: -1,
                        children: line.map((charBytes) {
                          return Image.memory(
                            charBytes,
                            width: charWidth,
                            height: charHeight,
                            fit: BoxFit.contain,
                          );
                        }).toList(),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: pages.length > 1
          ? BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: currentPageIndex > 0
                        ? () => setState(() => currentPageIndex--)
                        : null,
                  ),
                  Text("Page ${currentPageIndex + 1} / ${pages.length}"),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: currentPageIndex < pages.length - 1
                        ? () => setState(() => currentPageIndex++)
                        : null,
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
