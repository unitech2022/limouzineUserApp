part of 'home_cubit.dart';

class HomeState extends Equatable {
  final int currentIndex;
   final int currentIndexTypeTrip;

  const HomeState({this.currentIndex = 0,this.currentIndexTypeTrip=1});

  HomeState copyWith({final currentIndex,final currentIndexTypeTrip}) =>
      HomeState(currentIndex: currentIndex ?? this.currentIndex,currentIndexTypeTrip: currentIndexTypeTrip??this.currentIndexTypeTrip);
  @override
  List<Object?> get props => [currentIndex,currentIndexTypeTrip];
}
