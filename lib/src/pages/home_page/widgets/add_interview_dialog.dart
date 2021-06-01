import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_interview_forms.dart';
import '/src/bloc/interview_bloc/interview_bloc.dart';

class AddIntreviewDialog extends StatelessWidget {

  final interviewFormKey = GlobalKey<FormState>();  

  @override
  Widget build(BuildContext context) {

    final interviewBloc = BlocProvider.of<InterviewBloc>(context, listen: false);

    return WillPopScope(
      onWillPop: () async {
        interviewBloc.add( OnLoadInterviews() );
        return true;
      },
      child: AlertDialog(
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          padding: const EdgeInsets.only( left: 10.0 ),
          alignment: Alignment.centerLeft,
          height: 40.0,
          width: double.infinity,
          color: Colors.blue,
          child: Text('Add interview', style: TextStyle( color: Colors.white ),),
        ),
        content: AddInterviewForms( interviewFormKey: interviewFormKey ),
        actions: [
          TextButton(
            child: Text('Close'),
            onPressed: () {
              interviewBloc.add( OnLoadInterviews() );
              Navigator.of(context).pop();
            }
          ),
          BlocBuilder<InterviewBloc, InterviewState>(
            builder: ( _ , state ) {
              int key = 0;
              if ( state is AddingNewInterview ) key = state.key!;
                return TextButton(
                child: Text('Save'),
                onPressed: () {
                  if ( interviewFormKey.currentState!.validate() ) {
                    interviewBloc.add( OnUserSaveInterview(key) );
                    Navigator.of(context).pop();
                  }
                }, 
              );
            }
          ),
        ],
      ),
    );
  }
}