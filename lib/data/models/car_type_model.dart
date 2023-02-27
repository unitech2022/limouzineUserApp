import 'package:taxi/domin/entities/car_type.dart';

class CarTypeModel extends CartType {
  CarTypeModel(
      {required super.id,
      required super.name,
      required super.image,
      required super.price,
      required super.createdAt,
      required super.sets});

  factory CarTypeModel.fromJson(Map<String, dynamic> json) => CarTypeModel(
      id: json["id"],
      name: json["name"],
      image: json["image"],
      price: json["price"].toDouble(),
      createdAt: json["createdAt"],
      sets: json["sets"]);
}
