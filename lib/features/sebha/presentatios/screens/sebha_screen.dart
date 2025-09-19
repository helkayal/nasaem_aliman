import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/sebha_cubit.dart';

class SebhaScreen extends StatelessWidget {
  const SebhaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("السبحه")),
      body: BlocBuilder<SebhaCubit, SebhaState>(
        builder: (context, state) {
          final count = state is SebhaCountUpdated ? state.count : 0;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Count: $count", style: const TextStyle(fontSize: 32)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () =>
                      context.read<SebhaCubit>().incrementCounter(),
                  child: const Text("Increment"),
                ),
                ElevatedButton(
                  onPressed: () => context.read<SebhaCubit>().resetCounter(),
                  child: const Text("Reset"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
