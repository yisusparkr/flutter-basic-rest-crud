import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'src/bloc/sign_in/sign_in_bloc.dart';
import 'src/bloc/sign_up/sign_up_bloc.dart';
import 'src/pages/sign_in_page/sign_in_page.dart';
import 'src/data/repositories/login_repository.dart';
import '/src/data/repositories/hive_repository.dart';
import '/src/bloc/interview_bloc/interview_bloc.dart';
import '/src/data/repositories/interviews_repository.dart';
 
Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final HiveRepository hiveRepository = HiveRepository();
  await hiveRepository.initDB();
  
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SignInBloc( loginRepository: LoginRepository() )),
        BlocProvider(create: (_) => SignUpBloc( loginRepository: LoginRepository() )),
        BlocProvider(create: (_) => InterviewBloc( hiveRepository: hiveRepository, interviewsRepository: InterviewsRepository() )),
      ],
      child: MyApp()
    )
  );
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rest & Crud',
      builder: (context, child) => ResponsiveWrapper.builder(
          child,
          maxWidth: 1200,
          minWidth: 280,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(280, name: MOBILE),
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: DESKTOP),
          ],
          background: Container(color: Color(0xFFF5F5F5))),
      home: SingInPage(),
    );
  }
}