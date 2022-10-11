import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:parent_app/modules/change_password/change_password_screen.dart';
import 'package:parent_app/modules/contact_us/contact_us_screen.dart';
import 'package:parent_app/modules/layoutScreen/layout_screen.dart';
import 'package:parent_app/modules/login/login.dart';
import 'package:parent_app/modules/school/school_screen.dart';
import 'package:parent_app/modules/update_profile/update_profile_screen.dart';
import 'package:parent_app/network/endpoints.dart';
import 'package:parent_app/shared/appCubit/app_cubit.dart';
import 'package:parent_app/shared/appCubit/app_states.dart';
import 'package:parent_app/shared/colors.dart';
import 'package:parent_app/shared/components/components.dart';
import 'package:parent_app/shared/const.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppLogOutSuccessState) {
          showToast(text: 'تم تسجيل الخروج بنجاح', state: ToastStates.success);
          navigateAndFinish(context, const LoginScreen());
        }
      },
      builder: (context, state) {
        var userData = AppCubit.get(context).profile;
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: primaryColor,
            statusBarBrightness: Brightness.dark,
          ),
          child: Container(
            color: primaryColor,
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.only(top: 20.0),
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                InkWell(
                  onTap: () {
                    AppCubit.get(context).currentIndex = 4;
                    AppCubit.get(context).changeAppNav(4);
                    navigateTo(context, const LayoutScreen());
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (userData?.data?.img == null)
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          height: 70,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwnYnwftDUSjsQmLQvMBZ2pwDXhAJiIdfKvg&usqp=CAU'),
                              )),
                        ),
                      if (userData?.data?.img != null)
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          height: 70,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                    '$imageLink${userData?.data?.img}'),
                              )),
                        ),
                      Text(
                        userData?.data?.name ?? 'User Name',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 21),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        userData?.data?.nationalId.toString() ?? 'Email',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      )),
                )
              ],
            ),
          ),
        );
      },
    );
  }

//Build Drawer List
  Widget myDrawerList(context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 200,
      // padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          menuItem(
              context,
              'https://cdn-icons-png.flaticon.com/128/1946/1946488.png',
              'الرئيسية',
              const LayoutScreen()),
          menuItem(
              context,
              'https://cdn-icons-png.flaticon.com/128/1007/1007988.png',
              'الجدول',
              LayoutScreen()),

          menuItem(
              context,
              // 'https://cdn-icons-png.flaticon.com/128/1077/1077063.png',
              'https://cdn-icons-png.flaticon.com/128/8032/8032498.png',
              'تواصل معنا',
              const ContactUsScreen(),
              index: 1),
          menuItem(
              context,
              // 'https://cdn-icons-png.flaticon.com/128/1077/1077063.png',
              'https://cdn-icons-png.flaticon.com/128/167/167801.png',
              'عن المدرسة',
              const SchoolScreen(),
              index: 1),
          // if (token != null)
          menuItem(
              context,
              'https://cdn-icons-png.flaticon.com/128/3064/3064197.png',
              'تغيير كلمة السر',
              const ChangePasswordScreen(),
              index: 2),
          // if (token != null)
          menuItem(
              context,
              'https://cdn-icons-png.flaticon.com/128/5167/5167017.png',
              'تحديث البروفايل',
              const UpdateProfileScreen(),
              index: 2),
          Spacer(),
          if (token != null)
            menuItem2(
              context,
              Icons.logout,
              'تسجيل الخروج',
            ),
          if (token == null)
            menuItem2(
              context,
              Icons.login,
              'تسجيل الدخول',
            ),
        ],
      ),
    );
  }

// Build menu of Drawer
  Widget menuItem(context, String icon, String text, Widget widget,
      {int index = 0}) {
    return Material(
      child: InkWell(
        onTap: () {
          if (text == 'الرئيسية') {
            AppCubit.get(context).controller.animateToPage(2,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
            Navigator.pop(context);
          } else if (text == 'الجدول') {
            AppCubit.get(context).controller.animateToPage(1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
            Navigator.pop(context);
          } else if (text == 'عن المدرسة') {
            AppCubit.get(context).getSchoolData();
            navigateTo(context, widget);
          } else {
            navigateTo(context, widget);
          }
        },
        child: Container(
          height: 70,
          decoration: BoxDecoration(
              border: Border.all(color: HexColor('#707070').withOpacity(.3))),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Image(
                  image: NetworkImage(
                    icon,
                  ),
                  height: text == 'الرئيسية' ? 25 : 30,
                  color: primaryColor,
                )),
                // SizedBox(
                //   width: 10,
                // ),
                Expanded(
                    flex: 3,
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Build menu2 of Drawer
  Widget menuItem2(
    context,
    IconData icon,
    String text,
  ) {
    return Material(
      child: InkWell(
        onTap: () {
          if (token == null) {
            navigateTo(context, const LoginScreen());
          } else {
            AppCubit.get(context).logOut(context);
          }
        },
        child: Container(
          height: 59,
          decoration: BoxDecoration(
              color: HexColor('#F87F45').withOpacity(.1),
              border: Border.all(color: HexColor('#707070').withOpacity(.3))),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                    child: Icon(
                  icon,
                  color: token == null ? Colors.green : HexColor('#AF4040'),
                )),
                Expanded(
                    flex: 3,
                    child: Text(
                      text,
                      style: TextStyle(
                          color: token == null
                              ? Colors.green
                              : HexColor('#AF4040'),
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
