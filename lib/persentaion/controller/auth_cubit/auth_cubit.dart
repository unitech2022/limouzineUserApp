import 'dart:convert';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taxi/core/helpers/functions.dart';
import 'package:taxi/core/utlis/api_constatns.dart';
import 'package:taxi/core/utlis/app_model.dart';
import 'package:taxi/core/utlis/enums.dart';
import 'package:taxi/data/data_source/local_data/models/UserDetalsPref.dart';
import 'package:taxi/data/models/user_response.dart';
import 'package:taxi/domin/entities/response_login.dart';
import 'package:taxi/domin/entities/user.dart';
import 'package:taxi/domin/usese_cases/auth_uses_cases/check_user_name_usecase.dart';
import 'package:taxi/domin/usese_cases/auth_uses_cases/login_usecase.dart';
import 'package:taxi/persentaion/ui/home_screen/home_screen.dart';
import 'package:taxi/persentaion/ui/home_screen/tabs_screens/start_trip_screen/start_trip_screen.dart';
import 'package:taxi/persentaion/ui/otp_screen/otp_screen.dart';
import 'package:taxi/persentaion/ui/sign_up_screen/signup_screen.dart';
import '../../../domin/entities/response_signup.dart';
import '../../../domin/usese_cases/app_use_case/app_use_case.dart';
import '../../../domin/usese_cases/auth_uses_cases/signup_usecase.dart';
import 'package:http/http.dart' as http;

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  CheckUerNameUseCase checkUerNameUseCase;
  LoginUseCase loginUseCase;
  SignUpUseCase signUpUseCase;
  AppUseCase appUseCase;

  AuthCubit(this.checkUerNameUseCase, this.loginUseCase, this.signUpUseCase,
      this.appUseCase)
      : super(AuthState());
  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

  checkUser({userName, context}) async {
    emit(AuthState(checkUserStet: RequestState.loading));
    final result = await checkUerNameUseCase.execute(userName: userName);
    result.fold(
        (l) => emit(AuthState(
            checkUserStet: RequestState.error,
            checkUserMessage: l.message)), (r) {
      print(r.status);
      if (r.status == 0) {
        pushPage(context: context, page: SignUpScreen(userName));
      } else {
        pushPage(
            context: context,
            page: OtpScreen(
              phone: userName,
            ));
      }
      emit(AuthState(responseLogin: r, checkUserStet: RequestState.loaded));
    });
  }

  loginUser({userName, context}) async {
    emit(state.copyWith(loginStet: RequestState.loading));
    final result = await loginUseCase.execute(
        userName: userName, code: "0000", deviceToken: "fffffffff");
    result.fold(
        (l) => emit(state.copyWith(
            loginStet: RequestState.error,
            loginMessage: l.message)), (r) async {
      // print(r);

      token = "Bearer " + r.token;
      currentUser..profileImage = r.profileImage;
      currentUser..userName = r.userName;
      currentUser..id = r.id;
      currentUser..fullName = r.fullName;
      currentUser.deviceToken = r.deviceToken;

      print(currentUser);
      await saveToken();
      pushPage(context: context, page: StartTripScreen());

      emit(state.copyWith(user: r, loginStet: RequestState.loaded));
    });
  }

  signUpUser({user, context}) async {
    emit(state.copyWith(signUpStet: RequestState.loading));
    final result = await signUpUseCase.execute(user: user);
    result.fold(
        (l) => emit(state.copyWith(
            signUpStet: RequestState.error, loginMessage: l.message)), (r) {
      print(r);
      if (r.status) {
        pushPage(context: context, page: OtpScreen(phone: user.userName));
      } else {
        showSnakeBar(
          message: r.message,
          context: context,
        );
      }
      emit(state.copyWith(responseSignUp: r, signUpStet: RequestState.loaded));
    });
  }

  uploadImage() async {
    File _image;
    final picker = ImagePicker();

    var _pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50, // <- Reduce Image quality
        maxHeight: 500, // <- reduce the image size
        maxWidth: 500);

    if (_pickedFile != null) {
      _image = File(_pickedFile.path);
      ;

      emit(state.copyWith(imageStet: RequestState.loading));
      final result = await appUseCase.execute(file: _image);
      result.fold(
          (l) => emit(state.copyWith(
              imageStet: RequestState.error,
              errorImageMessage: l.message)), (r) {
        print(r);
        emit(state.copyWith(image: r, imageStet: RequestState.loaded));
      });
    }
  }

  /// refactor code
  UserDetail? userDetail;
  Future getUserDetails() async {
    emit(state.copyWith(getUserState: RequestState.loading));
    print(currentUser.token);
    var headers = {'Authorization': currentUser.token!};
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiConstants.getUserPath));
    request.fields.addAll({'userId': currentUser.id!});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response.statusCode.toString() + "getUserDetails");
    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      userDetail = UserDetail.fromJson(jsonData);
      currentUser.email = userDetail!.email;
      currentUser.fullName = userDetail!.fullName;
      currentUser.profileImage = userDetail!.profileImage;
      currentUser.deviceToken = userDetail!.deviceToken;
      emit(state.copyWith(
          getUserState: RequestState.loaded, getUserDetails: userDetail));
    } else {
      print(response.reasonPhrase);
      emit(state.copyWith(getUserState: RequestState.error));
    }
  }

 Future updateUser({fullName, email, image}) async {
    emit(state.copyWith(updateUserState: RequestState.loading));
    var headers = {'Authorization': currentUser.token!};

    var request =
        http.MultipartRequest('POST', Uri.parse(ApiConstants.updateUserPath));
    request.fields.addAll({
      'userId': currentUser.id!,
      'FullName': fullName,
      'Email': email,
      'image': image
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    print(response.statusCode.toString() + "updateUser");
    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      UserDetail userDetail = UserDetail.fromJson(jsonData);
      // currentUser = userDetail as UserDetailsPref;
      emit(state.copyWith(
          updateUserState: RequestState.loaded, getUserDetails: userDetail));
      getUserDetails();
    } else {
      print(response.reasonPhrase);
      emit(state.copyWith(updateUserState: RequestState.error));
    }
  }



}
