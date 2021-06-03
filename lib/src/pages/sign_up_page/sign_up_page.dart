import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/sign_up_forms.dart';
import 'widgets/sign_up_title.dart';
import '/src/bloc/sign_up/sign_up_bloc.dart';
import '/src/pages/home_page/home_page.dart';
import '/src/helpers/helpers.dart' as helpers;
import '/src/constants/constants.dart' as constants;
import '/src/bloc/interview_bloc/interview_bloc.dart';

class SignUpPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: BlocListener<SignUpBloc, SignUpState>(
              listenWhen: ( _ , current ) {
                if ( current is SigningUp ) return true;
                if ( current is SignedUp ) return true;
                if ( current is SignUpError ) return true;
                return false;
              },
              listener: ( _ , state ) {
                if ( state is SignedUp ) {
                  BlocProvider.of<InterviewBloc>(context).add( OnInitializeInterviews(userEmail: state.userEmail) );
                  helpers.navigate( context, HomePage( userName: state.userName ));
                }
                if ( state is SigningUp ) helpers.showLoadingDialog(context, constants.signingUpTitle);
                if ( state is SignUpError ) helpers.showErrorSnackBar(context, state.errorMessage!);
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
                    IconButton(
                      splashRadius: 15.0,
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.pop(context), 
                    ),
                    SizedBox( height: 20.0 ),
                    FlutterLogo(
                      size: 150.0,
                    ),
                    SizedBox( height: 50.0 ),
                    SignUpTitle(),
                    SizedBox( height: 30.0 ),
                    SignUpForms(),
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