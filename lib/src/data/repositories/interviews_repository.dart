import 'dart:convert';

import 'package:http/http.dart' as http;
import '/src/data/models/company_model.dart';

class InterviewsRepository {

  final uri = Uri.https(
    'test-flutter.000webhostapp.com', 
    '/post_form.php',
  );

  Future<String> sendInterviews( List<CompanyModel> interviews ) async {

    List<Map<String, dynamic>> interviewsMapped = [];

    interviews.forEach((interview) { 
      if ( interview.state == 'Completed' ) {
        interviewsMapped.add(
          {
            "enterprise": interview.enterprise,
            "comment": interview.comment,
            "number": interview.number,
            "date": interview.date!.toIso8601String(),
          }
        );
      }
    });

    final response = await http.post(
      uri,
      body: {
        "forms": json.encode(interviewsMapped)
      }
    );

    final Map<String, dynamic> data = json.decode(response.body);

    final status = data['status'];

    return status;

  }

}