import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/utils/validate_email.dart';
import '/src/bloc/sign_in/sign_in_bloc.dart';
import '/src/pages/sign_up_page/sign_up_page.dart';

class SignInForms extends StatefulWidget {
  @override
  _SignInFormsState createState() => _SignInFormsState();
}

class _SignInFormsState extends State<SignInForms> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final formTextStyle = TextStyle( fontSize: 18.0 );

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            enableSuggestions: true,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            style: formTextStyle,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
              icon: Icon(Icons.email_rounded)
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
            textInputAction: TextInputAction.done,
            style: formTextStyle,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
              icon: Icon(Icons.lock_rounded)
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
                style: TextStyle( fontSize: 18.0, color: Colors.white ),
              ),
              onPressed: () {
                if ( _formKey.currentState!.validate() ) {
                  final email = this._emailController.text.toLowerCase().trim();
                  final password = this._passwordController.text.trim();
                  BlocProvider.of<SignInBloc>(context).add( OnUserSignIn( email, password ) );
                }
              }
            ),
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
                'Sign up',
                style: TextStyle( fontSize: 18.0, color: Colors.white ),
              ),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpPage()))
            ),
          ),
        ],
      ),
    );
  }
}