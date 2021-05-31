part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();
  
  @override
  List get props => [];
}

class SignInInitial extends SignInState {}

class SigningIn extends SignInState {}

class SignInError extends SignInState {

  final String? errorMessage;
  final bool? closeDialog;

  SignInError({
    this.errorMessage,
    this.closeDialog
  });

  @override
  List get props => [errorMessage, closeDialog];

} 

class SignedIn extends SignInState {}
