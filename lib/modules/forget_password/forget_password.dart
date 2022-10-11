import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_app/modules/login/login.dart';
import 'package:parent_app/shared/appCubit/app_cubit.dart';
import 'package:parent_app/shared/appCubit/app_states.dart';
import 'package:parent_app/shared/colors.dart';
import 'package:parent_app/shared/components/components.dart';

var emailVerificationController = TextEditingController();
var formKeyForgetPass = GlobalKey<FormState>();

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppSendEmailSuccessState) {
          if (state.model?.result == true) {
            showToast(
                text: 'تم ارسال كلمة السر الجديده الي بريدك الإلكتروني',
                state: ToastStates.success);
            navigateTo(context, const LoginScreen());
          } else {
            showToast(
                text: state.model?.errorMessage, state: ToastStates.error);
          }
        } else if (state is AppSendEmailErrorState) {
          showToast(text: 'This email is invalid', state: ToastStates.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          // resizeToAvoidBottomInset: false,
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              // For Android.
              // Use [light] for white status bar and [dark] for black status bar.
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.white,
              // For iOS.
              // Use [dark] for white status bar and [light] for black status bar.
              statusBarBrightness: Brightness.dark,
            ),
            child: SingleChildScrollView(
              child: Center(
                child: Form(
                  key: formKeyForgetPass,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: screenHeight / 35),
                        child: Column(
                          children: [
                            SizedBox(
                              height: screenHeight / 20,
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.arrow_back))
                              ],
                            ),
                            Image.network(
                              'https://img.freepik.com/premium-vector/forgot-password-account-login-web-page-protection-security-key-access-system-smartphone-computer-flat-vector-illustration_2175-1386.jpg?size=626&ext=jpg&uid=R76996913&ga=GA1.2.1634405249.1648830357',
                              height: 200,
                              width: 300,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(
                              height: screenHeight / 20,
                            ),
                            const Text(
                              '''نسيت كلمة السر ! \n لا تقلق  ''',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            ),

                            SizedBox(
                              height: screenHeight / 30,
                            ),
                            Card(
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              elevation: 1.5,
                              child: defaultTextField(
                                  lable: 'أدخل البريد الإلكتروني',
                                  controller: emailVerificationController,
                                  prefix: Icons.email_outlined,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'يجب أن تدخل البريدالإبكتروني ';
                                    }
                                  },
                                  context: context,
                                  type: TextInputType.emailAddress),
                            ),

                            SizedBox(
                              height: screenHeight / 35,
                            ),
                            ConditionalBuilder(
                              condition: state is! AppSendEmailLoadingState,
                              builder: (context) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: defaultButton(
                                    fontSize: 22,
                                    height: screenHeight / 16,
                                    onPress: () {
                                      if (formKeyForgetPass.currentState!
                                          .validate()) {
                                        AppCubit.get(context).sendEmail(
                                            email: emailVerificationController
                                                .text);
                                      } else {}
                                    },
                                    text: 'إرسال'),
                              ),
                              fallback: (context) => const Center(
                                  child: CircularProgressIndicator()),
                            ),
                            // Container(
                            //   width: double.infinity,
                            //   height: 50,
                            //   child: OutlinedButton(
                            //       onPressed: () {}, child: const Text('data')),
                            // ),
                            SizedBox(
                              height: screenHeight / 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    width: 40,
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                  child: Text(
                                    'أو',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    width: 40,
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight / 30),
                            MaterialButton(
                              onPressed: () {
                                navigateAndFinish(context, LoginScreen());
                              },
                              hoverColor: primaryColor,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(27.0)),
                                  side: BorderSide(color: primaryColor)),
                              color: Colors.white,
                              minWidth: double.infinity,
                              height: screenHeight / 16,
                              textColor: Colors.black,
                              child: const Text(
                                'سجل الدخول',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w300),
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            )
                          ],
                        ),
                      ),
                      // Expanded(
                      //   child: Image.asset(
                      //     'assets/images/run.png',
                      //     width: double.infinity,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
