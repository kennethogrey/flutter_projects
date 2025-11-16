import 'package:clean_architecture_tdd_trivia_app/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:clean_architecture_tdd_trivia_app/features/number_trivia/presentation/widgets/loading_widget.dart';
import 'package:clean_architecture_tdd_trivia_app/features/number_trivia/presentation/widgets/message_display.dart';
import 'package:clean_architecture_tdd_trivia_app/features/number_trivia/presentation/widgets/trivia_controls.dart';
import 'package:clean_architecture_tdd_trivia_app/features/number_trivia/presentation/widgets/trivia_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Number Trivia')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 10),
            BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
              builder: (context, state) {
                if (state is Empty) {
                  return MessageDisplay(message: 'Start Searching');
                } else if (state is Error) {
                  return MessageDisplay(message: state.message);
                } else if (state is Loading) {
                  return LoadingWidget();
                }
                return TriviaDisplay(numberTrivia: (state as Loaded).trivia);
              },
            ),
            SizedBox(height: 20),
            TriviaControls(),
          ],
        ),
      ),
    );
  }
}
