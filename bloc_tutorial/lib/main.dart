import 'package:bloc_tutorial/bloc/counter_bloc.dart';
import 'package:bloc_tutorial/cubit/counter_cubit.dart';
import 'package:bloc_tutorial/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBloc>(create: (_) => CounterBloc()),
        BlocProvider<CounterCubit>(create: (_) => CounterCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: MyHomePage(title: 'Flutter bloc'),
      ),
    );
  }
}
