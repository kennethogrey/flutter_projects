import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_validation_bloc/bloc/auth_bloc.dart';
import 'package:flutter_login_validation_bloc/login_screen.dart';
import 'package:flutter_login_validation_bloc/widgets/gradient_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text((state as AuthSuccess).uid)),
              SizedBox(height: 20),
              GradientButton(
                onPressed: () {
                  context.read<AuthBloc>().add(AuthLogoutEventRequest());
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
