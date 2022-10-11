import 'package:parent_app/models/absence/absence_model.dart';
import 'package:parent_app/models/contact/contact_model.dart';
import 'package:parent_app/models/degrees/degrees_model.dart';
import 'package:parent_app/models/home/home_model.dart';
import 'package:parent_app/models/rate/rate_model.dart';
import 'package:parent_app/models/reset_password/reset_password.dart';
import 'package:parent_app/models/school/school_model.dart';
import 'package:parent_app/models/send_email/send_email.dart';
import 'package:parent_app/models/table/table_model.dart';
import 'package:parent_app/models/update_profile/update_profile_model.dart';
import 'package:parent_app/models/userModel/userModel.dart';
import 'package:parent_app/models/user_rates_model/user_rates_model.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeLanguageState extends AppStates {}

class ChangeNavButtomNavState extends AppStates {}

class ChangeCarousalIndexState extends AppStates {}

class AppChangeThemState extends AppStates {}

//get user data states
class AppGetUserDataSuccessState extends AppStates {}

class PasswordShownState extends AppStates {}

class PasswordShownStatee extends AppStates {}

class AppGetUserDataErrorState extends AppStates {}

class AppGetUserDataLoadingState extends AppStates {}

//update user data states
class AppUpdateUserDataSuccessState extends AppStates {
  final UserModel? model;

  AppUpdateUserDataSuccessState(this.model);
}

class AppUpdateUserDataErrorState extends AppStates {}

class AppUpdateUserDataLoadingState extends AppStates {}

// app logout states
class AppLogOutSuccessState extends AppStates {}

class AppLogOutErrorState extends AppStates {}

//send Email states
class AppSendEmailSuccessState extends AppStates {
  final SendEmailModel? model;

  AppSendEmailSuccessState(this.model);
}

class AppSendEmailErrorState extends AppStates {}

class AppSendEmailLoadingState extends AppStates {}

//send make rate states
class AppMakeRateSuccessState extends AppStates {
  final RateModel? model;

  AppMakeRateSuccessState(this.model);
}

class AppMakeRateErrorState extends AppStates {}

class AppMakeRateLoadingState extends AppStates {}

//get user rate
//get food advices states
class AppGetUserRateSuccessState extends AppStates {
  final UserRatesModel? model;

  AppGetUserRateSuccessState(this.model);
}

class AppGetUserRateErrorState extends AppStates {}

class AppGetUserRateLoadingState extends AppStates {}

//reset Password states
class AppRestPasswordSuccessState extends AppStates {
  final ResetPasswordModel? model;

  AppRestPasswordSuccessState(this.model);
}

class AppRestPasswordErrorState extends AppStates {}

class AppRestPasswordLoadingState extends AppStates {}

//change password states
class AppChangePasswordSuccessState extends AppStates {
  final ResetPasswordModel? model;

  AppChangePasswordSuccessState(this.model);
}

class AppChangePasswordErrorState extends AppStates {}

class AppChangePasswordLoadingState extends AppStates {}

//get packages states

//make contact states
class AppMakeContactSuccessState extends AppStates {
  final ContactModel? model;

  AppMakeContactSuccessState(this.model);
}

class AppMakeContactErrorState extends AppStates {}

class AppMakeContactLoadingState extends AppStates {}

//update profile states
class AppUpdateProfileSuccessState extends AppStates {
  final UpdateProfileModel model;
  AppUpdateProfileSuccessState(this.model);
}

class AppUpdateProfileErrorState extends AppStates {}

class AppUpdateProfileLoadingState extends AppStates {}

//pic image states

class AppPickImageSuccessState extends AppStates {}

class AppPickImageErrorState extends AppStates {}

class AppRemovePickImageState extends AppStates {}

//---------------- get student absence -------------------------//
class AppGetStudentAbsenceSuccessState extends AppStates {
  final AbsenceModel? model;

  AppGetStudentAbsenceSuccessState(this.model);
}

class AppGetStudentAbsenceErrorState extends AppStates {}

class AppGetStudentAbsenceLoadingState extends AppStates {}

//---------------- get student table -------------------------//
class AppGetStudentTableSuccessState extends AppStates {
  final TableModel? model;

  AppGetStudentTableSuccessState(this.model);
}

class AppGetStudentTableErrorState extends AppStates {}

class AppGetStudentTableLoadingState extends AppStates {}

//---------------- get student table -------------------------//
class AppGetStudentDegreesSuccessState extends AppStates {
  final DegreesModel? model;

  AppGetStudentDegreesSuccessState(this.model);
}

class AppGetStudentDegreesErrorState extends AppStates {}

class AppGetStudentDegreesLoadingState extends AppStates {}

//---------------- get home data -------------------------//
class AppGetHomeDataSuccessState extends AppStates {
  final HomeModel? model;

  AppGetHomeDataSuccessState(this.model);
}

class AppGetHomeDataErrorState extends AppStates {}

class AppGetHomeDataLoadingState extends AppStates {}

//---------------- get school data -------------------------//
class AppGetSchoolDataSuccessState extends AppStates {
  final SchoolModel? model;

  AppGetSchoolDataSuccessState(this.model);
}

class AppGetSchoolDataErrorState extends AppStates {}

class AppGetSchoolDataLoadingState extends AppStates {}
