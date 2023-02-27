import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:taxi/core/utlis/app_model.dart';
import 'package:taxi/core/utlis/enums.dart';
import 'package:taxi/data/models/rsponse_home.dart';

import 'package:taxi/domin/entities/address_model.dart';
import 'package:taxi/domin/entities/trip.dart';
import 'package:taxi/domin/usese_cases/trip_uses_cases/add_trip_use_case.dart';
import 'package:taxi/domin/usese_cases/trip_uses_cases/home_trip_use_case.dart';

import '../../../domin/entities/car_type.dart';
import '../../../domin/usese_cases/trip_uses_cases/get_car_types_use_case.dart';

part 'trip_state.dart';

class TripCubit extends Cubit<TripState> {
  GetCarTypesUseCase getCarTypesUseCase;
  AddTripUseCase addTripUseCase;
  HomeTripUseCase homeTripUseCase;
  TripCubit(this.getCarTypesUseCase, this.addTripUseCase, this.homeTripUseCase)
      : super(TripState());

  static TripCubit get(context) => BlocProvider.of<TripCubit>(context);

  changeIndexTypeTrip(int newIndex) {
    emit(state.copyWith(currentIndexTypeTrip: newIndex));
  }

  getEndLocation(AddressModel value, {context}) async {
    print(value.label + "VVVVVVVVVVVVV");

    emit(state.copyWith(endPoint: value, statues: 1));
  }

  getStartPointAddress({lat, lng}) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);

    String address =
        "${placemarks[0].name},${placemarks[0].country},${placemarks[0].street}";

    AddressModel addressModel =
        AddressModel(label: address, lat: lat, lng: lng);

    emit(state.copyWith(startPoint: addressModel));
  }

  int selectedRadio = 0;
  changeValue(int val) {
    emit(state.copyWith(selectedRadio: val));
  }

  getCarTypes() async {
    emit(state.copyWith(carTypesState: RequestState.loading));
    final result = await getCarTypesUseCase.execute();
    result.fold((l) => emit(state.copyWith(carTypesState: RequestState.error)),
        (r) {
      print(r.length.toString() + "dddddddddd");
      emit(state.copyWith(carTypes: r, carTypesState: RequestState.loaded));
    });
  }

  addTrip(Trip trip) async {
    emit(state.copyWith(addTripState: RequestState.loading));
    final result = await addTripUseCase.execute(trip);
    result.fold((l) => emit(state.copyWith(carTypesState: RequestState.error)),
        (r) {
      
      emit(state.copyWith(addTripState: RequestState.loaded));
      homeTrip();
    });
  }

  homeTrip() async {
    emit(state.copyWith(homeState: RequestState.loading));
    final result = await homeTripUseCase.execute(userId: currentUser.id);
    result.fold((l) => emit(state.copyWith(homeState: RequestState.error)),
        (r) {
      emit(state.copyWith(homeState: RequestState.loaded, responseHome: r));
    });
  }
}
