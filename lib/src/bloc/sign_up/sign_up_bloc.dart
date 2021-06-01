import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/src/data/repositories/login_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {

  final LoginRepository loginRepository;

  SignUpBloc({
    required this.loginRepository
  }) : super(SignUpInitial());

  @override
  Stream<SignUpState> mapEventToState( SignUpEvent event ) async* {
    if ( event is OnUserSignUp ) {
      yield* _signUp( event );
    }
  }


  Stream<SignUpState> _signUp( OnUserSignUp event ) async* {
    final firstName = event.firstName;
    final email = event.email;
    final password = event.password;

    try {
      // Call the signUp method from the LoginRepository, it will notice us if the email
      // is already registered and if the user was registered successfully
      yield SigningUp();
      final response = await loginRepository.signUp(firstName, email, password);
      final status = response['status'];
      final userName = response['name'];
      switch ( status ) {
        case 'user-registered':
          print('$status, navigate to home page');
          yield SignedUp(userName);
          break;
        case 'user-already-registered':
          print(status);
          yield SignUpError( errorMessage: 'Email already registered' );
          break;
        default:
      }
      
    } catch(error) {
      print(error);
      yield SignUpError( errorMessage: 'Something went wrong: $error' );
      yield SignUpInitial();
    }

  }

}
