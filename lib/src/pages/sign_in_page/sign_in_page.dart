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

    final screenSize = MediaQuery.of(context).size;
    double logoSize = 150.0;
    double titleFontSize = 25.0;
    double formFontSize = 18.0;
    double buttonFontSize = 16.0;
    bool showIcons = true;

    if ( screenSize.width > 425 ) {
      logoSize = ( screenSize.width > 768 ) ? 200.0 : 150.0;
      titleFontSize = ( screenSize.width > 768 ) ? 35.0 : 30.0;
      formFontSize = ( screenSize.width > 768 ) ? 25.0 : 20.0;
      buttonFontSize = formFontSize - 2;
    }

    if ( screenSize.width < 425 ) showIcons = false;

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
                      size: logoSize,
                    ),
                    SizedBox( height: 50.0 ),
                    SignInTitle( titleFontSize: titleFontSize ),
                    SizedBox( height: 30.0 ),
                    SignInForms(
                      showIcons: showIcons,
                      formFontSize: formFontSize,
                      buttonFontSize: buttonFontSize
                    ),
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