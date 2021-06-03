import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/add_interview_dialog.dart';
import 'widgets/my_interviews_widget.dart';
import '/src/helpers/helpers.dart' as helpers;
import '/src/constants/constants.dart' as constants;
import '/src/bloc/interview_bloc/interview_bloc.dart';

class HomePage extends StatelessWidget {

  final String userName;

  const HomePage({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;
    double titleFontSize = 20.0;
    double iconsSize = 24.0;
    double iconsSplashSize = 20.0;

    if ( screenSize.width > 425 ) {
      titleFontSize = ( screenSize.width > 768 ) ? 30.0 : 25.0;
      iconsSize = ( screenSize.width > 768 ) ? 32.0 : 28.0;
    }

    iconsSplashSize = iconsSize - 4;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          '${constants.welcomeTitle} ${this.userName.toUpperCase()}',
          style: TextStyle( fontSize: titleFontSize ),
        ),
        actions: [
          IconButton(
            iconSize: iconsSize,
            splashRadius: iconsSplashSize,
            icon: Icon(Icons.sync_rounded),
            onPressed: () => BlocProvider.of<InterviewBloc>(context, listen: false).add( OnUserSendInterviews() ), 
          )
        ],
      ),
      body: BlocConsumer<InterviewBloc, InterviewState>(
        listenWhen: ( _ , current ) {
          if ( current is SendingInterviews ) return true;
          if ( current is InterviewsSent ) return true;
          if ( current is SendInterviewsError ) return true;
          return false;
        },
        listener: ( _ , state ) {
          if ( state is InterviewsSent ) helpers.showSendSnackBar(context, state.message!, true, false);
          if ( state is SendingInterviews ) helpers.showSendingDialog(context);
          if ( state is SendInterviewsError ) helpers.showSendSnackBar(context, state.errorMessage!, state.pop!, true);
        },
        buildWhen: ( _ , current ) {
          if ( current is InterviewsInitialized ) return true;
          if ( current is InterviewsLoaded ) return true;
          return false;
        },
        builder: ( _ , state ) {
          if ( state is InterviewsInitialized ) {
            BlocProvider.of<InterviewBloc>(context, listen: false).add( OnLoadInterviews() );
          }
          if ( state is InterviewsLoaded ) {
            if ( state.interviews!.isNotEmpty ) {
              return MyInterviewsWidgets(interviews: state.interviews!);
            } else {
              return Center(
                child: Text(
                  '${constants.withoutInterviewsText}',
                  style: TextStyle( fontSize: titleFontSize ),
                )
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, size: iconsSize,),
        onPressed: () => _addInterviewDialog(context)
      ),
    );
  }

  void _addInterviewDialog( BuildContext context ) {

    BlocProvider.of<InterviewBloc>(context, listen: false).add( OnUserAddInterview() );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AddInterviewDialog()
    );
  }
}