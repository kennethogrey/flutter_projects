import 'package:clean_architecture_tdd_trivia_app/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:clean_architecture_tdd_trivia_app/features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<NumberTriviaBloc>(),
      child: MaterialApp(
        title: 'Number Trivia',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.green.shade800),
        home: NumberTriviaPage(),
      ),
    );
  }
}
