part of 'interview_bloc.dart';

abstract class InterviewEvent {}

class OnLoadInterviews extends InterviewEvent {}

class OnUserAddInterview extends InterviewEvent {}

class OnUserModifyInterview extends InterviewEvent {
  final CompanyModel interview;
  OnUserModifyInterview(this.interview);
}

class OnUserWatchInterview extends InterviewEvent {
  final CompanyModel interview;
  OnUserWatchInterview(this.interview);
}

class OnUserWriteCompanyName extends InterviewEvent {
  final int key;
  final String company;
  OnUserWriteCompanyName(this.key, this.company);
}

class OnUserWriteComment extends InterviewEvent {
  final int key;
  final String comment;
  OnUserWriteComment(this.key, this.comment);
}

class OnUserWriteNumber extends InterviewEvent {
  final int key;
  final String number;
  OnUserWriteNumber(this.key, this.number);
}

class OnUserSelectDateTime extends InterviewEvent {
  final int key;
  final DateTime date;
  OnUserSelectDateTime(this.key, this.date);
}

class OnUserSaveInterview extends InterviewEvent {
  final int key;
  OnUserSaveInterview(this.key);
}

class OnUserDeleteInterview extends InterviewEvent {
  final int key;
  OnUserDeleteInterview(this.key);
}


