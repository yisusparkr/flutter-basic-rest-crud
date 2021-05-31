import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginRepository {
  
  Future<Map<String, dynamic>> signIn( String email, String password ) async {

    final uri = Uri.https(
      'test-flutter.000webhostapp.com', 
      '/login.php',
      {
        'email': email,
        'password': password
      }
    );

    final response = await http.get(uri);

    final data = json.decode(response.body);

    return data;

  }

  Future<Map<String, dynamic>> signUp( String firstName, String email, String password ) async {

    final uri = Uri.https(
      'test-flutter.000webhostapp.com',
      '/sign_up.php'
    );

    final response = await http.post(
      uri,
      body: {
        'first_name': firstName,
        'email': email,
        'password': password
      }
    );

    final Map<String, dynamic> data = json.decode(response.body);

    return data;

  }

}