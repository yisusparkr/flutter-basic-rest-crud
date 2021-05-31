import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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

    try{
      yield SigningIn();
      // Call the signIn method from the LoginRepository, it returns if the user doesn't exist,
      // if the password is wrong and if the user logged successfully
      final response = await loginRepository.signIn( email, password );
      final status = response['status'];
      switch ( status ) {
        case 'user-not-found':
          print(status);
          yield SignInError(errorMessage: 'There is no user with the email entered');
          break;
        case 'wrong-password':
          print(status);
          yield SignInError(errorMessage: 'Wrong password');
          break;
        case 'login-success':
          print('$response, navigate to home page');
          yield SignedIn();
          break;
        default:
      }
    } catch( error ) {
      yield SignInError(errorMessage: 'Something went wrong: $error'); 
      yield SignInInitial();     
    }

    yield SignInInitial();

  }

}
