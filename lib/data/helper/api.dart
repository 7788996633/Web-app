import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../const.dart';


class Api {
  Future<dynamic> gett(
    String url,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };

    var response = await http.get(Uri.parse(myUrl + url), headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('${response.statusCode}');
    }
  }

  Future<dynamic> postt(String url, Map<String, String>? headers, body) async {
    var response =
        await http.post(Uri.parse(myUrl + url), body: body, headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('${response.statusCode}');
    }
  }
}
