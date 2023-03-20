part of 'map_cubit.dart';

class MapState extends Equatable {
  // final Trip trip;
  final RequestState? getAddressState;

  final AddressModel? endPoint;
  final AddressModel? startPoint;
  final Set<Polyline>  polyines;

  MapState({
    this.endPoint,
    this.getAddressState,
    this.startPoint,
    this.polyines = const {}
  });

  MapState copyWith({
    final AddressModel? endPoint,
    final RequestState? getAddressState,
    final AddressModel? startPoint,
   final Set<Polyline>?  polyines
  }) =>
      MapState(
        endPoint: endPoint ?? this.endPoint,
        startPoint: startPoint ?? this.startPoint,
        getAddressState: getAddressState ?? this.getAddressState,
        polyines: polyines ?? this.polyines
      );

  @override
  List<Object?> get props => [endPoint, startPoint, getAddressState,polyines];
}
