import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:poc_app/constants/route_constant.dart';
import 'package:poc_app/presentations/bloc/auth_bloc/auth_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is AuthenticationAuthenticated) {
                  return Column(
                    children: [
                      Text("token: ${state.token}"),
                      buildButtonSignOut(),
                    ],
                  );
                } else {
                  return buildButtonSignIn();
                }
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'btn5',
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildButtonSignIn() {
    return InkWell(
      child: Container(
        constraints: BoxConstraints.expand(height: 50),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.green[200]),
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(12),
        child: Text("Sign in",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
      onTap: () {
        onTapSignin();
      },
    );
  }

  void onTapSignin() {
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => LoginScreen()));
    // Navigator.pushNamed(context, '/login');
    context.pushNamed(RouteConstants.login);
  }

  Widget buildButtonSignOut() {
    return InkWell(
      child: Container(
          constraints: BoxConstraints.expand(height: 50),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.green[200]),
          margin: EdgeInsets.only(top: 16),
          padding: EdgeInsets.all(12),
          child: Text("Log out",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white))),
      onTap: () {
        onTapSignOut();
      },
    );
  }

  void onTapSignOut() {
    context.read<AuthenticationBloc>().add(LoggedOut());
  }
}
