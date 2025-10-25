import 'package:bloc_tutorial/bloc/counter_bloc.dart';
import 'package:bloc_tutorial/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncDec extends StatelessWidget {
  const IncDec({super.key});

  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: null,
            //onPressed: counterCubit.incrementCounter,
            onPressed: () {
              counterBloc.add(CounterIncremented());
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: null,
            //onPressed: counterCubit.decrementCounter,
            onPressed: () {
              counterBloc.add(CounterDecremented());
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: null,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MyHomePage(title: 'Flutter bloc'),
                ),
              );
            },
            child: const Icon(Icons.navigate_before),
          ),
        ],
      ),
    );
  }
}
