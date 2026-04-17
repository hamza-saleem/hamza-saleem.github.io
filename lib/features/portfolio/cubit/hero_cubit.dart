import 'package:flutter_bloc/flutter_bloc.dart';
import 'hero_state.dart';

export 'hero_state.dart';

class HeroCubit extends Cubit<HeroState> {
  HeroCubit() : super(const HeroState());

  void setNameWidth(double width) {
    emit(HeroState(nameWidth: width));
  }
}
