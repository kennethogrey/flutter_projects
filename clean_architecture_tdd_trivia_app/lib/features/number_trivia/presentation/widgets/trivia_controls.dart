import 'package:clean_architecture_tdd_trivia_app/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TriviaControls extends StatefulWidget {
  const TriviaControls({super.key});

  @override
  State<TriviaControls> createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  TextEditingController input = TextEditingController();
  @override
  void dispose() {
    input.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: input,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hint: Text('Input a number'),
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  context.read<NumberTriviaBloc>().add(
                    GetTriviaForConcreteNumber(input.text),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.green),
                ),
                child: Text('Search'),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  context.read<NumberTriviaBloc>().add(
                    GetTriviaForRandomNumber(),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.grey),
                ),
                child: Text('Get Random Trivia'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
