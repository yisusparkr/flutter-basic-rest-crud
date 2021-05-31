import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/sign_in_forms.dart';
import 'widgets/sign_in_title.dart';
import '/src/bloc/sign_in/sign_in_bloc.dart';
import '/src/pages/home_page/home_page.dart';

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
              listenWhen: (previous, current) {
                if ( current is SignedIn ) return true;
                if ( current is SigningIn ) return true;
                if ( current is SignInError ) return true;
                return false;
              },
              listener: ( _ , state ) {
                if ( state is SignedIn ) _navigate( context );
                if ( state is SigningIn ) _showLoadingDialog(context);
                if ( state is SignInError ) _showErrorSnackBar(context, state.errorMessage!, state.closeDialog);
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

  void _navigate( BuildContext context ) {
    Navigator.of(context).pop();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
  }

  void _showLoadingDialog( BuildContext context ) {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text('Signing In'),
        content: Container(
          height: 100.0,
          width: 100.0,
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
              strokeWidth: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  void _showErrorSnackBar( BuildContext context, String message, bool? closeDialog ) {

    if ( closeDialog != null && closeDialog ) Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error, color: Colors.red),
            SizedBox( width: 10.0 ),
            Text(message)
          ],
        )
      )
    );
  }

}