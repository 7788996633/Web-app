import 'dart:convert';

import '../../const.dart';
import 'package:http/http.dart' as http;

class UserServices {
  Future<List> getUsersByGroupId(int groupId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request = http.Request(
      'GET',
      Uri.parse('${myUrl}api/getUsersByGroup/$groupId'),
    );

    request.headers.addAll(headers);

    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);

      return jsonResponse['users'];
    } else {
      print(response.statusCode);
      return [];
    }
  }

  Future<List> getAllUsers() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request = http.Request(
      'GET',
      Uri.parse('${myUrl}api/getallUsers'),
    );

    request.headers.addAll(headers);

    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);

      return jsonResponse['users'];
    } else {
      print(response.statusCode);
      return [];
    }
  }
}
