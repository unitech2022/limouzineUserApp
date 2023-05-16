import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi/core/helpers/functions.dart';
import 'package:taxi/core/helpers/helper_functions.dart';
import 'package:taxi/core/routers/routers.dart';
import 'package:taxi/core/utlis/api_constatns.dart';
import 'package:taxi/core/utlis/app_model.dart';
import 'package:taxi/persentaion/ui/home_screen/tabs_screens/start_trip_screen/start_trip_screen.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState());
  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);
  changeLang(lang, context) async {
    AppModel.lang = lang;
    await saveData(ApiConstants.langKey, lang);
    // EasyLocalization.of(context)?.setLocale(Locale(lang, ''));

    Navigator.pushNamed(context, welcome);
    emit(AppState(changLang: lang));
  }

  getLang() {
    if (AppModel.lang == "") {
      emit(AppState(changLang: "ar"));
    } else {
      emit(AppState(changLang: AppModel.lang));
    }
  }

  int selectedRadio = 0;

  changeValue(int val) {
    selectedRadio = val;
// print(selectedRadio);
    emit(AppState(selectedRadio: selectedRadio));
  }

  getPage(context) {
    Future.delayed(const Duration(seconds: 5), () {
      print(AppModel.lang);
      firebaseCloudMessaging_Listeners();
      if (AppModel.lang == "") {
        Navigator.pushReplacementNamed(context, lang);
      } else {
        if (currentUser.token != null) {
          pushPage(context: context, page: StartTripScreen());
        } else {
          Navigator.pushReplacementNamed(context, welcome);
        }
      }
      emit(AppState(page: "done"));
    });
  }


}
