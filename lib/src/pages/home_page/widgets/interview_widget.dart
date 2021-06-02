import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modify_interview_dialog.dart';
import '/src/data/models/company_model.dart';
import '/src/bloc/interview_bloc/interview_bloc.dart';

class InterviewWidget extends StatelessWidget {

  final CompanyModel interview;
  final String date;

  const InterviewWidget({
    required this.interview,
    required this.date
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        onTap: () => _modifyInterviewDialog( context, this.interview ),
        child: Padding(
          padding: const EdgeInsets.symmetric( horizontal: 20.0, vertical: 10.0 ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ( this.interview.enterprise != null ) 
                        ? '${this.interview.enterprise}' 
                        : 'Empty',
                      style: TextStyle( fontSize: 18.0, fontWeight: FontWeight.w500 ),
                    ),
                    Text(
                      ( this.interview.comment != null ) 
                        ? '${this.interview.comment}' 
                        : 'Empty',
                      style: TextStyle( fontSize: 16.0, fontWeight: FontWeight.w300 ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    if ( interview.date != null ) Text(
                      '${this.date}',
                      style: TextStyle( fontSize: 16.0, fontWeight: FontWeight.w200 ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Flexible( child: ( interview.state == 'Completed' )
                ? Icon( Icons.done, color: Colors.green, )
                : Icon( Icons.close, color: Colors.red, )
              )
            ],
          ),
        ),
      )
    );
  }

  void _modifyInterviewDialog( BuildContext context, CompanyModel interview ) {

    final interviewBloc = BlocProvider.of<InterviewBloc>(context, listen: false);

    if ( interview.state == 'Completed' ) interviewBloc.add( OnUserWatchInterview(interview) );
    else interviewBloc.add( OnUserModifyInterview(interview) );

    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: ( _ ) => ModifyInterviewDialog()
    );

  }

}