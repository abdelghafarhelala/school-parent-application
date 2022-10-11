import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_app/modules/layoutScreen/layout_screen.dart';
import 'package:parent_app/shared/appCubit/app_cubit.dart';
import 'package:parent_app/shared/appCubit/app_states.dart';
import 'package:parent_app/shared/components/components.dart';

var oldPasswordController = TextEditingController();
var newPasswordController = TextEditingController();
var confirmNewPasswordController = TextEditingController();

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  GlobalKey<FormState> _productKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppChangePasswordSuccessState) {
          if (state.model?.result == true) {
            showToast(
                text: state.model?.errorMessage, state: ToastStates.success);
            AppCubit.get(context).currentIndex = 2;
            navigateTo(context, LayoutScreen());
          } else {
            showToast(
                text: state.model?.errorMessage, state: ToastStates.error);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
                statusBarColor: Colors.white),
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 25,
              ),
            ),
            elevation: 0,
          ),
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
                  key: _productKey,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: screenHeight / 35),
                        child: Column(
                          children: [
                            const Image(
                              image: AssetImage(
                                'assets/images/reset.png',
                              ),
                              height: 200,
                              width: 300,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              '''Change Password ''',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: screenHeight / 30,
                            ),
                            Card(
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              elevation: 1.5,
                              child: defaultTextFieldWithCustomIconImage(
                                  lable: 'Old Password',
                                  controller: oldPasswordController,
                                  prefix: const ImageIcon(
                                      AssetImage('assets/images/key.png')),
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'old password can\'t be empty';
                                    }
                                  },
                                  context: context,
                                  type: TextInputType.emailAddress),
                            ),
                            SizedBox(
                              height: screenHeight / 34,
                            ),
                            Card(
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              elevation: 1.5,
                              child: defaultTextFieldWithCustomIconImage(
                                  controller: newPasswordController,
                                  lable: 'New Password',
                                  prefix: const ImageIcon(
                                      AssetImage('assets/images/padlock.png')),
                                  suffix: AppCubit.get(context).suffix,
                                  suffixPressed: () {
                                    AppCubit.get(context)
                                        .changePasswordVisibility();
                                  },
                                  isSecure: AppCubit.get(context).isPass,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'new Password can\'t be empty';
                                    }
                                  },
                                  context: context,
                                  type: TextInputType.visiblePassword),
                            ),
                            SizedBox(
                              height: screenHeight / 34,
                            ),
                            Card(
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              elevation: 1.5,
                              child: defaultTextFieldWithCustomIconImage(
                                  controller: confirmNewPasswordController,
                                  lable: 'Confirm Password',
                                  prefix: const ImageIcon(AssetImage(
                                    'assets/images/padlock.png',
                                  )),
                                  suffix: AppCubit.get(context).suffixx,
                                  suffixPressed: () {
                                    AppCubit.get(context)
                                        .changePasswordVisibilityy();
                                  },
                                  isSecure: AppCubit.get(context).isPasss,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'You should Confirm your password';
                                    }
                                  },
                                  context: context,
                                  type: TextInputType.visiblePassword),
                            ),
                            SizedBox(
                              height: screenHeight / 35,
                            ),
                            ConditionalBuilder(
                              condition:
                                  state is! AppChangePasswordLoadingState,
                              builder: (context) => defaultButton(
                                  fontSize: 22,
                                  height: screenHeight / 16,
                                  onPress: () {
                                    if (_productKey.currentState!.validate()) {
                                      AppCubit.get(context).updatePasswordData(
                                          oldPassword:
                                              oldPasswordController.text,
                                          newPassword:
                                              newPasswordController.text,
                                          confirmNewPassword:
                                              confirmNewPasswordController
                                                  .text);
                                    } else {}
                                  },
                                  text: 'Update'),
                              fallback: (context) => const Center(
                                  child: CircularProgressIndicator()),
                            ),
                            const SizedBox(
                              height: 50,
                            )
                          ],
                        ),
                      ),
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
