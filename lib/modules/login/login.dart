import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:parent_app/modules/Login_background/Login_background.dart';
import 'package:parent_app/modules/forget_password/forget_password.dart';
import 'package:parent_app/modules/layoutScreen/layout_screen.dart';
import 'package:parent_app/modules/login/loginCubit/loginCubit.dart';
import 'package:parent_app/modules/login/loginCubit/loginStates.dart';
import 'package:parent_app/network/local/cache_Helper.dart';
import 'package:parent_app/shared/appCubit/app_cubit.dart';
import 'package:parent_app/shared/components/components.dart';
import 'package:parent_app/shared/const.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.model?.result == true) {
              CacheHelper.saveData(
                      key: "token", value: state.model?.success?.token)
                  .then((value) {
                token = state.model?.success?.token;
                // AppCubit.get(context).getUserData();
                AppCubit.get(context).currentIndex = 2;
                // print('-----------------------$token --------------------');
                AppCubit.get(context).getStudentAbsenceData();
                AppCubit.get(context).getStudentDegreesData();
                AppCubit.get(context).getStudentTableData(
                    day: DateFormat('EEEE').format(DateTime.now()) == 'Sunday'
                        ? 1
                        : DateFormat('EEEE').format(DateTime.now()) == 'Monday'
                            ? 2
                            : DateFormat('EEEE').format(DateTime.now()) ==
                                    'Tuesday'
                                ? 3
                                : DateFormat('EEEE').format(DateTime.now()) ==
                                        'Wednesday'
                                    ? 4
                                    : 5);
                navigateAndFinish(context, LayoutScreen());

                showToast(
                    text: 'Login Successfully', state: ToastStates.success);
                // print(state.model?.data!.name);
              });
            } else {
              showToast(
                  text: state.model?.errorMessage, state: ToastStates.error);
            }
          }
        },
        builder: (context, state) {
          double screenHeight = MediaQuery.of(context).size.height;
          return Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            body: AnnotatedRegion<SystemUiOverlayStyle>(
              value: const SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.dark,
              ),
              child: Stack(
                children: [
                  const LoginBackground(
                    title: 'Login',
                    isRegister: false,
                    image: 'assets/images/login.png',
                  ),
                  SingleChildScrollView(
                    child: Center(
                      child: Form(
                        key: AppCubit.get(context).formKeyLogin,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  SizedBox(height: screenHeight / 3),

                                  SizedBox(
                                    height: screenHeight / 40,
                                  ),
                                  SizedBox(
                                    height: screenHeight / 57,
                                  ),
                                  Card(
                                    shape: BeveledRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    elevation: 1.5,
                                    child: defaultTextField(
                                        lable: 'National Id',
                                        controller: LoginCubit.get(context)
                                            .nationalIdController,
                                        prefix: Icons.assignment_ind_rounded,
                                        validate: (String value) {
                                          if (value.isEmpty) {
                                            return 'National Id can\'t be empty';
                                          }
                                        },
                                        context: context,
                                        type: TextInputType.number),
                                  ),
                                  SizedBox(
                                    height: screenHeight / 68,
                                  ),
                                  Card(
                                    shape: BeveledRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    elevation: 1.5,
                                    child: defaultTextField(
                                        controller: LoginCubit.get(context)
                                            .passwordController,
                                        lable: 'Password',
                                        prefix: Icons.lock_outline,
                                        suffix: LoginCubit.get(context).suffix,
                                        suffixPressed: () {
                                          LoginCubit.get(context)
                                              .changePasswordVisibility();
                                        },
                                        isSecure:
                                            LoginCubit.get(context).isPass,
                                        validate: (String value) {
                                          if (value.isEmpty) {
                                            return 'Password can\'t be empty';
                                          } else {
                                            bool result =
                                                LoginCubit.get(context)
                                                    .validatePassword(value);
                                            // if (result) {
                                            //   if (value.length < 8) {
                                            //     return " Password should at least 8 character";
                                            //   }
                                            // } else {
                                            //   return "Password should contain Capital,small letter ,\n Number & Special character";
                                            // }
                                          }
                                        },
                                        context: context,
                                        type: TextInputType.visiblePassword),
                                  ),
                                  SizedBox(
                                    height: screenHeight / 70,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            navigateTo(context,
                                                ForgetPasswordScreen());
                                          },
                                          child: Text(
                                            'Forget Password',
                                            style: TextStyle(
                                              color: HexColor('#707070'),
                                              fontSize: 16,
                                            ),
                                          ))
                                    ],
                                  ),
                                  SizedBox(
                                    height: screenHeight / 70,
                                  ),
                                  ConditionalBuilder(
                                    condition: state is! LoginLoadingState,
                                    builder: (context) => defaultButton(
                                        fontSize: 22,
                                        height: screenHeight / 16,
                                        onPress: () {
                                          if (AppCubit.get(context)
                                              .formKeyLogin
                                              .currentState!
                                              .validate()) {
                                            LoginCubit.get(context).userLogin(
                                                nationalId:
                                                    LoginCubit.get(context)
                                                        .nationalIdController
                                                        .text,
                                                password:
                                                    LoginCubit.get(context)
                                                        .passwordController
                                                        .text,
                                                context: context);
                                          } else {}
                                        },
                                        text: 'Login'),
                                    fallback: (context) => const Center(
                                        child: CircularProgressIndicator()),
                                  ),

                                  SizedBox(
                                    height: screenHeight / 34,
                                  ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                  //   children: [
                                  //     Expanded(
                                  //       child: Container(
                                  //         width: 40,
                                  //         height: 1,
                                  //         color: Colors.grey,
                                  //       ),
                                  //     ),
                                  //     const Padding(
                                  //       padding: EdgeInsets.symmetric(
                                  //           horizontal: 30),
                                  //       child: Text(
                                  //         'or',
                                  //         style: TextStyle(
                                  //           fontSize: 18,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     Expanded(
                                  //       child: Container(
                                  //         width: 40,
                                  //         height: 1,
                                  //         color: Colors.grey,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  // SizedBox(height: screenHeight / 34),
                                  // MaterialButton(
                                  //   onPressed: () {
                                  //     navigateTo(context,const RegisterScreen());
                                  //   },
                                  //   hoverColor: primaryColor,
                                  //   shape: const RoundedRectangleBorder(
                                  //       borderRadius: BorderRadius.all(
                                  //           Radius.circular(27.0)),
                                  //       side: BorderSide(color: primaryColor)),
                                  //   color: Colors.white,
                                  //   minWidth: double.infinity,
                                  //   height: screenHeight / 17,
                                  //   textColor: Colors.black,
                                  //   child: const Text(
                                  //     'Register',
                                  //     style: TextStyle(
                                  //         fontSize: 22,
                                  //         fontWeight: FontWeight.w300),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
