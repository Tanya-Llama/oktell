
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:request_to_oktell/extension_execption.dart';
import 'package:request_to_oktell/send.dart';
// import 'package:send_data_test/extension_execption.dart';
// import 'package:send_data_test/send.dart';
// import 'package:send_data_test/phone_data.dart';

import 'our_exception.dart';


const String sdKey = 'ab6cfc59-acb4-4ae5-aa8e-16906db14e41';

class MwProvider {
  http.Response? response;

  Uri mwUri(String method, {Map<String, String>? params}) {
    print("uri!");

    return Uri(
        scheme: 'http',
        host: 'localhost',
        path: '/HRM/hs/api/oktell',
        //port: 0,
        queryParameters: params);
  }

  Map<String, String> mwHeaders() {
    print("headers!");
    return {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
//      'sd-key': sdKey,
//       if (globalSharedPrefs.guid.isNotEmpty) 'guid': globalSharedPrefs.guid,
//       if (authHeader.isNotEmpty)
        HttpHeaders.authorizationHeader: 'Basic 0KfRg9C80LvRj9C60L7QstCw0KLQnjo3MjE1',
    };
  }

  /// Авторизация
  // Future<SendUnit> getLogin(String _phone) async {
  //   final Uri uri = mwUri('phone_login');
  //   //print("postLogin()... $uri");
  //
  //   var authHeader = base64.encode(utf8.encode('$_username:$_password'));
  //  // globalSharedPrefs.authHeader = authHeader;
  //   Map<String, dynamic> body = {'username': _username, 'password': _password};
  //   String jsonBody = json.encode(body);
  //
  //   try {
  //     if (kDebugMode) await Future.delayed(const Duration(seconds: 1));
  //     response =
  //     await http.Client().post(uri, headers: mwHeaders(), body: jsonBody)
  //         .timeout(Duration(seconds: OurException.kHttpTimeout),
  //       onTimeout: () => throw TimeoutException(null),
  //     );
  //   } on Exception catch (e) {
  //     throw OurException(500, e.fatalErrorText());
  //   } catch (o) {
  //     throw OurException(-1, o.toString());
  //     // throw OurException(-1, e.toString());
  //   }
  //
  //   try {
  //     if (response!.statusCode == 200) {
  //       final Map<String, dynamic> _map = json.decode(
  //           utf8.decode(response!.bodyBytes));
  //       //print(_map);
  //       return AuthorUnit.fromJson(_map);
  //     } else {
  //       throw OurException.fromResponse(response!);
  //     }
  //   } catch (e) {
  //     throw (e is OurException) ? e : OurException(-1, e.toString());
  //   }
  // }

  ///Сервисы
  Future<SendUnit> loadPhone({
    String phone = "",
  }) async {
    // var uri = Uri.parse('http://localhost/HRM/hs/api/oktell?phone=79136656249');
     var uri=Uri.parse('https://localhost/HRM/hs/api/test');
     // var uri=Uri.parse('https://google.com');
    // final Uri uri = mwUri('oktell', params: {
    //   'phone': phone,
    // });
    try {
      print("get1!");

      response = await http.get(uri,
        headers: {
          'Authorization': 'Basic 0KfRg9C80LvRj9C60L7QstCw0KLQnjo3MjE1',
          'Content-Type': 'application/json',
        },
         // headers: {
         // HttpHeaders.authorizationHeader: 'Basic 0KfRg9C80LvRj9C60L7QstCw0KLQnjo3MjE1',
        //'Content-Type' : 'application/json',
        // 'Accept' : 'application/json'
       // },
        // params:{'phone': phone,}
      );
      //if (kDebugMode) await Future.delayed(const Duration(seconds: 1));
      //response = await http.Client().get(uri, headers: mwHeaders()).timeout(
      //   Duration(seconds: OurException.kHttpTimeout),
      //   onTimeout: () => throw TimeoutException(null),
      // );
      print("get2");
    } on Exception catch (e) {
      throw OurException(500, e.fatalErrorText());
    } catch (o) {
      throw OurException(-1, o.toString());
      // throw OurException(-1, e.toString());
    }

    try {
      if (response!.statusCode == 200) {
        Map<String, dynamic> _body = json.decode(utf8.decode(response!.bodyBytes));
        return SendUnit.fromJson(_body);
      } else {
        throw OurException.fromResponse(response!);
      }
    } catch (e) {
      throw (e is OurException) ? e : OurException(-1, e.toString());
    }
  }
}