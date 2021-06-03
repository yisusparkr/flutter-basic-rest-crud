import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modify_interview_forms.dart';
import '/src/constants/constants.dart' as constants;
import '/src/bloc/interview_bloc/interview_bloc.dart';

class ModifyInterviewDialog extends StatelessWidget {

  final modifyInterviewFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final interviewBloc = BlocProvider.of<InterviewBloc>(context, listen: false);

    return WillPopScope(
      onWillPop: () async {
        interviewBloc.add( OnLoadInterviews() );
        return true;
      },
      child: BlocBuilder<InterviewBloc, InterviewState>(
        builder: (context, state) {
          int key = 0;
          
          if ( state is WatchingInterview ) {
            key = state.interview!.key!;
          } else if ( state is ModifyingInterview ) {
            key = state.interview!.key!;
          }
          return AlertDialog(
            titlePadding: const EdgeInsets.all(0),
            title: Container(
              padding: const EdgeInsets.only( left: 10.0 ),
              height: 40.0,
              width: double.infinity,
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${constants.modifyInterviewTitle}', 
                    style: TextStyle( fontSize: 20.0, color: Colors.white )
                  ),
                  IconButton(
                    splashRadius: 15.0,
                    color: Colors.white,
                    icon: Icon(Icons.delete, size: 24.0),
                    onPressed: () {
                      Navigator.of(context).pop();
                      interviewBloc.add( OnUserDeleteInterview(key) );
                    },
                  )
                ],
              ),
            ),
            content: ModifyInterviewForms( modifyInterviewFormKey: modifyInterviewFormKey ),
            actions: [
              TextButton(
                child: Text(
                  '${constants.closeText}',
                  style: TextStyle( fontSize: 18.0 ),
                ),
                onPressed: () {
                  interviewBloc.add( OnLoadInterviews() );
                  Navigator.of(context).pop();
                }
              ),
              TextButton(
                child: Text(
                  '${constants.saveText}',
                  style: TextStyle( fontSize: 18.0 ),
                ),
                onPressed: () {
                  if ( modifyInterviewFormKey.currentState!.validate() ) {
                    interviewBloc.add( OnUserSaveInterview(key) );
                    Navigator.of(context).pop();
                  }
                }, 
              )
            ],
          );
        },
      ),
    );
  }
}