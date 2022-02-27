import 'dart:convert';
import 'dart:io';

import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/helpers/http_manager.dart';
import 'package:path/path.dart';

class Helper {
  static Future<dynamic> uploadImage(File file, progress) async {
    final byteData = await file.readAsBytes();
    String base64String = base64Encode(byteData);
    final data = {
      'image': base64String,
      'file_name': basename(file.path),
      'id': box.read(userID),
    };

    final response = await HttpManager.apiPost(
      relativeUrl: 'profile/update-image',
      data: data,
      progress: progress,
    );
    print("UPLOAD RESPONSE: ${response.data}");
    return response;
  }
}
