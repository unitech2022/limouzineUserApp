
import 'package:taxi/data/models/user_response.dart';
import 'package:taxi/data/models/wallet.dart';


class WalletResponse {
  final UserDetail user;
  final List<Wallet> wallets;
  WalletResponse({required this.user, required this.wallets});

  factory WalletResponse.fromJson(Map<String, dynamic> json) => WalletResponse(
      user: UserDetail.fromJson(json['user']),
      wallets: List<Wallet>.from(
          (json['wallets'] as List).map((e) => Wallet.fromJson(e))));
}
