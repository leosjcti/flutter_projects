import 'package:dio/dio.dart';

abstract class HttpMethods {
  static const String POST = 'POST';
  static const String GET = 'GET';
  static const String PUT = 'PUT';
  static const String PATCh = 'PATCh';
  static const String DELETE = 'DELETE';
}

class HttpManager {
  Future<Map> restRequest({
    required String url,
    required String method,
    Map? headers,
    Map? body,
  }) async {
    Dio dio = Dio();

    //Headers da requisição
    final defaulHeaders = headers?.cast<String, String>() ?? {}
      ..addAll({
        'content-type': 'application/json',
        'accept': 'application/json',
        'X-Parse-Application-Id': 'wK7GcEjr2V4br5q5mlR1kybQ5dvxMFDX0qtE1d6Y',
        'X-Parse-REST-API-Key': '2kahi62fkWePLWAwC7k8aMrtQkobogcgkruMxbeB',
      });

    try {
      //Retorno do resultado do backend
      Response response = await dio.request(
        url,
        options: Options(
          method: method,
          headers: defaulHeaders,
        ),
        data: body,
      );
      return response.data;

    } on DioException catch (error) {
      //Retorno do resultado dio request
      return error.response?.data ?? {};
    } catch(error) {
      //Retorno do resultado
      return {};
    }
  }
}
