
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());
  static HomeCubit get(context)=> BlocProvider.of<HomeCubit>(context);
  changeIndex(int newIndex) {
    emit(state.copyWith(currentIndex: newIndex));
  }
   changeIndexTypeTrip(int newIndex) {
    emit(state.copyWith(currentIndexTypeTrip: newIndex));
  }
}
