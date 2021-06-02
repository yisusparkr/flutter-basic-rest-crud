import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/add_interview_dialog.dart';
import 'widgets/my_interviews_widget.dart';
import '/src/bloc/interview_bloc/interview_bloc.dart';

class HomePage extends StatelessWidget {

  final String userName;

  const HomePage({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Welcome ${this.userName}'),
        actions: [
          IconButton(
            splashRadius: 20.0,
            icon: Icon(Icons.sync_rounded),
            onPressed: () {}, 
          )
        ],
      ),
      body: BlocConsumer<InterviewBloc, InterviewState>(
        listenWhen: ( _ , current ) {
          if ( current is SendInterviews ) return true;
          if ( current is SendInterviewsError ) return true;
          return false;
        },
        listener: ( _ , state ) {
          if ( state is SendInterviews ) print('send interviews state');
          if ( state is SendInterviewsError ) print('send interviewserror state');
        },
        buildWhen: ( _ , current ) {
          if ( current is InterviewsLoaded ) return true;
          return false;
        },
        builder: ( _ , state ) {
          if ( state is InterviewsLoaded ) {
            if ( state.interviews!.isNotEmpty ) {
              return MyInterviwsWidgets(interviews: state.interviews!);
            }
          }
          return Center(
            child: Text('Without interviews'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
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