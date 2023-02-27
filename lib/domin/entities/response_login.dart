import 'package:equatable/equatable.dart';

class ResponseLogin extends Equatable {
  final int status;

  final String code;


  ResponseLogin(
      {required this.status,
        required this.code,
      });

  @override
  List<Object> get props => [
    status,
    code,

  ];
}
