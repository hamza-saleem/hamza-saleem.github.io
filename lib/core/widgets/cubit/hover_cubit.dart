import 'package:flutter_bloc/flutter_bloc.dart';

class HoverCubit extends Cubit<bool> {
  HoverCubit() : super(false);

  void onEnter() {
    if (!state) emit(true);
  }

  void onExit() {
    if (state) emit(false);
  }
}
