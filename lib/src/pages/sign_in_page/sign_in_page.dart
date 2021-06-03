import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/sign_in_forms.dart';
import 'widgets/sign_in_title.dart';
import '/src/bloc/sign_in/sign_in_bloc.dart';
import '/src/pages/home_page/home_page.dart';
import '/src/helpers/helpers.dart' as helpers;
import '/src/constants/constants.dart' as constants;
import '/src/bloc/interview_bloc/interview_bloc.dart';

class SingInPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: BlocListener<SignInBloc, SignInState>(
              listenWhen: ( _ , current ) {
                if ( current is SignedIn ) return true;
                if ( current is SigningIn ) return true;
                if ( current is SignInError ) return true;
                return false;
              },
              listener: ( _ , state ) {
                if ( state is SigningIn ) helpers.showLoadingDialog(context, constants.signingInTitle );
                if ( state is SignedIn ) {
                  BlocProvider.of<InterviewBloc>(context).add( OnInitializeInterviews(userEmail: state.userEmail) );
                  helpers.navigate( context, HomePage( userName: state.userName ));
                }
                if ( state is SignInError ) helpers.showErrorSnackBar(context, state.errorMessage!);
              },
              child: Container(
                padding: const EdgeInsets.symmetric( horizontal: 20.0, vertical: 30.0 ),
                constraints: BoxConstraints(
                  maxWidth: 500.0,
                  minWidth: 200.0
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlutterLogo(
                      size: 150.0,
                    ),
                    SizedBox( height: 50.0 ),
                    SignInTitle(),
                    SizedBox( height: 30.0 ),
                    SignInForms(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}