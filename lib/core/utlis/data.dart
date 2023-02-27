import 'package:taxi/core/utlis/strings.dart';

List<TypeTrip> typesTrip = [
  TypeTrip(id: 1, title: Strings.internal, desc: Strings.betweenRegions,icon: "assets/icons/city.svg"),
  TypeTrip(id: 2, title: Strings.externalString, desc: Strings.betweenCities,icon: "assets/icons/external.svg"),
  // TypeTrip(id: 3, title: Strings.theSchool, desc: Strings.returnGo,icon: "assets/icons/school.svg"),
];


List<TypeTrip> addresses = [
  TypeTrip(id: 1, title: "شغلي", desc: "الرياض شارع ٤",icon: "assets/icons/work.svg"),
  TypeTrip(id: 2, title: "بيت امي", desc: "الشرقية ٧٧",icon: "assets/icons/home.svg"),
  TypeTrip(id: 3, title: "عمتي حنان", desc: "الشرقية ٧٧",icon: "assets/icons/school.svg"),
];

class TypeTrip {
  final int id;
  final String title;
  final String desc;
  final String icon;


  TypeTrip({required this.id, required this.title, required this.desc ,required this.icon});
}


