import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'location_cubit.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: BlocBuilder<LocationCubit, String?>(
          builder: (context, state) {
            if (state != null) {
              return Text(state);
            } else {
              return const Text('Press start');
            }
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () => context.read<LocationCubit>().getLocationPermission(),
            child: const Text('Start location'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => context.read<LocationCubit>().stopLocationStream(),
            child: const Text('Stop location'),
          ),
        ],
      ),
    );
  }
}
