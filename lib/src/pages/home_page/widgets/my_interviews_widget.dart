import 'package:flutter/material.dart';

import 'interview_widget.dart';
import '/src/data/models/company_model.dart';

class MyInterviwsWidgets extends StatelessWidget {

  final List<CompanyModel> interviews;

  const MyInterviwsWidgets({
    required this.interviews
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric( vertical: 30.0),
          child: Center(
            child: Text(
              'My interviews',
              style: TextStyle( fontSize: 20.0 ),
            ),
          ),
        ),
        Container(
          child: Expanded(
            child: ListView.builder(
              itemCount: this.interviews.length,
              itemBuilder: ( _ , index ) {
                final interview = this.interviews[index];
                final date = interview.date;
                final selectedDate = '${date?.day}/${date?.month}/${date?.year} ${date?.hour}:${date?.minute}';
                return InterviewWidget(interview: interview, date: selectedDate);
              },
            ),
          ),
        ),
      ],
    );
  }
}