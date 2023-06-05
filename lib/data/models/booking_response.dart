

import 'external_trip.dart';

class BookingResponse {
  ExternalTrip? trip;
  Booking? booking;

  BookingResponse({this.trip, this.booking});

  BookingResponse.fromJson(Map<String, dynamic> json) {
    trip = json['trip'] != null ? ExternalTrip.fromJson(json['trip']) : null;

     booking = json['booking'] != null ? Booking.fromJson(json['booking']) : null;
  
  }
}




class Booking {
  int? id;
  String? userId;
  int? driverId;
  int? externalTripId;
  int? status;
  String? createdAt;

  Booking(
      {this.id,
      this.userId,
      this.driverId,
      this.externalTripId,
      this.status,
      this.createdAt});

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    driverId = json['driverId'];
    externalTripId = json['externalTripId'];
    status = json['status'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['driverId'] = this.driverId;
    data['externalTripId'] = this.externalTripId;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
