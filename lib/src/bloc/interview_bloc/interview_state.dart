part of 'interview_bloc.dart';

@immutable
abstract class InterviewState extends Equatable {
  const InterviewState();
  
  @override
  List get props => [];
}

class InterviewInitial extends InterviewState {}

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

class SendInterviews extends InterviewState {}

class SendInterviewsError extends InterviewState {

  final String? errorMessage;

  SendInterviewsError({
    this.errorMessage
  });

  @override
  List get props => [errorMessage];

}
