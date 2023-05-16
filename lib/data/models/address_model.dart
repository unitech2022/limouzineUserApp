class AddressResponse {
  int? id;
  String? userId;
  bool? defaultAddress;
  double? lat;
  double? lang;
  String? label;
  String? createdAt;

  AddressResponse(
      {this.id,
      this.userId,
      this.defaultAddress,
      this.lat,
      this.lang,
      this.label,
      this.createdAt});

   AddressResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    defaultAddress = json['default'];
    lat = json['lat'].toDouble();
    lang = json['lang'].toDouble();
    label = json['label'];
    createdAt = json['createdAt'];
  }
}
