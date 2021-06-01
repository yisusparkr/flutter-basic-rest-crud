import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/bloc/interview_bloc/interview_bloc.dart';
import 'widgets/add_interview_dialog.dart';

class HomePage extends StatelessWidget {

  final String userName;

  const HomePage({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${this.userName}'),
      ),
      body: BlocConsumer<InterviewBloc, InterviewState>(
        listenWhen: (previous, current) {
          if ( current is SendInterviews ) return true;
          if ( current is SendInterviewsError ) return true;
          return false;
        },
        listener: ( _ , state ) {
          if ( state is SendInterviews ) print('send interviews state');
          if ( state is SendInterviewsError ) print('send interviewserror state');
        },
        buildWhen: (previous, current) {
          if ( current is InterviewsLoaded ) return true;
          return false;
        },
        builder: ( _ , state ) {
          if ( state is InterviewsLoaded ) {
            return ( state.interviews != [] ) 
            ? Container(
              child: ListView.builder(
                itemCount: state.interviews!.length,
                itemBuilder: ( _ , index ) {
                  return Text('${state.interviews![index].enterprise}');
                },
              ),
            )
            : Center(
              child: Text('Without interviews'),
            );
          }
          return SizedBox();
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

    BlocProvider.of<InterviewBloc>(context, listen: false).add( OnUserAddInterview() );;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AddIntreviewDialog()
    );
  }
}