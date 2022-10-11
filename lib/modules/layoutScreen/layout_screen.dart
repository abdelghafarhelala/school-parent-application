import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:parent_app/shared/appCubit/app_cubit.dart';
import 'package:parent_app/shared/appCubit/app_states.dart';
import 'package:parent_app/shared/colors.dart';
import 'package:parent_app/shared/components/components.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  static const String oneSignalId = '3004eaca-097b-4ce0-8c2d-42bb63290777';

  String _debugLabelString = "";

  @override
  void initState() {
    super.initState();
    initPlatFormState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);

    // var controller = PageController(initialPage: cubit.currentIndex);

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          key: AppCubit.get(context).scaffoldKey,
          drawer: defaultDrawer(context),
          // appBar:
          //     defaultAppBar(context, cubit.titles[cubit.currentIndex], true),
          body: ConditionalBuilder(
              condition: true,
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
              builder: (context) => PageView(
                    controller: AppCubit.get(context).controller,
                    onPageChanged: (newIndex) {
                      cubit.changeAppNav(newIndex);
                    },
                    children: cubit.appScreens,
                  )),
          bottomNavigationBar: buildNavBar(context, cubit, isNav: true),
        );
      },
    );
  }

  //------------- send One Signal Notification ------------------------//
  Future<void> initPlatFormState() async {
    //when open notification while app is opened or app in background
    OneSignal.shared
        .setInAppMessageClickedHandler((OSInAppMessageAction action) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LayoutScreen(),
          ));
      setState(() {
        _debugLabelString =
            "In App Message Clicked: \n${action.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LayoutScreen(),
          ));

      setState(() {
        _debugLabelString =
            "Opened notification: \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });
    OneSignal.shared.setAppId(oneSignalId);
  }
}

Widget buildNavBar(context, cubit, {required bool isNav}) =>
    CurvedNavigationBar(
      color: primaryColor,
      backgroundColor: Colors.transparent,
      height: 60,
      items: cubit.buttonWidget(cubit.currentIndex),
      onTap: (index) {
        if (isNav) {
          AppCubit.get(context).controller.animateToPage(index,
              duration: const Duration(milliseconds: 300), curve: Curves.ease);
        } else {
          AppCubit.get(context).controller.animateToPage(index,
              duration: const Duration(milliseconds: 300), curve: Curves.ease);
          Navigator.pop(context);
        }

        // navigateAndFinish(context, LayoutScreen());
      },
      index: cubit.currentIndex,
    );
