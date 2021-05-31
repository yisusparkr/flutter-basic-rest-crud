import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/bloc/sign_in/sign_in_bloc.dart';
import 'src/bloc/sign_up/sign_up_bloc.dart';
import 'src/pages/sign_in_page/sign_in_page.dart';
import 'src/data/repositories/login_repository.dart';
 
void main() => runApp(
  MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => SignInBloc( loginRepository: LoginRepository() )),
      BlocProvider(create: (_) => SignUpBloc( loginRepository: LoginRepository() )),
    ],
    child: MyApp()
  )
);
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rest & Crud',
      home: SingInPage()
    );
  }
}