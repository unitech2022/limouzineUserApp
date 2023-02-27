import 'package:equatable/equatable.dart';

class ResponseSignUp extends Equatable {
  final bool status;

  final String message;


  ResponseSignUp(
      {required this.status,
        required this.message,
      });

  @override
  List<Object> get props => [
    status,
    message,

  ];
}
