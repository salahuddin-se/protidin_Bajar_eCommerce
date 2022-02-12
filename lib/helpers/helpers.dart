import 'dart:io';

import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/helpers/http_manager.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

class Helper {
  static Future<dynamic> uploadImage(File file, progress) async {
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(file.path),
      'file_name': basename(file.path),
      'id': box.read(userID),
    });

    final response = await HttpManager.apiPost(
      relativeUrl: 'profile/update-image',
      formData: formData,
      progress: progress,
    );
    print("UPLOAD RESPONSE: ${response.data}");
    return response;
  }
}
