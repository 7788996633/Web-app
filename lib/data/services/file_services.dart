import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../const.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:universal_html/html.dart' as html;

class FileServices {
  Future<String> upLoadFile(
      int groupID, String fileName, Uint8List fileBytes) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${myUrl}api/uploadFile/$groupID'),
    );
    request.fields.addAll({'fileName': fileName, 'status': '0'});
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        fileBytes,
        filename: fileName,
      ),
    );
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var jsonResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      print(jsonResponse);
      return jsonResponse['message'];
    } else {
      print(jsonResponse);
      return 'Error: ${response.statusCode} - ${response.reasonPhrase}';
    }
  }

  Future<String> checkOut(
      int fileId, String fileName, Uint8List fileBytes) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${myUrl}api/checkInFile/$fileId'));
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        fileBytes,
        filename: fileName,
      ),
    );

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

  Future<String> checkIn(int fileId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${myUrl}api/checkOutFile/$fileId'));
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

  Future<String> downloadFile(int fileId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };

    var url = Uri.parse('${myUrl}api/downloadFile/$fileId');

    try {
      if (kIsWeb) {
        print('Running on Web');
        var response = await http.get(url, headers: headers);
        if (response.statusCode == 200) {
          print('Download successful on Web');
          final blob = html.Blob([response.bodyBytes]);
          final downloadUrl = html.Url.createObjectUrlFromBlob(blob);
          final anchor = html.AnchorElement(href: downloadUrl)
            ..setAttribute('download', 'downloaded_file') // اسم الملف
            ..click(); // يبدأ التنزيل
          html.Url.revokeObjectUrl(downloadUrl);
          return 'File is downloading on web.';
        } else {
          print('Download failed on Web: ${response.statusCode}');
          return 'Error: ${response.statusCode} - ${response.reasonPhrase}';
        }
      } else {
        print('Running on Mobile/Desktop');
        var response = await http.get(url, headers: headers);
        if (response.statusCode == 200) {
          print('Download successful on Mobile/Desktop');
          var contentDisposition = response.headers['content-disposition'];
          var fileName = contentDisposition
                  ?.split(';')
                  .firstWhere(
                      (element) => element.trim().startsWith('filename='))
                  .split('=')
                  .last
                  .replaceAll('"', '') ??
              'downloaded_file';

          Directory tempDir = await getApplicationDocumentsDirectory();
          String tempPath = tempDir.path;
          File file = File('$tempPath/$fileName');
          await file.writeAsBytes(response.bodyBytes);

          print('File downloaded to: ${file.path}');
          await OpenFile.open(file.path);

          return 'File downloaded and opened: ${file.path}';
        } else {
          print('Download failed on Mobile/Desktop: ${response.statusCode}');
          return 'Error: ${response.statusCode} - ${response.reasonPhrase}';
        }
      }
    } catch (e) {
      print('Unexpected error: $e');
      return 'Error downloading file: $e';
    }
  }

  Future<List> latestFiles() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request = http.Request('GET', Uri.parse('${myUrl}api/latestFiles'));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return jsonResponse['latestFiles'];
    } else {
      print(response.statusCode);

      return [];
    }
  }

  Future<List> getAllFiles() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request = http.Request('GET', Uri.parse('${myUrl}api/GetAllFiles'));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return jsonResponse['Files'];
    } else {
      print(response.statusCode);

      return [];
    }
  }

  Future<List> getMyFiles() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request = http.Request('GET', Uri.parse('${myUrl}api/getFileBrooked'));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return jsonResponse['files'];
    } else {
      print(response.statusCode);

      return [];
    }
  }

  Future<List> getGroupFiles(int groupID) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request = http.Request(
        'GET', Uri.parse('${myUrl}api/getFilesByGroupId/$groupID'));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return jsonResponse['files'];
    } else {
      print(response.statusCode);

      return [];
    }
  }

  Future<List> getFileReports(int fileId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request =
        http.Request('GET', Uri.parse('${myUrl}api/GReportForFile/$fileId'));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return jsonResponse['Report'];
    } else {
      print(response.statusCode);

      return [];
    }
  }
}
