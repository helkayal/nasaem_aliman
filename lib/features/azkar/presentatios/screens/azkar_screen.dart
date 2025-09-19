import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/azkar_cubit.dart';

class AzkarScreen extends StatelessWidget {
  const AzkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الأذكار")),
      body: BlocBuilder<AzkarCubit, AzkarState>(
        builder: (context, state) {
          if (state is AzkarLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AzkarLoaded) {
            return ListView.builder(
              itemCount: state.azkar.length,
              itemBuilder: (context, index) {
                final zekr = state.azkar[index];
                return ListTile(
                  title: Text(zekr.text),
                  subtitle: Text("Category: ${zekr.category}"),
                );
              },
            );
          } else if (state is AzkarError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text("Press refresh to load Azkar"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<AzkarCubit>().fetchAzkar();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
