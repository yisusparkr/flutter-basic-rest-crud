part of 'sign_in_bloc.dart';

abstract class SignInEvent {}

class OnUserSignIn extends SignInEvent {
  final String email;
  final String password;
  OnUserSignIn(this.email, this.password);
}
