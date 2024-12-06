import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../const.dart';

class FileServices {
  Future<String> upLoadFile(String fileName, String filepath) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        '${myUrl}api/uploadFile/1',
      ),
    );
    request.fields.addAll({'fileName': fileName, 'status': '0'});
    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        filepath,
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

  Future<String> checkOut(int fileId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${myUrl}api/checkInFile/$fileId'));
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

  Future<String> downLoadFile(int fileId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };

    // قم بتكوين رابط API
    var url = Uri.parse('${myUrl}api/downloadFile/$fileId');

    if (kIsWeb) {
      try {
        var response = await http.get(url, headers: headers);
        var jsonResponse = json.decode(response.body);

        if (response.statusCode == 200) {
          print(jsonResponse);

          // هنا يمكنك استخدام آلية تحميل ملف في الويب مثل تحميل رابط مباشر
          // على سبيل المثال، يمكنك عرض رابط للتحميل:
          var downloadUrl = jsonResponse['filePath'];
          print('File download URL: $downloadUrl');

          return jsonResponse['message'];
        } else {
          print(jsonResponse);

          return 'Error: ${response.statusCode} - ${response.reasonPhrase}';
        }
      } catch (e) {
        print('Error downloading file: $e');
        return 'Error: $e';
      }
    } else {
      // إذا كان التطبيق يعمل على Android
      try {
        var request = http.Request('GET', url);
        request.headers.addAll(headers);

        // إرسال الطلب وتنزيل الملف
        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);
        var jsonResponse = json.decode(response.body);

        if (response.statusCode == 200) {
          print(jsonResponse);

          // حفظ الملف في الجهاز (على Android فقط)
          File file =
              File('/storage/emulated/0/Download/${jsonResponse['fileName']}');
          await file.writeAsBytes(response.bodyBytes);

          print('File downloaded to ${file.path}');
          return jsonResponse['message'];
        } else {
          print(jsonResponse);

          return 'Error: ${response.statusCode} - ${response.reasonPhrase}';
        }
      } catch (e) {
        print('Error downloading file: $e');
        return 'Error: $e';
      }
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
