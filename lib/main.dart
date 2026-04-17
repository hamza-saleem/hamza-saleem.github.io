import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'app_bloc_observer.dart';
import 'core/theme/cubit/theme_cubit.dart';

void main() {
  Bloc.observer = const AppBlocObserver();
  runApp(
    BlocProvider(
      create: (_) => ThemeCubit(),
      child: const KageMichiApp(),
    ),
  );
}
