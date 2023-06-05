class ExternalTrip {
 final int id;
final  int driverId;
final  String name;
final  double price;
final  String userId;
final  String startCity;
final  String endCity;
final  double startPointLat;
final  double startPointLng;
final  double endPointLat;
final  double endPointLng;
final  int sets;
final  int status;
final  String startingAt;
final  String endTime;

final  String createdAt;


  ExternalTrip(
      {required this.id,
      required this.driverId,
      required this.name,
      required this.price,
      required this.userId,
      required this.startCity,
      required this.endCity,
      required this.startPointLat,
      required this.startPointLng,
      required this.endPointLat,
      required this.endPointLng,
      required this.sets,
      required this.status,
      required this.startingAt,
      required this.endTime,
      required this.createdAt});

 factory ExternalTrip.fromJson(Map<String, dynamic> json) =>ExternalTrip(
  id : json['id'],
    driverId : json['driverId'],
    name : json['name'],
     endTime : json['endTime'],
    price : json['price'].toDouble(),
    userId : json['userId']??"",
    startCity : json['startCity'],
    endCity : json['endCity'],
    startPointLat : json['startPointLat'],
    startPointLng : json['startPointLng'],
    endPointLat : json['endPointLat'],
    endPointLng : json['endPointLng'],
    sets : json['sets'],
    status : json['status'],
    startingAt : json['startingAt'],
    createdAt : json['createdAt'],
 );

  
}
