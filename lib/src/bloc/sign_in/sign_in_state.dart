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

  SignInError({
    this.errorMessage,
  });

  @override
  List get props => [errorMessage];

} 

class SignedIn extends SignInState {
  final String userName;
  final String userEmail;
  SignedIn(this.userName, this.userEmail);
}
