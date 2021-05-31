part of 'sign_up_bloc.dart';

abstract class SignUpEvent {}

class OnUserSignUp extends SignUpEvent {
  final String firstName;
  final String email;
  final String password;
  OnUserSignUp(this.firstName, this.email, this.password);
}
