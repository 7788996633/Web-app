import 'dart:convert';

import '../../const.dart';
import 'package:http/http.dart' as http;

class GroupServices {
  Future<String> createGroup(String name, String desc) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('${myUrl}api/CreateGroup'));
    request.fields.addAll({'name': name, 'description': name});

    request.headers.addAll(headers);

    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return jsonResponse['message'];
    } else {
      return 'Error: ${response.statusCode} - ${response.reasonPhrase}';
    }
  }

  Future<String> addUserToGroup(int groupId, int userId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${myUrl}api/AddUser_Group/2/3'));
    request.headers.addAll(headers);

    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return jsonResponse['message'];
    } else {
      return 'Error: ${response.statusCode} - ${response.reasonPhrase}';
    }
  }

  Future<String> createGroupWithUser(int userId, String groupName) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        '${myUrl}api/CreateGroupAndAddUser/$userId',
      ),
    );
    request.fields.addAll(
      {'name': groupName, 'description': 'aaaa'},
    );
    request.headers.addAll(headers);

    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return jsonResponse['message'];
    } else {
      return 'Error: ${response.statusCode} - ${response.reasonPhrase}';
    }
  }

  Future<List> getAllGroups() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request = http.Request(
      'GET',
      Uri.parse('${myUrl}api/getAllGroups'),
    );

    request.headers.addAll(headers);

    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);

      return jsonResponse['Groups'];
    } else {
      print(response.statusCode);

      return [];
    }
  }

  Future<List> getSharedGroups(int userId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request =
        http.Request('GET', Uri.parse('${myUrl}api/getSharedGroups/$userId'));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);

      return jsonResponse['sharedGroups'];
    } else {
      print(response.statusCode);

      return [];
    }
  }
}
