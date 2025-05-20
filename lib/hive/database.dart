import 'package:hive/hive.dart';
import 'dart:typed_data';

class Database {
  static const String boxName = 'fontBox';

  // Open the box (call once in app start)
  static Future<Box<Uint8List>> openBox() async {
  if (Hive.isBoxOpen(boxName)) {
    return Hive.box<Uint8List>(boxName);
  }

  return await Hive.openBox<Uint8List>(boxName);
}

  
  // Add or update image bytes by font name key
  static Future<void> putFontBytes(String name, Uint8List bytes) async {
    final box = Hive.box<Uint8List>(boxName);
    await box.put(name, bytes);
  }

  // Get image bytes by font name
  static Uint8List? getFontBytes(String name) {
    final box = Hive.box<Uint8List>(boxName);
    return box.get(name);
  }

  // Delete font bytes by name
  static Future<void> deleteFont(String name) async {
    final box = Hive.box<Uint8List>(boxName);
    await box.delete(name);
  }

  // Get all font image bytes
  static List<Uint8List> getAllFonts() {
    final box = Hive.box<Uint8List>(boxName);
    return box.values.toList();
  }

  // Clear all data
  static Future<void> clearBox() async {
    final box = Hive.box<Uint8List>(boxName);
    await box.clear();
  }
}
