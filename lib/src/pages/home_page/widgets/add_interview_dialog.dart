import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_interview_forms.dart';
import '/src/constants/constants.dart' as constants;
import '/src/bloc/interview_bloc/interview_bloc.dart';

class AddInterviewDialog extends StatelessWidget {

  final addInterviewFormKey = GlobalKey<FormState>();  

  @override
  Widget build(BuildContext context) {

    final interviewBloc = BlocProvider.of<InterviewBloc>(context, listen: false);
    final screenSize = MediaQuery.of(context).size;
    double titleFontSize = 20.0;
    double containerHeight = 40.0;
    double textButtonFontSize = 16.0;
    double iconsSize = 24.0;
    double iconsSplashSize = 20.0;

    if ( screenSize.width > 425 ) {
      titleFontSize = ( screenSize.width > 768 ) ? 30.0 : 25.0;
      containerHeight = ( screenSize.width > 768 ) ? 60.0 : 50.0;
      textButtonFontSize = ( screenSize.width > 768 ) ? 25.0 : 20.0;
      iconsSize = ( screenSize.width > 768 ) ? 32.0 : 28.0;
    }

    iconsSplashSize = iconsSize - 4;

    return WillPopScope(
      onWillPop: () async {
        interviewBloc.add( OnLoadInterviews() );
        return true;
      },
      child: BlocBuilder<InterviewBloc, InterviewState>(
        builder: ( _ , state ) {
        int key = 0;
        if ( state is AddingNewInterview ) key = state.key!;
          return AlertDialog(
            titlePadding: const EdgeInsets.all(0),
            title: Container(
              padding: const EdgeInsets.only( left: 10.0 ),
              height: containerHeight,
              width: double.infinity,
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${constants.addInterviewTitle}'
                    , style: TextStyle( fontSize: titleFontSize, color: Colors.white )
                  ),
                  IconButton(
                    splashRadius: iconsSplashSize,
                    color: Colors.white,
                    icon: Icon(Icons.delete, size: iconsSize),
                    onPressed: () {
                      Navigator.of(context).pop();
                      interviewBloc.add( OnUserDeleteInterview(key) );
                    },
                  )
                ],
              ),
            ),
            content: AddInterviewForms( addInterviewFormKey: addInterviewFormKey ),
            actions: [
              TextButton(
                child: Text(
                  '${constants.closeText}',
                  style: TextStyle( fontSize: textButtonFontSize ),
                ),
                onPressed: () {
                  interviewBloc.add( OnLoadInterviews() );
                  Navigator.of(context).pop();
                }
              ),
              TextButton(
                child: Text(
                  '${constants.saveText}',
                  style: TextStyle( fontSize: textButtonFontSize ),
                ),
                onPressed: () {
                  if ( addInterviewFormKey.currentState!.validate() ) {
                    interviewBloc.add( OnUserSaveInterview(key) );
                    Navigator.of(context).pop();
                  }
                }, 
              )
            ],
          );
        }
      ),
    );
  }
}