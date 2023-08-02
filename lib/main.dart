import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'location_cubit.dart';
import 'my_app.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => LocationCubit(),
      child: const MyApp(),
    ),
  );
}