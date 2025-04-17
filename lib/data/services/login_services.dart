import 'dart:convert';

import 'package:webapp/const.dart';

import '../helper/api.dart';
import 'package:http/http.dart' as http;

class LoginServices {
  Future<String> login(String email, String password) async {
    var headers = {'Accept': 'application/json'};
    var body = ({'email': email, 'password': password});
    var data = await Api().postt('api/login', headers, body);
    if (!data['message'].toString().contains('failed')) {
      print(
        data,
      );
      myId = data['User']['id'];
      print('My new ID is $myId');

      return data['token'];
    } else {
      print(
        data,
      );
      return 'fail';
    }
  }

  Future<String> logOut() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('${myUrl}api/logout'));
    request.headers.addAll(headers);

    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    var jsonResponse = json.decode(response.body);

    print(jsonResponse);

    if (response.statusCode == 200) {
      return jsonResponse['message'];
    } else {
      return 'Error: ${response.statusCode} - ${response.reasonPhrase}';
    }
  }
}
