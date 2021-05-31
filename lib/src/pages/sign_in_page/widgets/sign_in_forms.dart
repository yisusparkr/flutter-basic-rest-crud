import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/bloc/sign_in/sign_in_bloc.dart';
import '/src/utils/validate_email.dart';

class SignInForms extends StatefulWidget {

  final double formFontSize;
  final double buttonFontSize;
  final bool showIcons; 

  SignInForms({
    Key? key, 
    this.formFontSize = 18.0,
    this.buttonFontSize = 16.0,
    this.showIcons = true, 
  }) : super(key: key);

  @override
  _SignInFormsState createState() => _SignInFormsState();
}

class _SignInFormsState extends State<SignInForms> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final formTextStyle = TextStyle( fontSize: this.widget.formFontSize );

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            enableSuggestions: true,
            keyboardType: TextInputType.emailAddress,
            style: formTextStyle,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
              icon: ( this.widget.showIcons ) ? Icon(Icons.email_rounded) : null
            ),
            validator: ( value ) {
              if ( value == null || value.isEmpty || !validateEmail(value.trim()) ) return 'example@example.com';
              return null;
            },
          ),
          SizedBox( height: 15.0 ),
          TextFormField(
            controller: _passwordController,
            enableSuggestions: false,
            obscureText: true,
            style: formTextStyle,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
              icon: ( this.widget.showIcons ) ? Icon(Icons.lock_rounded) : null
            ),
            validator: ( value ) {
              if ( value == null || value.isEmpty ) return 'Write your password';
              return null;
            },
          ),
          SizedBox( height: 30.0 ),
          Container(
            height: 40.0,
            constraints: BoxConstraints(
              maxWidth: 300.0,
              minWidth: 200.0
            ),
            child: MaterialButton(
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(5.0) ),
              color: Colors.blue,
              child: Text(
                'Sign in',
                style: TextStyle( fontSize: this.widget.buttonFontSize, color: Colors.white ),
              ),
              onPressed: () {
                _formKey.currentState!.validate();
                BlocProvider.of<SignInBloc>(context).add( OnUserSignIn( this._emailController.text.trim(), this._passwordController.text.trim() ) );
              }
            ),
          )
        ],
      ),
    );
  }
}