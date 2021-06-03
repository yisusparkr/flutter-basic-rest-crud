import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '/src/data/models/company_model.dart';
import '/src/data/repositories/hive_repository.dart';
import '/src/data/repositories/interviews_repository.dart';

part 'interview_event.dart';
part 'interview_state.dart';

class InterviewBloc extends Bloc<InterviewEvent, InterviewState> {

  final HiveRepository hiveRepository;
  final InterviewsRepository interviewsRepository;

  InterviewBloc({
    required this.hiveRepository,
    required this.interviewsRepository
  }) : super(InterviewInitial());

  String _userEmail = '';
  String get userEmail => this._userEmail;
  set userEmail( String value ) => this._userEmail = value;

  @override
  Stream<InterviewState> mapEventToState( InterviewEvent event ) async* {
    if ( event is OnInitializeInterviews ) {
      userEmail = event.userEmail!;
      await hiveRepository.openBox(userEmail);
      yield InterviewsInitialized();
    } else if ( event is OnLoadInterviews ) {
      final interviews = await hiveRepository.getInterviews(userEmail);
      yield InterviewsLoaded( interviews: interviews );
    } else if ( event is OnUserAddInterview ) {
      final key = await hiveRepository.addInterview(userEmail);
      yield AddingNewInterview( key: key );
    } else if ( event is OnUserModifyInterview ) {
      yield ModifyingInterview( interview: event.interview );
    } else if ( event is OnUserWatchInterview ) {
      yield WatchingInterview( interview: event.interview );
    } else if ( event is OnUserWriteCompanyName ) {
      await hiveRepository.modifyInterview( event.key, userEmail, name: event.company );
    } else if ( event is OnUserWriteComment ) {
      await hiveRepository.modifyInterview( event.key, userEmail, comment: event.comment );
    } else if ( event is OnUserWriteNumber ) {
      await hiveRepository.modifyInterview( event.key, userEmail, number: event.number );
    } else if ( event is OnUserSelectDateTime ) {
      await hiveRepository.modifyInterview( event.key, userEmail, date: event.date );
    } else if ( event is OnUserSaveInterview ) {
      await hiveRepository.saveInterview(event.key, userEmail);
      final interviews = await hiveRepository.getInterviews(userEmail);
      yield InterviewsLoaded( interviews: interviews );
    } else if ( event is OnUserDeleteInterview ) {
      await hiveRepository.deleteInterview(event.key, userEmail);
      final interviews = await hiveRepository.getInterviews(userEmail);
      yield InterviewsLoaded( interviews: interviews );
    } else if ( event is OnUserSendInterviews ) {
      yield* _sendInterviews();
    }
  }

  Stream<InterviewState> _sendInterviews() async* {
    final interviews = await hiveRepository.getInterviews(userEmail);
    final hasCpomletedInterviews = hiveRepository.hasCompletedInterviews(userEmail);
    if ( hasCpomletedInterviews ) {
      // Call to the sendInterviews method from the InterviewsRepository where connect us with 
      // the backend and send the interviews that their status are completed and when 
      // call the deleteCompetedInterviews from the HiveRepository where delete from DB 
      // all the interviews that their status are completed
      try {
        yield SendingInterviews();
        final status = await interviewsRepository.sendInterviews(interviews);
        if ( status == 'data sent' ) {
          await hiveRepository.deleteCompletedInterviews(userEmail);
          yield InterviewsSent( message: 'Data synchronized successfully' );
          final newInterviews = await hiveRepository.getInterviews(userEmail);
          yield InterviewsLoaded( interviews: newInterviews );
        } else {
          yield SendInterviewsError( errorMessage: 'Cant\'t sync interviews, verify your Internet connection', pop: true );
          yield InterviewsLoaded( interviews: interviews );
        }
      } catch (e) {
        yield SendInterviewsError( errorMessage: '$e', pop: true );
        yield InterviewsLoaded( interviews: interviews );
      }
    } else {
      yield SendInterviewsError( errorMessage: 'You don\'t have an interview completed', pop: false );
      yield InterviewsLoaded( interviews: interviews, );
    }
    
    
    
  }

}
