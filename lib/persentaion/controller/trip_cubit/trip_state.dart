part of 'trip_cubit.dart';

class TripState extends Equatable {
  final ResponseHome? responseHome;
  final RequestState? homeState;
  final List<CartType> carTypes;
  final RequestState? carTypesState;
  final int statues;

  // final Trip trip;
  final RequestState? addTripState;
  final int selectedRadio;
  final AddressModel? endPoint;
  final AddressModel? startPoint;
  final int currentIndex;
  final int currentIndexTypeTrip;

  TripState(
      {this.endPoint,
      this.carTypes = const [],
      this.currentIndex = 0,
      this.selectedRadio = 0,
      this.statues = 0,
      this.homeState,
      this.responseHome,
      this.addTripState,
      this.carTypesState = RequestState.loading,
      this.startPoint,
      this.currentIndexTypeTrip = 1});

  TripState copyWith(
          {final AddressModel? endPoint,
          final currentIndex,
          final RequestState? carTypesState,
          final RequestState? addTripState,
          final statues,
          final ResponseHome? responseHome,
          final RequestState? homeState,
          final int? selectedRadio,
          final List<CartType>? carTypes,
          final currentIndexTypeTrip,
          final AddressModel? startPoint}) =>
      TripState(
          homeState: homeState ?? this.homeState,
          responseHome: responseHome ?? this.responseHome,
          statues: statues ?? this.statues,
          carTypes: carTypes ?? this.carTypes,
          carTypesState: carTypesState ?? this.carTypesState,
          startPoint: startPoint ?? this.startPoint,
          selectedRadio: selectedRadio ?? this.selectedRadio,
          endPoint: endPoint ?? this.endPoint,
          addTripState: addTripState ?? this.addTripState,
          currentIndex: currentIndex ?? this.currentIndex,
          currentIndexTypeTrip:
              currentIndexTypeTrip ?? this.currentIndexTypeTrip);

  @override
  List<Object?> get props => [
        endPoint,
        currentIndex,
        currentIndexTypeTrip,
        startPoint,
        carTypes,
        carTypesState,
        addTripState,
        homeState,
        responseHome
      ];
}
