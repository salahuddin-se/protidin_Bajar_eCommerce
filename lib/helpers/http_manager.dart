import 'package:customer_ui/components/apis.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:dio/dio.dart';

class HttpManager {
  static BaseOptions baseOptions = BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: 10000,
    receiveTimeout: 10000,
    contentType: Headers.formUrlEncodedContentType,
    responseType: ResponseType.json,
  );

  static BaseOptions exportOptions(BaseOptions options) {
    options.headers["Authorization"] = "Bearer ${box.read(userToken)}";
    return options;
  }

  static Future<Response<dynamic>> apiPost({
    required String relativeUrl,
    Map<String, dynamic>? data,
    FormData? formData,
    Options? options,
    Function(num)? progress,
  }) async {
    BaseOptions requestOptions = exportOptions(baseOptions);
    Dio dio = Dio(requestOptions);

    Response<dynamic>? res;

    try {
      final response = await dio.post(relativeUrl, data: data ?? formData, options: options, onSendProgress: (sent, total) {
        if (progress != null) {
          progress(sent / total * 100);
        }
      });
      res = response;
    } catch (err) {
      print(err.toString());
    }
    return res!;
  }
}
