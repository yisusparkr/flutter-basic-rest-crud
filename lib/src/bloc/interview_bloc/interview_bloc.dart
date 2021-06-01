import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '/src/data/models/company_model.dart';
import '/src/data/repositories/hive_repository.dart';

part 'interview_event.dart';
part 'interview_state.dart';

class InterviewBloc extends Bloc<InterviewEvent, InterviewState> {

  final HiveRepository hiveRepository;

  InterviewBloc({
    required this.hiveRepository
  }) : super(InterviewInitial());

  @override
  Stream<InterviewState> mapEventToState( InterviewEvent event ) async* {
    if ( event is OnLoadInterviews ) {
      final interviews = await hiveRepository.getInterviews();
      yield InterviewsLoaded( interviews: interviews );
    } else if ( event is OnUserAddInterview ) {
      final key = await hiveRepository.addInterview();
      yield AddingNewInterview( key: key );
    } else if ( event is OnUserWriteCompanyName ) {
      await hiveRepository.modifyInterview( event.key, name: event.company );
    } else if ( event is OnUserWriteComment ) {
      await hiveRepository.modifyInterview( event.key, name: event.comment );
    } else if ( event is OnUserWriteNumber ) {
      await hiveRepository.modifyInterview( event.key, name: event.number );
    } else if ( event is OnUserSelectDateTime ) {
      await hiveRepository.modifyInterview( event.key, name: event.date );
    } else if ( event is OnUserSaveInterview ) {
      await hiveRepository.saveInterview(event.key);
    }
  }
}
