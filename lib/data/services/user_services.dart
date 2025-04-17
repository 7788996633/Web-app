import 'dart:convert';

import 'package:webapp/data/models/user_model.dart';

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

  Future<List> getUsersNotInGroup(int groupID) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request = http.Request(
      'GET',
      Uri.parse('${myUrl}api/getUsersNotInGroup/$groupID'),
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

  Future<UserModel> getUserById(int userId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request =
        http.Request('GET', Uri.parse('${myUrl}api/getUserInfo/$userId'));

    request.headers.addAll(headers);

    http.StreamedResponse streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      final userJson = jsonResponse['user'];
      final user = UserModel.fromJson(userJson);

      return user;
    } else {
      print(response.statusCode);
      return UserModel(id: -100, name: 'Something went wrong');
    }
  }

  Future<String> getUserRoleInGroup(int groupId) async {
    var headers = {'Authorization': 'Bearer $myToken'};
    var request =
        http.Request('GET', Uri.parse('${myUrl}api/getRole/$groupId'));

    request.headers.addAll(headers);

    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);

      return jsonResponse['Role'];
    } else {
      print(response.statusCode);
      return 'failed';
    }
  }
}
