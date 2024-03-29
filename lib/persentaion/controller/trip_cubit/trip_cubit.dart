import 'dart:async';
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';

import 'package:taxi/core/helpers/functions.dart';
import 'package:taxi/core/helpers/helper_functions.dart';
import 'package:taxi/core/utlis/app_model.dart';
import 'package:taxi/core/utlis/enums.dart';

import 'package:taxi/data/models/address_model.dart';
import 'package:taxi/data/models/rsponse_home.dart';
import 'package:http/http.dart' as http;
import 'package:taxi/domin/entities/address_model.dart';
import 'package:taxi/domin/entities/trip.dart';
import 'package:taxi/domin/usese_cases/trip_uses_cases/add_trip_use_case.dart';
import 'package:taxi/domin/usese_cases/trip_uses_cases/home_trip_use_case.dart';
import 'package:taxi/persentaion/ui/booking_screen/booking_screen.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import '../../../core/utlis/api_constatns.dart';
import '../../../core/utlis/strings.dart';
import '../../../data/models/booking_response.dart';
import '../../../data/models/external_details.dart';
import '../../../data/models/external_trip.dart';
import '../../../data/models/group_location.dart';
import '../../../data/models/history_response.dart';
import '../../../domin/entities/car_type.dart';
import '../../../domin/entities/city.dart';
import '../../../domin/usese_cases/trip_uses_cases/get_car_types_use_case.dart';
import '../../ui/waiting_trip_screen/waiting_trip_screen.dart';
import '../map_cubit copy/map_cubit.dart';

part 'trip_state.dart';

class TripCubit extends Cubit<TripState> {
  GetCarTypesUseCase getCarTypesUseCase;
  AddTripUseCase addTripUseCase;
  HomeTripUseCase homeTripUseCase;
  TripCubit(this.getCarTypesUseCase, this.addTripUseCase, this.homeTripUseCase)
      : super(TripState());

  static TripCubit get(context) => BlocProvider.of<TripCubit>(context);

  changeIndexTypeTrip(int newIndex) {
    print(newIndex.toString() + "====== > type trip just");
    emit(state.copyWith(currentIndexTypeTrip: newIndex));
  }

  getEndLocation(AddressModel value, {context}) async {
    print(value.label + "VVVVVVVVVVVVV");

    emit(state.copyWith(endPoint: value));
    // MapCubit.get(context).drawPolyline(
    //     LatLng(state.startPoint!.lat, state.startPoint!.lng),
    //     LatLng(value.lat, value.lng));
  }

  changeStatusScreen(int status, {context}) async {
    print(status.toString() + "stause screen");

    emit(state.copyWith(statues: status));
  }

  getStartLocation(AddressModel value, {context}) async {
    print(value.label + "start location");

    emit(state.copyWith(startPoint: value));
  }

  getStartPointAddress({lat, lng, context}) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);

    String address =
        "${placemarks[0].name},${placemarks[0].country},${placemarks[0].street}";

    AddressModel addressModel =
        AddressModel(label: address, lat: lat, lng: lng);
    getCities();
    emit(state.copyWith(startPoint: addressModel));
    MapCubit.get(context).getStartLocation(addressModel);
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

  Timer? timer;
  int _start = 0;

  void startTimer(Trip trip) {
    emit(state.copyWith(isActiveTimer: true));
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 100) {
          print("${trip.status}  :  statsss");

          timer.cancel();
          emit(state.copyWith(timerTrip: _start, isActiveTimer: false));

          if (trip.driverId != 0) {
            changeStatusTrip(
                tripId: trip.id,
                userId: state.responseHome!.driver!.userId,
                status: 7,
                isState: 0);
            _start = 0;
            emit(state.copyWith(timerTrip: 0, isActiveTimer: false));
          } else {
            changeStatusTrip(
                tripId: trip.id,
                userId: currentUser.id!,
                status: 7,
                isState: 0);
            _start = 0;
            emit(state.copyWith(timerTrip: 0, isActiveTimer: false));
          }

          showToast(message: "لم يتم العثور علي سائقين");
        } else {
          _start++;
          emit(state.copyWith(timerTrip: _start));
        }
      },
    );
  }

  cancelTimer() {
    if (timer!.isActive) timer!.cancel();

    emit(state.copyWith(isActiveTimer: false));
  }

// move Map

  String detailsAddress = "";
  bool loading = false;
  Future getAddresses(double lat, double long) async {
    loading = true;
    emit(state.copyWith(movMapState: RequestState.loading));
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);

    detailsAddress =
        "${placemarks[0].name},${placemarks[0].country},${placemarks[0].street}";

    // print( detailsAddress+
    // "====== > address");

    loading = false;
    emit(state.copyWith(movMapState: RequestState.loaded));
  }

  //////////

  addTrip(Trip trip, {type}) async {
    emit(state.copyWith(addTripState: RequestState.loading));
    final result = await addTripUseCase.execute(trip, type: type);
    result.fold((l) => emit(state.copyWith(carTypesState: RequestState.error)),
        (r) {
      changeStatusHome(0);

      emit(state.copyWith(addTripState: RequestState.loaded));

      homeTrip();
      startTimer(r);
    });
  }

  homeTrip() async {
    await getCities();
    emit(state.copyWith(homeState: RequestState.loading));
    final result = await homeTripUseCase.execute(userId: currentUser.id);
    result.fold((l) => emit(state.copyWith(homeState: RequestState.error)),
        (r) {
      if (r.trip != null && r.trip!.status != 0 && timer != null) {
        _start = 0;
        cancelTimer();
      }
      //  print(r.userDetail!.fullName! +"home");
      if (r.userDetail != null) {
        currentUser.email =
            r.userDetail!.email != null ? r.userDetail!.email : "";
        currentUser.fullName = r.userDetail!.fullName;
        currentUser.profileImage = r.userDetail!.profileImage != null
            ? r.userDetail!.profileImage
            : "";
        currentUser.deviceToken = r.userDetail!.deviceToken;
      }

      emit(state.copyWith(homeState: RequestState.loaded, responseHome: r));
    });
  }

  /// Todo : refactor
  Future changeStatusTrip({tripId, status, userId, isState = 0}) async {
    emit(state.copyWith(changeStatusTrip: RequestState.loading));
    var request = http.MultipartRequest(
        'POST', Uri.parse(ApiConstants.changeStatusTripPath));
    request.fields.addAll({
      'status': status.toString(),
      'tripId': tripId.toString(),
      'userId': userId
    });

    http.StreamedResponse response = await request.send();
    print(response.statusCode.toString() + "  changeStatusTrip");
    if (response.statusCode == 200) {
      print(response.statusCode.toString());
      emit(state.copyWith(changeStatusTrip: RequestState.loaded));
      _start = 0;
      if (isState == 0) {
        print("hoooooooooome");

        homeTrip();
      }
    } else {
      print(response.statusCode.toString());
      emit(state.copyWith(changeStatusTrip: RequestState.error));
    }
  }

  /// refactor
  updateDeviceToken({userId, token}) async {
    emit(state.copyWith(updateDeviceTokenState: RequestState.loading));
    // var headers = {'Authorization': currentUser.token!};
    var request = http.MultipartRequest(
        'POST', Uri.parse(ApiConstants.updateDeviceTokenPath));
    request.fields.addAll({'userId': currentUser.id!, 'token': token});
    // request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print("updateDeviceToken = : -" + response.statusCode.toString());
    if (response.statusCode == 200) {
      emit(state.copyWith(updateDeviceTokenState: RequestState.loaded));
    } else {
      // print("updateDeviceToken = : -" + response.reasonPhrase.toString());
      emit(state.copyWith(updateDeviceTokenState: RequestState.error));
    }
  }

  changeStatusHome(int status) {
    print(status.toString() + "status home");
    emit(state.copyWith(statues: status));
  }

  /// git history trips
  getHistoriesTrips() async {
    emit(state.copyWith(getHistoriesState: RequestState.loading));
    var request =
        http.MultipartRequest('GET', Uri.parse(ApiConstants.getHistoriesPath));
    request.fields.addAll({'userId': currentUser.id!});

    http.StreamedResponse response = await request.send();
    print(response.statusCode.toString() + " =====> getHistories ");
    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonDataString);
      ResponseHistory responseHistory = ResponseHistory.fromJson(jsonData);
      emit(state.copyWith(
          getHistoriesState: RequestState.loaded, histories: responseHistory));
    } else {
      print(response.reasonPhrase);
      emit(state.copyWith(getHistoriesState: RequestState.error));
    }
  }

// add new address
  addNewAddress(AddressResponse addressResponse) async {
    emit(state.copyWith(addNewAddressState: RequestState.loading));
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiConstants.addNewAddress));
    request.fields.addAll({
      'UserId': addressResponse.userId!,
      'Label': addressResponse.label!,
      'Lat': addressResponse.lat.toString(),
      'Lang': addressResponse.lang.toString(),
    });

    http.StreamedResponse response = await request.send();
    print("add new address ====>  " + response.statusCode.toString());
    if (response.statusCode == 200) {
      emit(state.copyWith(addNewAddressState: RequestState.loaded));
      // homeTrip();
    } else {
      print(response.reasonPhrase);
      emit(state.copyWith(addNewAddressState: RequestState.error));
    }
  }

//** external trip  */
  setCityPoint(City city, String type) {
    if (type == "start") {
      emit(state.copyWith(startCity: city));
    } else {
      emit(state.copyWith(endCity: city));
    }
    print(city.name);
  }

  List<City> filteredList = [];
  searchCity(String search) {
    filteredList = [];

    emit(state.copyWith(searchCity: RequestState.loading));
    filteredList = cities
        .where((element) => AppModel.lang == "ar"
            ? element.name!.toLowerCase().contains(search.trim().toLowerCase())
            : element.name_eng!
                .toLowerCase()
                .contains(search.trim().toLowerCase()))
        .toList();
    emit(state.copyWith(searchCity: RequestState.loaded));
  }

  setTimeTrip(String value, int type) async {
    emit(state.copyWith(dateTrip: value));
  }

  //** get externalTrips */
  Future getExternalTrips({date, startCity, endCity}) async {
    emit(state.copyWith(getExternalTripsState: RequestState.loading));
    var request = http.MultipartRequest('GET',
        Uri.parse('${ApiConstants.baseUrl}/extrips/search-external-trip'));
    request.fields
        .addAll({'startCity': startCity, 'endCity': endCity, 'date': date});

    http.StreamedResponse response = await request.send();
    print(response.statusCode.toString() + " =======> getExternalTrips");
    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonDataString);

      emit(state.copyWith(
          getExternalTripsState: RequestState.loaded,
          externalTrips: List<ExternalTrip>.from(
              (jsonData as List).map((e) => ExternalTrip.fromJson(e)))));
    } else {
      emit(state.copyWith(getExternalTripsState: RequestState.error));
    }
  }

//** details external trip */
  getExternalTripDetails({groupId}) async {
    emit(state.copyWith(getGroupDetailsState: RequestState.loading));
    var request = http.MultipartRequest(
        'GET',
        Uri.parse(
            ApiConstants.baseUrl + "/extrips/get-external-trip-Details-user"));

    request.fields
        .addAll({'tripId': groupId.toString(), "userId": currentUser.id!});
    http.StreamedResponse response = await request.send();

    print(response.statusCode.toString() + " ====== > getGroupDetails");
    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonDataString);

      emit(state.copyWith(
          getGroupDetailsState: RequestState.loaded,
          groupDetails: ExternalDetails.fromJson(jsonData)));
    } else {
      emit(state.copyWith(getGroupDetailsState: RequestState.error));
    }
  }

// ** booking ===================================================  booking

//** add booking */
  Future addBooking({driverId, externalTripId, context, type = 0}) async {
    emit(state.copyWith(addBookingState: RequestState.loading));
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiConstants.baseUrl}/Bookings/add-booking'));
    request.fields.addAll({
      'userId': currentUser.id!,
      'driverId': driverId.toString(),
      'externalTripId': externalTripId.toString()
    });

    http.StreamedResponse response = await request.send();
    print("add booking =======> " + response.statusCode.toString());
    if (response.statusCode == 200) {
      pushPage(context: context, page: BookingScreen());
      emit(state.copyWith(addBookingState: RequestState.loaded));

      getExternalTripDetails(groupId: externalTripId);
    } else {
      emit(state.copyWith(addBookingState: RequestState.error));
    }
  }

// ** getMyBooking

  Future getMyBookings() async {
    emit(state.copyWith(getBookingsState: RequestState.loading));
    var request = http.MultipartRequest('GET',
        Uri.parse(ApiConstants.baseUrl + "/Bookings/get-Bookings-by-userId"));

    request.fields.addAll({"userId": currentUser.id!});
    http.StreamedResponse response = await request.send();

    print(response.statusCode.toString() + " ====== > getGroupDetails");
    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonDataString);

      emit(state.copyWith(
          getBookingsState: RequestState.loaded,
          responseBookings: List<BookingResponse>.from(
              (jsonData as List).map((e) => BookingResponse.fromJson(e)))));
    } else {
      emit(state.copyWith(getBookingsState: RequestState.error));
    }
  }

//** accept external trip */
  Future acceptExternalTrip({bookingId, status, tripId}) async {
    emit(state.copyWith(acceptExternalTrip: RequestState.loading));
    var request = http.MultipartRequest('POST',
        Uri.parse('${ApiConstants.baseUrl}/Bookings/change-status-booking'));
    request.fields.addAll({
      'bookingId': bookingId.toString(),
      'status': status.toString(),
      'type': "0",
    });

    http.StreamedResponse response = await request.send();
    print(response.statusCode.toString() + " ========> acceptExternalTrip");
    if (response.statusCode == 200) {
      emit(state.copyWith(acceptExternalTrip: RequestState.loaded));
      getExternalTripDetails(groupId: tripId);
      getMyBookings();
    } else {
      emit(state.copyWith(acceptExternalTrip: RequestState.error));
    }
  }

  // add group
  addGroup({startCity, endCity, context}) async {
    emit(state.copyWith(addTripState: RequestState.loading));
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiConstants.addGroupPath));
    request.fields.addAll({
      'userId': currentUser.id!,
      'startlocation': startCity,
      'endlocation': endCity
    });

    http.StreamedResponse response = await request.send();
    print(response.statusCode.toString() + "====== > addGroup");
    if (response.statusCode == 200) {
      pushPage(context: context, page: WaitingTripScreen());
      showTopMessage(
          context: context,
          customBar: CustomSnackBar.error(
              backgroundColor: Colors.green,
              message: Strings.sendOrder.tr(),
              textStyle: TextStyle(
                  fontFamily: "font", fontSize: 16, color: Colors.white)));
      emit(state.copyWith(addTripState: RequestState.loaded));
    } else {
      emit(state.copyWith(addTripState: RequestState.loaded));
    }
  }

// get group

  getGroups({userId}) async {
    emit(state.copyWith(getGroupsState: RequestState.loading));
    var request = http.MultipartRequest(
        'GET', Uri.parse('${ApiConstants.getGroupsPath}userId=$userId'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonDataString);

      emit(state.copyWith(
          getGroupsState: RequestState.loaded,
          groupsLocation: List<GroupLocation>.from(
              (jsonData as List).map((e) => GroupLocation.fromJson(e)))));
    } else {
      emit(state.copyWith(getGroupsState: RequestState.error));
    }
  }

//todo : add rate
  addRateDriver(
      {driverId, comment, tripId, stare, context, status, driverUserId,rated}) async {
        if(rated){
  emit(state.copyWith(addRateState: RequestState.loading));
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiConstants.addRatePath));
    request.fields.addAll({
      'DriverId': driverId.toString(),
      'UserId': currentUser.id!,
      'Comment': 'thanks',
      'Stare': state.toString(),
      'tripId': tripId.toString()
    });

    http.StreamedResponse response = await request.send();
    print(response.statusCode.toString() + " =======> addRateDriver");
    if (response.statusCode == 200) {
      pop(context);
      emit(state.copyWith(addRateState: RequestState.loaded));
      TripCubit.get(context).changeStatusTrip(
          tripId: tripId, status: status + 1, userId: driverUserId);
    } else {
      emit(state.copyWith(addRateState: RequestState.error));
    }
        }else {
          TripCubit.get(context).changeStatusTrip(
          tripId: tripId, status: status + 1, userId: driverUserId);
        }
  
  }

// ** payment trip

  Future paymentTrip({tripId, payment, context, endPoint}) async {
    emit(state.copyWith(paymentTripState: RequestState.loading));
    var request = http.MultipartRequest('POST', Uri.parse(endPoint));
    request.fields
        .addAll({'tripId': tripId.toString(), 'payment': payment.toString(),'userId':currentUser.id!});

    http.StreamedResponse response = await request.send();

    print("paymentTrip ======= > " + response.statusCode.toString());
    if (response.statusCode == 200) {
      // pop(context);
      emit(state.copyWith(paymentTripState: RequestState.loaded));
    } else {
      emit(state.copyWith(paymentTripState: RequestState.error));
    }
  }
}
