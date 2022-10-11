// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'dart:io';
import 'dart:math';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parent_app/models/absence/absence_model.dart';
import 'package:parent_app/models/contact/contact_model.dart';
import 'package:parent_app/models/degrees/degrees_model.dart';
import 'package:parent_app/models/home/home_model.dart';
import 'package:parent_app/models/profile/profile_model.dart';
import 'package:parent_app/models/rate/rate_model.dart';
import 'package:parent_app/models/reset_password/reset_password.dart';
import 'package:parent_app/models/school/school_model.dart';
import 'package:parent_app/models/send_email/send_email.dart';
import 'package:parent_app/models/table/table_model.dart';
import 'package:parent_app/models/update_profile/update_profile_model.dart';
import 'package:parent_app/models/userModel/userModel.dart';
import 'package:parent_app/models/user_rates_model/user_rates_model.dart';
import 'package:parent_app/modules/Schedule/Schedule_screen.dart';
import 'package:parent_app/modules/children/children_screen.dart';
import 'package:parent_app/modules/children_degree/children_degrees_screen.dart';
import 'package:parent_app/modules/children_table/children_table_screen.dart';
import 'package:parent_app/modules/degrees/degrees_screen.dart';
import 'package:parent_app/modules/home/home_screen.dart';
import 'package:parent_app/modules/login/login.dart';
import 'package:parent_app/modules/profile/profile_screen.dart';
import 'package:parent_app/network/endpoints.dart';
import 'package:parent_app/network/local/cache_Helper.dart';
import 'package:parent_app/network/remote/dio_helper.dart';
import 'package:parent_app/shared/colors.dart';
import 'package:parent_app/shared/components/components.dart';
import 'package:parent_app/shared/const.dart';

import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  bool isFirst = true;
  int currentIndex = 2;
  int carousalIndex = 0;

  var formKeyLogin = GlobalKey<FormState>();
  var formKeyRegister = GlobalKey<FormState>();
  var controller = PageController(initialPage: 2);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> scaffoldSchoolKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> scaffoldScheduleKey =
      GlobalKey<ScaffoldState>();
  List<Color> color = [
    Colors.cyan,
    Colors.amber,
    Colors.green,
    primaryColor,
    Colors.red,
    Colors.blue
  ];
  final random = Random();

// get random color
  Color getRandomColor() {
    Color randomColor = color[random.nextInt(color.length)];
    return randomColor;
  }

  //buttom nav bar
  List<Widget> buttonWidget(index) => [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.task_square,
              color: index == 0 ? Colors.white : Colors.white,
            ),
            Text(
              'الدرجات',
              style: TextStyle(
                fontSize: 12,
                color: index == 0 ? Colors.white : Colors.white,
              ),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.table_view_outlined,
              color: index == 1 ? Colors.white : Colors.white,
            ),
            Text(
              'الجدول',
              style: TextStyle(
                fontSize: 12,
                color: index == 1 ? Colors.white : Colors.white,
              ),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.home_14,
              color: index == 2 ? Colors.white : Colors.white,
            ),
            Text(
              'الرئيسية',
              style: TextStyle(
                fontSize: 12,
                color: index == 2 ? Colors.white : Colors.white,
              ),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notes_rounded,
              color: index == 3 ? Colors.white : Colors.white,
            ),
            Text(
              'الغياب',
              style: TextStyle(
                fontSize: 12,
                color: index == 3 ? Colors.white : Colors.white,
              ),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.user,
              color: index == 4 ? Colors.white : Colors.white,
            ),
            Text(
              'البروفايل',
              style: TextStyle(
                fontSize: 12,
                color: index == 4 ? Colors.white : Colors.white,
              ),
            )
          ],
        ),
      ];

  //Slider Controller
  CarouselController carouselController = CarouselController();
  //titles of schedule screen
  List<Text> titles = [
    const Text(
      'الأحد',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
    ),
    const Text(
      'الإثنين',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
    ),
    const Text(
      'الثلاثاء',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
    ),
    const Text(
      'الأربعاء',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
    ),
    const Text(
      'الخميس',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
    ),
  ];
  //buttom nav widgets
  List<Widget> appScreens = [
    const ChildrenDegreeScreen(),
    const ChildrenTableScreen(),
    const HomeScreen(),
    const ChildrenScreen(),
    const ProfileScreen(),
  ];
//change
  void changeAppNav(index) {
    // if (index == 0)
    //   getStudentDegreesData();
    // else if (index == 1) {
    //   getStudentTableData(
    //       day: DateFormat('EEEE').format(DateTime.now()) == 'Sunday'
    //           ? 1
    //           : DateFormat('EEEE').format(DateTime.now()) == 'Monday'
    //               ? 2
    //               : DateFormat('EEEE').format(DateTime.now()) == 'Tuesday'
    //                   ? 3
    //                   : DateFormat('EEEE').format(DateTime.now()) == 'Wednesday'
    //                       ? 4
    //                       : 5);
    // } else if (index == 3) getStudentAbsenceData();
    currentIndex = index;
    emit(ChangeNavButtomNavState());
  }

  void changeCarousalIndex(index) {
    carousalIndex = index;
    emit(ChangeCarousalIndexState());
  }

  bool isPass = true;
  IconData suffix = Icons.visibility;
  void changePasswordVisibility() {
    isPass = !isPass;
    isPass ? suffix = Icons.visibility : suffix = Icons.visibility_off;
    emit(PasswordShownState());
  }

  bool isPasss = true;
  IconData suffixx = Icons.visibility;
  void changePasswordVisibilityy() {
    isPasss = !isPasss;
    isPasss ? suffixx = Icons.visibility : suffixx = Icons.visibility_off;
    emit(PasswordShownStatee());
  }

  var isDark = false;
  void changeAppTheme({bool? fromCache}) {
    if (fromCache != null) {
      isDark = fromCache;
      emit(AppChangeThemState());
    } else {
      isDark = !isDark;
      CacheHelper.setBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeThemState());
      });
    }
  }

//get user

  ProfileModel? profile;
  void getUserData() {
    emit(AppGetUserDataLoadingState());
    DioHelper.postData(url: profileUrl, token: token, data: {}).then((value) {
      profile = ProfileModel.fromJson(value.data);
      emit(AppGetUserDataSuccessState());
    }).catchError((error) {
      emit(AppGetUserDataErrorState());
      print(error.toString());
    });
  }

  UserModel? user;
  void updateUserData({
    required String email,
    required String phone,
    required String name,
    required String jobTitle,
    required int departmentId,
  }) {
    emit(AppUpdateUserDataLoadingState());
    DioHelper.putData(url: '', token: token, data: {
      'email': email,
      'mobile_number': phone,
      'name': name,
      'department_id': departmentId,
      'job_title': jobTitle,
    }).then((value) {
      user = UserModel.fromJson(value.data);
      getUserData();

      emit(AppUpdateUserDataSuccessState(user));
    }).catchError((error) {
      emit(AppUpdateUserDataErrorState());
      print(error.toString());
    });
  }

  void logOut(context) {
    CacheHelper.removeData(key: 'token').then((value) {
      if (value) {
        profile = null;
        navigateAndFinish(context, const LoginScreen());
        emit(AppLogOutSuccessState());
      }
    });
    token = null;
  }

  SendEmailModel? sendEmailModel;
  void sendEmail({required String email}) {
    emit(AppSendEmailLoadingState());
    DioHelper.postDataWithoutToken(
      url: sendEmailUrl,
      data: {'email': email},
    ).then((value) {
      sendEmailModel = SendEmailModel.fromJson(value.data);
      emit(AppSendEmailSuccessState(sendEmailModel));
    }).catchError((error) {
      print(error.toString());
      emit(AppSendEmailErrorState());
    });
  }

  void resetPassword({
    required String oldPassword,
    required String password,
    required String confirmPassword,
  }) {
    emit(AppRestPasswordLoadingState());
    DioHelper.postData(
            url: changePasswordUrl,
            data: {
              'old_password': oldPassword,
              'new_password': password,
              'c_password': confirmPassword,
            },
            token: token)
        .then((value) {
      resetPasswordModel = ResetPasswordModel.fromJson(value.data);
      emit(AppRestPasswordSuccessState(resetPasswordModel));
    }).catchError((error) {
      print(error.toString());
      emit(AppRestPasswordErrorState());
    });
  }

  //change password
  ResetPasswordModel? resetPasswordModel;
  void updatePasswordData({
    required String oldPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) {
    emit(AppChangePasswordLoadingState());
    DioHelper.postData(url: changePasswordUrl, token: token, data: {
      'old_password': oldPassword,
      'new_password': newPassword,
      'c_password': confirmNewPassword,
    }).then((value) {
      resetPasswordModel = ResetPasswordModel.fromJson(value.data);

      emit(AppChangePasswordSuccessState(resetPasswordModel));
    }).catchError((error) {
      emit(AppChangePasswordErrorState());
      print(error.toString());
    });
  }

//make rate
  RateModel? rateModel;
  void makeRate(
      {required int id, required double rate, String? note, int? appRate}) {
    emit(AppMakeRateLoadingState());
    DioHelper.postData(
            url: rateUrl,
            data: {
              "rate": rate,
              "rated_in_id": id,
              "rate_app": appRate ?? 1,
              "notes": note ?? ''
            },
            token: token)
        .then((value) {
      rateModel = RateModel.fromJson(value.data);
      emit(AppMakeRateSuccessState(rateModel));
    }).catchError((error) {
      print(error.toString());
      emit(AppMakeRateErrorState());
    });
  }

  //get user rate
  var noteController = TextEditingController();
  var rateData;
  bool isRated = false;
  UserRatesModel? userRatesModel;
  void getUserRateData({int? id}) {
    isRated = false;
    noteController.text = '';
    emit(AppGetUserRateLoadingState());
    DioHelper.getData(url: getRateUrl, token: token).then((value) {
      userRatesModel = UserRatesModel.fromJson(value.data);
      userRatesModel?.data?.forEach((element) {
        if (element.ratedInId == id) {
          isRated = true;
          rateData = element;
          noteController.text = element.notes ?? 'لايوجد تعليق';
        }
      });
      emit(AppGetUserRateSuccessState(userRatesModel));
    }).catchError((error) {
      emit(AppGetUserRateErrorState());
      print(error.toString());
    });
  }

  int myTrainingIndex = 0;

//make contact
  ContactModel? contactModel;
  void makeContact(
      {required String name,
      required String phone,
      required String email,
      required String message}) {
    emit(AppMakeContactLoadingState());
    DioHelper.postDataWithoutToken(url: contactUsUrl, data: {
      "name": name,
      "mobile": phone,
      "email": email,
      "message": message
    }).then((value) {
      contactModel = ContactModel.fromJson(value.data);
      emit(AppMakeContactSuccessState(contactModel));
    }).catchError((error) {
      print(error.toString());
      emit(AppMakeContactErrorState());
    });
  }

//-----------------------pic profile image------------------------//
  File? postImage;
  var picker = ImagePicker();
  Future<void> picProfileImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      postImage = File(pickerFile.path);
      emit(AppPickImageSuccessState());
    } else {
      print('No Image Selected');
      emit(AppPickImageErrorState());
    }
  }

//---------------------remove profile image ---------------------//
  void removeImage() {
    postImage = null;
    emit(AppRemovePickImageState());
  }

//----------------------- update profile  without image -----------------------//
  UpdateProfileModel? updateProfileModel;
  void updateProfileWithoutImage({
    required String email,
    required String phone,
    required String name,
    required int weight,
    required String illnesses,
    required String notes,
    required String sex,
    required int hight,
  }) {
    emit(AppUpdateProfileLoadingState());
    DioHelper.postData(
            url: updateProfileUrl,
            data: {
              'email': email,
              'mobile': phone,
              'name': name,
              'length': hight,
              'weight': weight,
              'illnesses': illnesses,
              'notes': notes,
              'sex': sex,
            },
            token: token)
        .then((value) {
      updateProfileModel = UpdateProfileModel.fromJson(value.data);
      getUserData();
      emit(AppUpdateProfileSuccessState(updateProfileModel!));
    }).catchError((error) {
      print(error.toString());
      emit(AppUpdateProfileErrorState());
    });
  }

//----------------------- update profile  with image -----------------------//
  void updateProfile({
    required String email,
    required String phone,
    required String name,
    required int weight,
    required String illnesses,
    required String notes,
    required String sex,
    required int hight,
  }) async {
    String? fileName = postImage?.path.split('/').last;
    FormData formData = FormData.fromMap({
      "profile_photo_path": await MultipartFile.fromFile(
        postImage?.path ?? '',
        filename: fileName,
        contentType: MediaType("image", "jpeg"), //important
      ),
      'email': email,
      'mobile': phone,
      'name': name,
      'length': hight,
      'weight': weight,
      'illnesses': illnesses,
      'notes': notes,
      'sex': sex,
    });
    emit(AppUpdateProfileLoadingState());
    Dio dio = Dio()..options.baseUrl = 'https://gym.masool.net/api/';
    dio
        .post(updateProfileUrl,
            data: formData,
            options: Options(headers: {
              'Authorization': 'Bearer ${token!}',
            }))
        .then((response) {
      updateProfileModel = UpdateProfileModel.fromJson(response.data);
      getUserData();
      emit(AppUpdateProfileSuccessState(updateProfileModel!));
    }).catchError((error) {
      print(error.toString());
      emit(AppUpdateProfileErrorState());
    });
  }

//-------------------------------register controllers ---------------------------//
  String? registerGender = 'A';
  var registerEmailController = TextEditingController();
  var registerHightController = TextEditingController();
  var registerIllController = TextEditingController();
  var registerDetailsController = TextEditingController();
  var registerNameController = TextEditingController();
  var registerNationalIdController = TextEditingController();
  var registerPasswordController = TextEditingController();
  var registerConfirmPasswordController = TextEditingController();

//----------------------------update profile controllers --------------------------//
  var updateEmailController = TextEditingController();
  var updateHightController = TextEditingController();
  var updateIllController = TextEditingController();
  var updateDetailsController = TextEditingController();
  var updateWightController = TextEditingController();
  var updateNameController = TextEditingController();
  var updatePhoneController = TextEditingController();
  var formKeyUpdate = GlobalKey<FormState>();
  String? gender;

//-------------------- get data used in profile ---------------------//
  void getData() {
    // updateDetailsController.text = profile?.data?.notes ?? '';
    // updateEmailController.text = profile?.data?.email ?? '';
    // updatePhoneController.text = profile?.data?.mobile ?? '';
    // updateHightController.text = profile?.data?.length.toString() ?? '';
    // updateWightController.text = profile?.data?.weight.toString() ?? '';
    // updateNameController.text = profile?.data?.name ?? '';
    // updateIllController.text = profile?.data?.illnesses ?? '';
    // gender = profile?.data?.sex;
  }

//----------------------- get student absence -----------------------//
  AbsenceModel? absenceModel;
  void getStudentAbsenceData() {
    emit(AppGetStudentAbsenceLoadingState());
    DioHelper.postData(url: absenceUrl, token: token, data: {}).then((value) {
      absenceModel = AbsenceModel.fromJson(value.data);
      emit(AppGetStudentAbsenceSuccessState(absenceModel));
    }).catchError((error) {
      emit(AppGetStudentAbsenceErrorState());
      print(error.toString());
    });
  }

  //----------------------- get student table -----------------------//
  TableModel? tableModel;
  void getStudentTableData({required int day}) {
    emit(AppGetStudentTableLoadingState());
    DioHelper.postData(
        url: tableUrl,
        token: token,
        data: {},
        query: {'day': day.toString()}).then((value) {
      tableModel = TableModel.fromJson(value.data);
      emit(AppGetStudentTableSuccessState(tableModel));
    }).catchError((error) {
      emit(AppGetStudentTableErrorState());
      print(error.toString());
    });
  }

  //----------------------- get student degrees -----------------------//
  DegreesModel? degreesModel;
  void getStudentDegreesData() {
    emit(AppGetStudentDegreesLoadingState());
    DioHelper.postData(
      url: degreesUrl,
      token: token,
      data: {},
    ).then((value) {
      degreesModel = DegreesModel.fromJson(value.data);
      emit(AppGetStudentDegreesSuccessState(degreesModel));
    }).catchError((error) {
      emit(AppGetStudentDegreesErrorState());
      print(error.toString());
    });
  }

  //----------------------- get school data -----------------------//
  SchoolModel? schoolModel;
  void getSchoolData() {
    emit(AppGetSchoolDataLoadingState());
    DioHelper.getData(
      url: schoolUrl,
      token: token,
    ).then((value) {
      schoolModel = SchoolModel.fromJson(value.data);
      emit(AppGetSchoolDataSuccessState(schoolModel));
    }).catchError((error) {
      emit(AppGetSchoolDataErrorState());
      print(error.toString());
    });
  }

//--------------------- get home data--------------------------------//
  HomeModel? homeModel;
  void getHomeData() {
    emit(AppGetHomeDataLoadingState());
    DioHelper.postData(
      url: homeUrl,
      token: token,
      data: {},
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      emit(AppGetHomeDataSuccessState(homeModel));
    }).catchError((error) {
      emit(AppGetHomeDataErrorState());
      print(error.toString());
    });
  }
}
