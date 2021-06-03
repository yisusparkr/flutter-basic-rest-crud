import 'package:flutter/material.dart';

import 'interview_widget.dart';
import '/src/data/models/company_model.dart';
import '/src/constants/constants.dart' as constants;

class MyInterviewsWidgets extends StatelessWidget {

  final List<CompanyModel> interviews;

  const MyInterviewsWidgets({
    required this.interviews
  });

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;
    double titleFontSize = 20.0;

    if ( screenSize.width > 425 ) {
      titleFontSize = ( screenSize.width > 768 ) ? 30.0 : 25.0;
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric( vertical: 30.0),
          child: Center(
            child: Text(
              '${constants.myInterviewsTitle}',
              style: TextStyle( fontSize: titleFontSize ),
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