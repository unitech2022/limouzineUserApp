import 'package:equatable/equatable.dart';

class CartType extends Equatable {
  final int id;
  final String name;
  final String image;
  final double price;
  final int sets;
  final String createdAt;

  CartType({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.createdAt,
    required this.sets
  });

  @override
  List<Object> get props => [id, name, image, price, sets, createdAt];

}

//  "id": 1,
//     "name": "مؤسيدس",
//     "image": "20230225T172522.jpeg",
//     "price": "3",
//     "sets": 0,
//     "createdAt": "2023-02-25T18:22:04.820335"