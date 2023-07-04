part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final RequestState? loginStet;
  final RequestState? checkUserStet;
  final RequestState? signUpStet;
  final String? loginMessage;
  final String? checkUserMessage;
  final String? signUpMessage;
  final User? user;
  final ResponseLogin? responseLogin;
  final ResponseSignUp? responseSignUp;
  final RequestState? imageStet;
  final String image;
  final String? errorImageMessage;
  // get user
  final RequestState? getUserState;
  final RequestState? updateUserState;
  final UserDetail? getUserDetails;

  final RequestState? getWalletsState;
  final WalletResponse? walletResponse;

  AuthState(
      {this.loginStet,
      this.checkUserStet,
      this.signUpStet,
      this.imageStet,
      this.image = "",
      this.errorImageMessage,
      this.user,
      this.checkUserMessage,
      this.responseLogin,
      this.responseSignUp,
      this.loginMessage,
      this.signUpMessage,
      this.getUserDetails,
      this.getUserState,
      this.updateUserState,
        this.getWalletsState,
      this.walletResponse
      });

  AuthState copyWith(
          {final RequestState? imageStet,
          final String? image,
          final String? errorImageMessage,
          final RequestState? loginStet,
          final RequestState? checkUserStet,
          final RequestState? signUpStet,
          final String? loginMessage,
          final String? checkUserMessage,
          final String? signUpMessage,
          final RequestState? updateUserState,
          final User? user,
          final RequestState? getUserState,
          final UserDetail? getUserDetails,
          final ResponseLogin? responseLogin,
          final ResponseSignUp? responseSignUp,
            final RequestState? getWalletsState,
  final WalletResponse? walletResponse


          }) =>
      AuthState(
          user: user ?? this.user,
          responseLogin: responseLogin ?? this.responseLogin,
          checkUserStet: checkUserStet ?? this.checkUserStet,
          responseSignUp: responseSignUp ?? this.responseSignUp,
          loginStet: loginStet ?? this.loginStet,
          checkUserMessage: checkUserMessage ?? this.checkUserMessage,
          loginMessage: loginMessage ?? this.loginMessage,
          signUpMessage: signUpMessage ?? this.signUpMessage,
          signUpStet: signUpStet ?? this.signUpStet,
          imageStet: imageStet ?? this.imageStet,
          updateUserState: updateUserState ?? this.updateUserState,
          image: image ?? this.image,
          errorImageMessage: errorImageMessage ?? this.errorImageMessage,
          getUserDetails: getUserDetails ?? this.getUserDetails,
          getUserState: getUserState ?? this.getUserState,
           getWalletsState: getWalletsState ?? this.getWalletsState,
          walletResponse: walletResponse ?? this.walletResponse
          
          );

  @override
  List<Object?> get props => [
        loginStet,
        checkUserStet,
        signUpStet,
        user,
        responseLogin,
        loginMessage,
        signUpMessage,
        checkUserMessage,
        imageStet,
        image,
        errorImageMessage,
        responseSignUp,
        getUserDetails,
        getUserState,
        updateUserState,
        getWalletsState,
        walletResponse
      ];
}
