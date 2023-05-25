class City {
  int? id;
  String? name;
  String? name_eng;
  double? lat;
  double? lng;
  int? countyId;
  String? status;
  String? createdAt;
  City({this.id, this.name, this.countyId, this.status, this.createdAt,this.name_eng});
  City.fromJson(Map<String, dynamic> json) {
    id = json['city_id'];
    name = json['name_ar'];
    name_eng = json['name_en'];
    lat = json['center'][0];
    lng = json['center'][1];
    countyId = 1;
    status = json['status'];
    createdAt = json['createdAt'];
  }

}