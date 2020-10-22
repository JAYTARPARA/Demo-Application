import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class API {
  var response, apiSendURL;
  var resultError;
  var apiURL = 'http://13.232.255.84';

  Future getDocuments() async {
    try {
      response = await http.post(
        '$apiURL/api/api.php',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print('response.statusCode');
      print(response.statusCode);
      return jsonDecode(response.body);
    } on SocketException {
      print('No Internet connection');
      return 'error';
    } on HttpException {
      print('Couldnt find the post');
      return 'error';
    } on FormatException {
      print('Bad response format');
      return 'error';
    }
  }
}
