import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginRepository {
  
  Future<String> signIn( String email, String password ) async {

    final uri = Uri.https(
      'test-flutter.000webhostapp.com', 
      '/login.php',
      {
        'email': email,
        'password': password
      }
    );

    final response = await http.get(uri);

    final data = jsonDecode(response.body);

    final String status = data['status'];

    return status;

  }

}