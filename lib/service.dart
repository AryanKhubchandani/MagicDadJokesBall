import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Service {
  // Future<String> getJoke() async {
  //   final url = 'https://icanhazdadjoke.com/';
  //   var dio = Dio();
  //   // response = await dio.get('https://icanhazdadjoke.com/');
  //   dio.options.baseUrl = "https://icanhazdadjoke.com/";
  //   dio.options.headers['Accept'] = 'application/json';
  //   var jsonString = await dio.get(
  //     url,
  //     queryParameters: dio.options.headers,
  //   );
  //   Map<String, dynamic> response = convert.jsonDecode(jsonString.data);
  //   // response = await dio.get(url, queryParameters:  Map<String, dynamic> )
  //   print(response['joke']);
  //   return response['joke'];
  // }

  Future<String> getJoke() async {
    final url = Uri.parse('https://icanhazdadjoke.com/');

    var jsonString = await http.get(
      url,
      headers: {"Accept": "application/json"},
    );
    Map<String, dynamic> response = convert.jsonDecode(jsonString.body);
    print(response['joke']);
    return response['joke'];
  }

  //     if (response.statusCode == 200) {
  //       print();
  //       return ;
  //     } else {
  //       throw Exception('Failed to load joke');
  //     }
  //   } catch (error) {
  //     throw Exception('Failed to load joke');
  //   }
  // }

}
