part of 'interview_bloc.dart';

@immutable
abstract class InterviewState extends Equatable {
  const InterviewState();
  
  @override
  List get props => [];
}

class InterviewInitial extends InterviewState {}

class InterviewsInitialized extends InterviewState {}

class InterviewsLoaded extends InterviewState {

  final List<CompanyModel>? interviews;

  InterviewsLoaded({
    this.interviews
  });

  @override
  List get props => [interviews];

}

class AddingNewInterview extends InterviewState {

  final int? key;
  
  AddingNewInterview({
    this.key
  });

  @override
  List get props => [key];

}

class ModifyingInterview extends InterviewState {

  final CompanyModel? interview;
  ModifyingInterview({
    this.interview
  });

  @override
  List get props => [interview];

}

class WatchingInterview extends InterviewState {

  final CompanyModel? interview;
  WatchingInterview({
    this.interview
  });

  @override
  List get props => [interview];

}

class SendingInterviews extends InterviewState {}

class InterviewsSent extends InterviewState {

  final String? message;

  InterviewsSent({
    this.message
  });

  @override
  List get props => [message];

}

class SendInterviewsError extends InterviewState {

  final String? errorMessage;
  final bool? pop;

  SendInterviewsError({
    this.errorMessage,
    this.pop
  });

  @override
  List get props => [errorMessage, pop];

}
