import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:parent_app/models/table/table_model.dart';
import 'package:parent_app/network/endpoints.dart';
import 'package:parent_app/shared/appCubit/app_cubit.dart';
import 'package:parent_app/shared/appCubit/app_states.dart';
import 'package:parent_app/shared/components/components.dart';

class ScheduleScreen extends StatelessWidget {
  final List<ClassesClassRoomSection> sections;
  const ScheduleScreen({Key? key, required this.sections}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        TableModel? model = AppCubit.get(context).tableModel;
        return Scaffold(
          drawer: defaultDrawer(context),
          key: AppCubit.get(context).scaffoldScheduleKey,
          //--------------------- App Bar --------------------------//
          appBar: defaultAppBar(context, 'Schedule',
              isSchool: true, key: AppCubit.get(context).scaffoldScheduleKey),
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  //-------------------- Slider of Days ---------------------//
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      IconButton(
                          onPressed: () {
                            AppCubit.get(context)
                                .carouselController
                                .previousPage();
                            // print(object)
                          },
                          icon: const Icon(Icons.arrow_back)),
                      Expanded(
                        child: CarouselSlider(
                          items: AppCubit.get(context).titles,
                          options: CarouselOptions(
                              reverse: false,
                              enableInfiniteScroll: false,
                              onPageChanged: ((index, reason) {
                                AppCubit.get(context)
                                    .changeCarousalIndex(index);
                                AppCubit.get(context)
                                    .getStudentTableData(day: index + 1);
                              }),
                              initialPage: DateFormat('EEEE')
                                          .format(DateTime.now()) ==
                                      'Sunday'
                                  ? 0
                                  : DateFormat('EEEE').format(DateTime.now()) ==
                                          'Monday'
                                      ? 1
                                      : DateFormat('EEEE')
                                                  .format(DateTime.now()) ==
                                              'Tuesday'
                                          ? 2
                                          : DateFormat('EEEE')
                                                      .format(DateTime.now()) ==
                                                  'Wednesday'
                                              ? 3
                                              : 4,
                              autoPlay: false,
                              height: 50),
                          carouselController:
                              AppCubit.get(context).carouselController,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            AppCubit.get(context).carouselController.nextPage();
                          },
                          icon: const Icon(Icons.arrow_forward)),
                      const SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  //-------------------List that contains Table Of Sections For students----------//
                  ConditionalBuilder(
                      condition: state is! AppGetStudentTableLoadingState,
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                      builder: (context) => (sections.isNotEmpty
                          ? Expanded(
                              child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) => buildExamItem(
                                      isDegree: false,
                                      context: context,
                                      index: index,
                                      isExam: false,
                                      image: sections[index].subject?.image ==
                                              null
                                          ? 'https://img.freepik.com/free-vector/language-center-online-communication-courses-flat-advertising-composition-with-flag-diploma-tablet-big-ben-dictionaries_1284-32184.jpg?size=626&ext=jpg&uid=R76996913&ga=GA1.2.1634405249.1648830357'
                                          : imageLink! +
                                              sections[index].subject!.image!,
                                      imageWidth: 100,
                                      text:
                                          'المادة :${sections[index].subject?.name ?? ''}',
                                      details:
                                          'المدرس :${sections[index].teacher?.name ?? ''}',
                                      additionalDetails: 'Sec : ${index + 1}',
                                      sectionDuration:
                                          'من ${sections[index].section?.timeStart}  إلى ${sections[index].section?.timeEnd} ',
                                      hight: 145),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        height: 10,
                                      ),
                                  itemCount: sections.length),
                            )
                          //------------------- item that show when No items in the List ------------------//
                          : buildNoItem('للحصص')))
                ],
              )),
        );
      },
    );
  }
}
