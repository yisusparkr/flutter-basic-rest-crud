part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
  
  @override
  List get props => [];
}

class SignUpInitial extends SignUpState {}

class SigningUp extends SignUpState {}

class SignUpError extends SignUpState {

  final String? errorMessage;

  SignUpError({
    this.errorMessage, 
  });

  @override
  List get props => [errorMessage];

}

class SignedUp extends SignUpState {
  final String userName;
  final String userEmail;
  SignedUp(this.userName, this.userEmail);
}