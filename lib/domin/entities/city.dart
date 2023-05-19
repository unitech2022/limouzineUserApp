class City {
  int? id;
  String? name;
  double? lat;
  double? lng;
  int? countyId;
  String? status;
  String? createdAt;
  City({this.id, this.name, this.countyId, this.status, this.createdAt});
  City.fromJson(Map<String, dynamic> json) {
    id = json['city_id'];
    name = json['name_ar'];
    lat = json['center'][0];
    lng = json['center'][1];
    countyId = 1;
    status = json['status'];
    createdAt = json['createdAt'];
  }

}