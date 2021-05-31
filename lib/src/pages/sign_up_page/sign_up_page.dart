import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/sign_up_forms.dart';
import 'widgets/sign_up_title.dart';
import '/src/bloc/sign_up/sign_up_bloc.dart';
import '/src/pages/home_page/home_page.dart';
import '/src/helpers/helpers.dart' as helpers;

class SignUpPage extends StatelessWidget {

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
            child: BlocListener<SignUpBloc, SignUpState>(
              listenWhen: (previous, current) {
                if ( current is SigningUp ) return true;
                if ( current is SignedUp ) return true;
                if ( current is SignUpError ) return true;
                return false;
              },
              listener: ( _ , state ) {
                if ( state is SignedUp ) helpers.navigate(context, HomePage());
                if ( state is SigningUp ) helpers.showLoadingDialog(context, 'Signing Up');
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
                      size: logoSize,
                    ),
                    SizedBox( height: 50.0 ),
                    SignUpTitle( titleFontSize: titleFontSize ),
                    SizedBox( height: 30.0 ),
                    SignUpForms(
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