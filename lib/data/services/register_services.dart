import 'dart:convert';

import 'package:webapp/const.dart';
import 'package:http/http.dart' as http;

class RegisterServices {
  Future<String> register(String name, String password, String email) async {
    var headers = {'Accept': 'application/json'};
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        '${myUrl}api/register',
      ),
    );
    request.fields.addAll({'name': name, 'email': email, 'password': password});

    request.headers.addAll(headers);

    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    var jsonResponse = json.decode(response.body);

    if (response.statusCode == 201) {
      print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');

      print(jsonResponse);

      myId = jsonResponse['user']['id'];
      print('My new ID is $myId');
      return jsonResponse['token'];
    } else {
      print(jsonResponse);
      print('failed: ${response.statusCode} - ${response.reasonPhrase}');

      return 'failed: ${response.statusCode} - ${response.reasonPhrase}';
    }

    // var body = ({'name': name, 'email': email, 'password': password},);
    // var data = await Api().postt('api/register', headers, body);
    // if (!data['message'].toString().contains('failed')) {
    //   print(
    //     data,
    //   );
    //   myId = data['User']['id'];
    //   print('My new ID is $myId');
    //   return data['access_token'];
    // } else {
    //   print(
    //     data['message'],
    //   );
    //   return data['message'];
    // }
  }
}
