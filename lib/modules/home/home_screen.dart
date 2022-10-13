import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:parent_app/network/endpoints.dart';
import 'package:parent_app/shared/appCubit/app_cubit.dart';
import 'package:parent_app/shared/appCubit/app_states.dart';
import 'package:parent_app/shared/colors.dart';
import 'package:parent_app/shared/components/components.dart';

final List<String> imgList = [
  'https://img.freepik.com/free-photo/successful-child-with-graduation-cap-backpack-full-books_1098-3455.jpg?size=626&ext=jpg&uid=R76996913&ga=GA1.2.1634405249.1648830357',
  'https://img.freepik.com/free-photo/cheerful-kids-running-school-corridor_23-2147848723.jpg?size=626&ext=jpg&uid=R76996913&ga=GA1.2.1634405249.1648830357',
  'https://img.freepik.com/premium-photo/modern-classroom-interior-light-tones_241146-108.jpg?size=626&ext=jpg&uid=R76996913&ga=GA1.2.1634405249.1648830357'
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var homeModel = AppCubit.get(context).homeModel;
        var scheduleModel = AppCubit.get(context).tableModel;
        double screenHight = MediaQuery.of(context).size.height;
        // print(screenHight);
        return ConditionalBuilder(
          condition: (state is! AppGetHomeDataLoadingState) &&
              (state is! AppGetStudentTableLoadingState),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
          builder: (context) => AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.white,
              statusBarBrightness: Brightness.dark,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),

                  //--------------- Header of page (name-image) -----------//
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'مرحبا',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Row(
                              children: [
                                Text(
                                  '${AppCubit.get(context).profile?.data?.name ?? ''} !',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Icon(
                                  Icons.waving_hand_rounded,
                                  color: Colors.amber,
                                  size: 23,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: Card(
                            // margin: EdgeInsets.all(0),

                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                            clipBehavior: Clip.antiAlias,
                            child: IconButton(
                                onPressed: () {
                                  AppCubit.get(context)
                                      .scaffoldKey
                                      .currentState!
                                      .openDrawer();
                                },
                                icon: const Icon(
                                  Iconsax.menu,
                                  size: 20,
                                )),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            AppCubit.get(context).currentIndex = 4;
                            AppCubit.get(context).controller.animateToPage(4,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease);
                          },
                          child: CircleAvatar(
                            radius: 22,
                            backgroundImage: NetworkImage(AppCubit.get(context)
                                        .profile
                                        ?.data
                                        ?.img !=
                                    null
                                ? '$imageLink${AppCubit.get(context).profile?.data?.img}'
                                : 'https://img.freepik.com/free-photo/bohemian-man-with-his-arms-crossed_1368-3542.jpg?size=626&ext=jpg&uid=R76996913&ga=GA1.2.1634405249.1648830357'),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  //------------------------------ Sponsor of App -------------------//
                  buildSliderItem(screenHight > 780 ? 190 : 150, 12),

                  //---------------------- Start body of screen ------------------------//
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            // ---------- Title (text) of horizontal list ----------------//
                            Row(
                              children: const [
                                Text(
                                  'الحصص ',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'اليوميه ',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            //------------- Horizontal List of Classes of the current day----------//
                            if ((scheduleModel?.data?[0].classesClassRoomSection
                                        ?.length ??
                                    0) >
                                0)
                              SizedBox(
                                height: 168,
                                child: ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) => SizedBox(
                                        width: 250,
                                        child: buildClassItem(
                                            image: scheduleModel?.data?[0].classesClassRoomSection?[index].subject?.image ==
                                                    null
                                                ? 'https://img.freepik.com/free-vector/cairo-egypt-skyline-with-world-famous-landmarks_107791-1528.jpg?w=1380&t=st=1664965896~exp=1664966496~hmac=8e61090430b46c34a4f29633dd6ff064fc09c7a5f71191b2d76a15dfc84a6d36'
                                                : imageLink! +
                                                    scheduleModel!
                                                        .data![0]
                                                        .classesClassRoomSection![
                                                            index]
                                                        .subject!
                                                        .image!,
                                            isClass: true,
                                            date: scheduleModel
                                                    ?.data?[0]
                                                    .classesClassRoomSection?[
                                                        index]
                                                    .section
                                                    ?.timeStart ??
                                                '',
                                            subject: scheduleModel
                                                    ?.data?[0]
                                                    .classesClassRoomSection?[index]
                                                    .subject
                                                    ?.name ??
                                                '')),
                                    separatorBuilder: (context, index) => const SizedBox(
                                          width: 5,
                                        ),
                                    itemCount: (scheduleModel?.data?[0].classesClassRoomSection?.length ?? 0)),
                              ),
                            if ((scheduleModel?.data?[0].classesClassRoomSection
                                        ?.length ??
                                    0) ==
                                0)
                              buildNoItem(''),

                            // ---------- Title (text) of Vertical list ----------------//
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: const [
                                Text(
                                  'الأولاد ',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                // Text(
                                //   'Exams',
                                //   style: TextStyle(
                                //       fontSize: 22,
                                //       fontWeight: FontWeight.bold,
                                //       color: primaryColor),
                                // ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            // ------------------- Vertical List of incoming Exams -------------//
                            if ((homeModel?.data?.student?.length ?? 0) > 0)
                              ListView.separated(
                                  cacheExtent: 0,
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) => buildExamItem(
                                      isDegree: false,
                                      context: context,
                                      index: index,
                                      image: homeModel?.data?.student?[index]
                                                  .image ==
                                              null
                                          ? 'https://img.freepik.com/free-vector/sunburst-background-questionnaire-with-pencil_23-2147593791.jpg?size=338&ext=jpg&uid=R76996913&ga=GA1.2.1634405249.1648830357'
                                          : imageLink! +
                                              (homeModel?.data?.student?[index]
                                                      .image ??
                                                  ''),
                                      imageWidth: 90,
                                      text:
                                          '${homeModel?.data?.student?[index].name}',
                                      details: homeModel
                                              ?.data?.student?[index].address ??
                                          '',
                                      date: (homeModel?.data?.student?[index]
                                              .dateBirth ??
                                          ''),
                                      hight: 120,
                                      isExam: true),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        height: 5,
                                      ),
                                  itemCount:
                                      (homeModel?.data?.student?.length ?? 0)),
                            if ((homeModel?.data?.student?.length ?? 0) == 0)
                              buildNoItem('')
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
