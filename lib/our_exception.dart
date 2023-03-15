import 'dart:convert';

import 'package:http/http.dart';

class OurException {

  int code;
  String error;

  OurException(this.code, this.error);

  static String kNoInternet = "Проверьте ваше\nинтернет-соединение";
  static String kTimeoutError = "Таймаут";
  static String kTokenExpired = "Токен устарел";
  static String kJsonError = "Ошибка разбора JSON";
  static String kUnknownError = "Неизвестная ошибка";
  static String kServerError = "Ошибка интернета"; // "Ошибка сервера"; // 500
  static String kWrongAnswer = "Ошибка ответа сервера";
  static int kHttpTimeout = 40;

  static Map<int, String> httpCodeText = {
    401: 'Неверный логин/пароль',
    404: 'Страница не найдена',
    405: 'Метод не определен',
  };

  @override
  String toString() => "$code: $error";

  // String fatalErrorText(Exception e) {
  //   return (e is SocketException)
  //       ? OurException.kNoInternet
  //   // : (e is JsonUnsupportedObjectError)
  //   //   ? OurException.kNoInternet
  //       : (e is TimeoutException)
  //       ? OurException.kServerError
  //       : OurException.kUnknownError;
  // }

  factory OurException.fromBody(int statusCode, String body) {
    // print(body.toString());
    // print((body['errors'] is List).toString());
    // print((body['errors'].isEmpty).toString());
    // final bool _success = json['success']?? false;
    final re = OurException(
      statusCode, body,
      // (body['errors'] is List)? body['errors'][0].toString(): kWrongAnswer
    );
    // print(re.toString());
    return re;
    // return OurException(
    //   statusCode,
    //   (body['errors'] is List)? body['errors'][0].toString(): kWrongAnswer
    // );
  }

  factory OurException.fromResponse(Response response) {
    try {
      return OurException.fromBody(response.statusCode, utf8.decode(response.bodyBytes));
    } catch (_) {
      print('OurException.fromResponse: ${response.statusCode}');
      return OurException(
          response.statusCode,
          httpCodeText.containsKey(response.statusCode)
              ? httpCodeText[response.statusCode]!
              : kUnknownError);
    }
  }
}