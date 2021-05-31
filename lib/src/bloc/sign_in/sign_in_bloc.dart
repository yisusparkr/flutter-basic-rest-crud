import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/src/utils/validate_email.dart';
import '/src/data/repositories/login_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {

  final LoginRepository loginRepository;

  SignInBloc({
    required this.loginRepository
  }) : super(SignInInitial());

  @override
  Stream<SignInState> mapEventToState( SignInEvent event ) async* {
    if ( event is OnUserSignIn ) {
      yield* _login(event);  
    }
  }

  Stream<SignInState> _login( OnUserSignIn event ) async* {
    final email = event.email;
    final password = event.password;

    // Validate all the cases about the login before call the method that connect us with the backend
    if ( email.isNotEmpty && password .isNotEmpty) {
      final isValidEmail = validateEmail(email);
      if ( isValidEmail ) {
        try{
          yield SigningIn();
          // Call the login method from the LoginRepository, it returns if the user doesn't exist,
          // if the password is wrong and if the user logged successfully
          final response = await loginRepository.signIn( email, password );
          switch ( response ) {
            case 'user-not-found':
              print(response);
              yield SignInError(errorMessage: 'There is no user with the email entered', closeDialog: true);
              break;
            case 'wrong-password':
              print(response);
              yield SignInError(errorMessage: 'Wrong password', closeDialog: true);
              break;
            case 'login-success':
              print('$response, navigate to home page');
              yield SignedIn();
              break;
            default:
          }
        } catch( error ) {
          yield SignInError(errorMessage: 'Something went wrong: $error', closeDialog: true); 
          yield SignInInitial();     
        }
      } else {
        yield SignInError(errorMessage: 'Input a valid email');     
      }
    } else {
      if ( email.isEmpty && password.isEmpty ) yield SignInError(errorMessage: 'Complete the fields');
      else if ( email.isEmpty ) yield SignInError(errorMessage: 'Write an email');
      else if ( password.isEmpty ) yield SignInError(errorMessage: 'Write your password');
    }

    yield SignInInitial();

  }

}
