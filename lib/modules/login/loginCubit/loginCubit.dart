// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parent_app/models/userModel/userModel.dart';
import 'package:parent_app/modules/login/loginCubit/loginStates.dart';
import 'package:parent_app/network/endpoints.dart';
import 'package:parent_app/network/local/cache_Helper.dart';
import 'package:parent_app/network/remote/dio_helper.dart';
import 'package:parent_app/shared/appCubit/app_cubit.dart';
import 'package:parent_app/shared/const.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  //------------------ login variables -------------------//
  var nationalIdController = TextEditingController();
  var passwordController = TextEditingController();
  bool isPass = true;

  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  bool validatePassword(String pass) {
    String _password = pass.trim();
    if (pass_valid.hasMatch(_password)) {
      return true;
    } else {
      return false;
    }
  }

//--------------------- Login change password visibility----------------------//
  IconData suffix = Icons.visibility;
  void changePasswordVisibility() {
    isPass = !isPass;
    isPass ? suffix = Icons.visibility : suffix = Icons.visibility_off;
    emit(LoginPasswordShown());
  }

//------------------------user login function ---------------------------//
  UserModel? loginModel;
  void userLogin(
      {required String nationalId,
      required String password,
      required var context}) {
    emit(LoginLoadingState());
    DioHelper.postDataWithoutToken(url: loginUrl, data: {
      'national_id': nationalId,
      'pass': password,
    }).then((value) {
      loginModel = UserModel.fromJson(value.data);
      // print(value.data);
      CacheHelper.saveData(key: 'token', value: loginModel?.success?.token);
      token = loginModel?.success?.token;
      AppCubit.get(context).getUserData();
      emit(LoginSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState());
    });
  }
}
