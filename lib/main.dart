import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_chat/data/bloc/authentication/authentication_bloc.dart';
import 'package:happy_chat/data/bloc/authentication/authentication_event.dart';
import 'package:happy_chat/data/bloc/authentication/authentication_state.dart';
import 'package:happy_chat/data/bloc/signup/signup_bloc.dart';
import 'package:happy_chat/data/bloc/verification/verification_bloc.dart';
import 'package:happy_chat/presentation/router/app-router.dart';
import 'package:happy_chat/presentation/screens/home/home.dart';
import 'package:happy_chat/presentation/screens/signup/signup.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignupBloc>(
          create: (BuildContext context) => SignupBloc(),
        ),
        BlocProvider<VerificationBloc>(
          create: (BuildContext context) => VerificationBloc(),
        ),
        BlocProvider<AuthenticationBloc>(
          create: (BuildContext context) =>
              AuthenticationBloc()..add(Authentication()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Happy Chat',
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xffFCEDEA),
          //textTheme: TextTheme(bodyText2: TextStyle()),
          fontFamily: 'Dana',
          primarySwatch: Colors.blue,
        ),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is SuccessAuthenticationState)
              return HomeView();
            else
              return SignUpView();
          },
        ),
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }
}
