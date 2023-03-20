part of 'trip_cubit.dart';

class TripState extends Equatable {
  final ResponseHome? responseHome;
  final RequestState? homeState;
  final List<CartType> carTypes;
  final RequestState? carTypesState;
   final RequestState? changeStatusTrip;
   //timer 
      final int? timerTrip;
      final bool? isActiveTimer;
  final int statues;
final RequestState? updateDeviceTokenState;
  // final Trip trip;
  final RequestState? addTripState;
  final int selectedRadio;
  final AddressModel? endPoint;
  final AddressModel? startPoint;
  final int currentIndex;
  final int currentIndexTypeTrip;
  // grt histories
  final RequestState? getHistoriesState;
  final ResponseHistory? histories;

  TripState(
      {this.endPoint,
      this.carTypes = const [],
      this.currentIndex = 0,
      this.timerTrip=0,
      this.selectedRadio = 0,
      this.statues = 0,
      this.isActiveTimer=false,
      this.homeState,
      this.changeStatusTrip,
      this.responseHome,
      this.addTripState,
      this.carTypesState = RequestState.loading,
      this.startPoint,
      this.updateDeviceTokenState,
      this.currentIndexTypeTrip = 1,
      this.getHistoriesState,
        this.histories


      });

  TripState copyWith(
          {final AddressModel? endPoint,
          final currentIndex,
          final RequestState? carTypesState,
          final RequestState? addTripState,
          final statues,
          final bool? isActiveTimer,
          final int? timerTrip,
           final RequestState? updateDeviceTokenState,
          final RequestState? changeStatusTrip,
          final ResponseHome? responseHome,
          final RequestState? homeState,
          final int? selectedRadio,
          final List<CartType>? carTypes,
          final currentIndexTypeTrip,
          final AddressModel? startPoint,
            final RequestState? getHistoriesState,
            final ResponseHistory? histories

          }) =>
      TripState(
          homeState: homeState ?? this.homeState,
          responseHome: responseHome ?? this.responseHome,
          changeStatusTrip: changeStatusTrip??this.changeStatusTrip,
          statues: statues ?? this.statues,
          carTypes: carTypes ?? this.carTypes,
          timerTrip: timerTrip??this.timerTrip,
          updateDeviceTokenState: updateDeviceTokenState??this.updateDeviceTokenState,
          carTypesState: carTypesState ?? this.carTypesState,
          startPoint: startPoint ?? this.startPoint,
          selectedRadio: selectedRadio ?? this.selectedRadio,
          endPoint: endPoint ?? this.endPoint,
          addTripState: addTripState ?? this.addTripState,
          currentIndex: currentIndex ?? this.currentIndex,
          currentIndexTypeTrip:
              currentIndexTypeTrip ?? this.currentIndexTypeTrip,
          getHistoriesState: getHistoriesState ?? this.getHistoriesState,
          histories: histories ?? this.histories,
          isActiveTimer: isActiveTimer ?? this.isActiveTimer,

      );

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
        updateDeviceTokenState,
        responseHome,changeStatusTrip,statues,timerTrip,
    histories,
    getHistoriesState,
    isActiveTimer
      ];
}
