import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class GetLogoImageBytes {
  static Future<File> getImageFileFromAssets() async {
    final byteData = await rootBundle.load("assets/images/logo.png");

    final tempDir = await getApplicationDocumentsDirectory();

    final file = File("${tempDir.path}/logo");

    await file.writeAsBytes(
      byteData.buffer.asUint8List(
        byteData.offsetInBytes,
        byteData.lengthInBytes,
      ),
    );
    return file;
  }
}
