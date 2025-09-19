import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/asmaa_cubit.dart';

class AsmaaScreen extends StatelessWidget {
  const AsmaaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("أسماه الله الحسنى")),
      body: BlocBuilder<AsmaaCubit, AsmaaState>(
        builder: (context, state) {
          if (state is AsmaaLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AsmaaLoaded) {
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: state.names.length,
              itemBuilder: (context, index) {
                final name = state.names[index];
                return Card(
                  elevation: 3,
                  child: Center(
                    child: Text(
                      name.arabic,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            );
          } else if (state is AsmaaError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text("Press refresh to load names"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<AsmaaCubit>().fetchNames();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
