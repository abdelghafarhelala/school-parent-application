import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parent_app/network/endpoints.dart';
import 'package:parent_app/shared/appCubit/app_cubit.dart';
import 'package:parent_app/shared/appCubit/app_states.dart';
import 'package:parent_app/shared/components/components.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    AppCubit.get(context).getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppUpdateProfileSuccessState) {
          if (state.model.result!) {
            showToast(
                text: 'تم تعديل البيانات بنجاح', state: ToastStates.success);
            print(state.model.data?.name);
            Navigator.pop(context);
            Navigator.pop(context);
          } else {
            showToast(text: state.model.errorMessage, state: ToastStates.error);
          }
        }
      },
      builder: (context, state) {
        var profileImage = AppCubit.get(context).postImage;
        var model = AppCubit.get(context).profile;
        double screenHeight = MediaQuery.of(context).size.height;
        return Scaffold(
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.white,
              statusBarBrightness: Brightness.dark,
            ),
            child: SingleChildScrollView(
              child: Center(
                child: Form(
                  key: AppCubit.get(context).formKeyUpdate,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back)),
                          const SizedBox(
                            height: 12,
                          ),
                          // Spacer(),

                          Text(
                            'تعديل البيانات الشخصيه',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontSize: 24),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenHeight / 34, vertical: 12),
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    if (profileImage == null)
                                      CircleAvatar(
                                        radius: 60,
                                        backgroundImage: model?.data?.img ==
                                                null
                                            ? NetworkImage(
                                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwnYnwftDUSjsQmLQvMBZ2pwDXhAJiIdfKvg&usqp=CAU')
                                            : NetworkImage(
                                                '$imageLink${model?.data?.img}'),
                                      ),
                                    if (profileImage != null)
                                      CircleAvatar(
                                        radius: 60,
                                        backgroundImage:
                                            FileImage(profileImage),
                                      ),
                                    CircleAvatar(
                                      backgroundColor: Colors.grey[300],
                                      child: IconButton(
                                        onPressed: () {
                                          AppCubit.get(context)
                                              .picProfileImage();
                                        },
                                        icon:
                                            const Icon(Icons.camera_alt_sharp),
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                                if (profileImage != null)
                                  IconButton(
                                      onPressed: () {
                                        AppCubit.get(context).removeImage();
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        size: 30,
                                      ))
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Card(
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              elevation: 1.5,
                              child: defaultTextField(
                                  lable: 'الإسم',
                                  controller: AppCubit.get(context)
                                      .updateNameController,
                                  prefix: Icons.person_outline,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'يجب أن تدخل الإسم';
                                    }
                                  },
                                  context: context,
                                  type: TextInputType.text),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Card(
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              elevation: 1.5,
                              child: defaultTextField(
                                  formats: [
                                    LengthLimitingTextInputFormatter(11),
                                  ],
                                  lable: 'رقم الهاتف',
                                  controller: AppCubit.get(context)
                                      .updatePhoneController,
                                  prefix: Icons.phone_iphone,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'يجب أن تدخل رقم الهاتف';
                                    }
                                  },
                                  context: context,
                                  type: TextInputType.phone),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Card(
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              elevation: 1.5,
                              child: defaultTextField(
                                  lable: 'البريد الإلكتروني',
                                  controller: AppCubit.get(context)
                                      .updateEmailController,
                                  prefix: Icons.email_outlined,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'يجب أن تدخل البريد الإلكتروني';
                                    }
                                  },
                                  context: context,
                                  type: TextInputType.emailAddress),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Card(
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              elevation: 1.5,
                              child: defaultTextField(
                                  lable: 'الرقم القومي',
                                  controller: AppCubit.get(context)
                                      .updateNationalIdController,
                                  prefix: Icons.height,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'يجب أن تدخل الرقم القومي';
                                    }
                                  },
                                  context: context,
                                  type: TextInputType.text),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Card(
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              elevation: 1.5,
                              child: defaultTextField(
                                  lable: 'العنوان',
                                  controller: AppCubit.get(context)
                                      .updateAddressController,
                                  prefix: Icons.balance,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'يجب أن تدخل الوزن';
                                    }
                                  },
                                  context: context,
                                  type: TextInputType.text),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: RadioListTile(
                                    title: Text("ذكر"),
                                    value: "1",
                                    groupValue: AppCubit.get(context).gender,
                                    onChanged: (value) {
                                      setState(() {
                                        AppCubit.get(context).gender =
                                            value.toString();
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile(
                                    title: Text("انثي"),
                                    value: "2",
                                    groupValue: AppCubit.get(context).gender,
                                    onChanged: (value) {
                                      setState(() {
                                        AppCubit.get(context).gender =
                                            value.toString();
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ConditionalBuilder(
                              condition: state is! AppUpdateProfileLoadingState,
                              builder: (context) => defaultButton(
                                  height: screenHeight / 16,
                                  onPress: () {
                                    if (AppCubit.get(context)
                                        .formKeyUpdate
                                        .currentState!
                                        .validate()) {
                                      if (profileImage != null) {
                                        AppCubit.get(context).updateProfile(
                                            email: AppCubit.get(context)
                                                .updateEmailController
                                                .text,
                                            phone: AppCubit.get(context)
                                                .updatePhoneController
                                                .text,
                                            name: AppCubit.get(context)
                                                .updateNameController
                                                .text,
                                            address: AppCubit.get(context)
                                                .updateAddressController
                                                .text,
                                            sex: AppCubit.get(context).gender ??
                                                '1',
                                            nationalId: int.parse(
                                                AppCubit.get(context)
                                                    .updateNationalIdController
                                                    .text));
                                      } else {
                                        AppCubit.get(context)
                                            .updateProfileWithoutImage(
                                                email:
                                                    AppCubit
                                                            .get(context)
                                                        .updateEmailController
                                                        .text,
                                                phone:
                                                    AppCubit
                                                            .get(context)
                                                        .updatePhoneController
                                                        .text,
                                                name:
                                                    AppCubit
                                                            .get(context)
                                                        .updateNameController
                                                        .text,
                                                address:
                                                    AppCubit.get(
                                                            context)
                                                        .updateAddressController
                                                        .text,
                                                sex: AppCubit.get(context)
                                                        .gender ??
                                                    '1',
                                                nationalId: int.parse(AppCubit
                                                        .get(context)
                                                    .updateNationalIdController
                                                    .text));
                                      }
                                    } else {}
                                  },
                                  text: 'تعديل'),
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
