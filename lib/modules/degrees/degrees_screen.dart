import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parent_app/models/degrees/degrees_model.dart';
import 'package:parent_app/modules/details/details_screen.dart';
import 'package:parent_app/network/endpoints.dart';
import 'package:parent_app/shared/appCubit/app_cubit.dart';
import 'package:parent_app/shared/appCubit/app_states.dart';
import 'package:parent_app/shared/colors.dart';
import 'package:parent_app/shared/components/components.dart';

class DegreeScreen extends StatelessWidget {
  final String name;
  final List<MonthExams> monthExams;
  final List<FinalExams> finalExams;
  final List<YearWorks> yearWorks;
  final List<MidExams> midExams;
  const DegreeScreen(
      {Key? key,
      required this.monthExams,
      required this.finalExams,
      required this.yearWorks,
      required this.midExams,
      required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = AppCubit.get(context).degreesModel;
        return DefaultTabController(
          initialIndex: 0,
          length: 4,
          child: Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: defaultAppBar(context, 'Degree', isSchool: false),
            body:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 50,
                child: Material(
                  color: Colors.white,
                  child: TabBar(
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    tabs: [
                      Tab(
                        text: 'الشهر',

                        // child: Text('data'),
                      ),
                      Tab(
                        text: 'نصف الترم',
                      ),
                      Tab(
                        text: 'أعمال السنه',
                      ),
                      Tab(
                        text: 'النهائي',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              buildSliderItem(160, 5),
              // const SizedBox(
              //   height: 10,
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        const Text(
                          ' درجات ',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          name,
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: primaryColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Expanded(
                child: TabBarView(
                  children: [
                    if (monthExams.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    navigateTo(
                                        context,
                                        DetailsScreen(
                                          date: monthExams[index].date,
                                          degree: monthExams[index]
                                              .degree
                                              .toString(),
                                          notes: monthExams[index].notes,
                                          subject:
                                              monthExams[index].subject?.name,
                                          teacher:
                                              monthExams[index].teacher?.name,
                                          image:
                                              monthExams[index].subject?.image,
                                        ));
                                  },
                                  child: buildExamItem(
                                      isDegree: true,
                                      context: context,
                                      index: index,
                                      hight: 125,
                                      degree: monthExams[index].degree,
                                      text:
                                          'المادة : ${monthExams[index].subject?.name}',
                                      details:
                                          'الدرجة : ${monthExams[index].degree}/100',
                                      image: (monthExams[index]
                                                  .subject
                                                  ?.image) ==
                                              null
                                          ? 'https://img.freepik.com/free-vector/font-abc-happy-children_1308-5923.jpg?size=626&ext=jpg&uid=R76996913&ga=GA1.2.1634405249.1648830357'
                                          : imageLink! +
                                              (monthExams[index]
                                                  .subject
                                                  ?.image)!,
                                      imageWidth: 120,
                                      isExam: false,
                                      additionalDetails:
                                          ((monthExams[index].degree) ?? 0) >=
                                                  50
                                              ? 'ناجح'
                                              : 'راسب'),
                                ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 5,
                                ),
                            itemCount: monthExams.length),
                      ),

                    if ((model?.data?.length ?? 0) == 0)
                      buildNoItem('لدرجات الشهر'),
                    //------------------------------------ Mid Term Tab -----------------------//
                    if (midExams.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    navigateTo(
                                        context,
                                        DetailsScreen(
                                          date: midExams[index].date,
                                          degree:
                                              midExams[index].degree.toString(),
                                          notes: midExams[index].notes,
                                          subject:
                                              midExams[index].subject?.name,
                                          teacher:
                                              midExams[index].teacher?.name,
                                          image: midExams[index].subject?.image,
                                        ));
                                  },
                                  child: buildExamItem(
                                      isDegree: true,
                                      context: context,
                                      index: index,
                                      hight: 125,
                                      degree: midExams[index].degree,
                                      text:
                                          'المادة : ${midExams[index].subject?.name}',
                                      details:
                                          'الدرجة : ${midExams[index].degree}/100',
                                      image: (midExams[index].subject?.image) ==
                                              null
                                          ? 'https://img.freepik.com/free-vector/font-abc-happy-children_1308-5923.jpg?size=626&ext=jpg&uid=R76996913&ga=GA1.2.1634405249.1648830357'
                                          : imageLink! +
                                              (midExams[index].subject?.image)!,
                                      imageWidth: 120,
                                      isExam: false,
                                      additionalDetails:
                                          ((midExams[index].degree) ?? 0) >= 50
                                              ? 'ناجح'
                                              : 'راسب'),
                                ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 5,
                                ),
                            itemCount: midExams.length),
                      ),
                    if (midExams.isEmpty) buildNoItem(' لدرجات منتصف العام'),

                    //------------------------ year works Tab --------------------------------//
                    if (yearWorks.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    navigateTo(
                                        context,
                                        DetailsScreen(
                                          date: yearWorks[index].date,
                                          degree: yearWorks[index]
                                              .degree
                                              .toString(),
                                          notes: yearWorks[index].notes,
                                          subject:
                                              yearWorks[index].subject?.name,
                                          teacher:
                                              yearWorks[index].teacher?.name,
                                          image:
                                              yearWorks[index].subject?.image,
                                        ));
                                  },
                                  child: buildExamItem(
                                      isDegree: true,
                                      context: context,
                                      index: index,
                                      hight: 125,
                                      degree: yearWorks[index].degree,
                                      text:
                                          'المادة : ${yearWorks[index].subject?.name}',
                                      details:
                                          'الدرجة : ${yearWorks[index].degree}/100',
                                      image: (yearWorks[index]
                                                  .subject
                                                  ?.image) ==
                                              null
                                          ? 'https://img.freepik.com/free-vector/font-abc-happy-children_1308-5923.jpg?size=626&ext=jpg&uid=R76996913&ga=GA1.2.1634405249.1648830357'
                                          : imageLink! +
                                              (yearWorks[index]
                                                  .subject
                                                  ?.image)!,
                                      imageWidth: 120,
                                      isExam: false,
                                      additionalDetails:
                                          ((yearWorks[index].degree) ?? 0) >= 50
                                              ? 'ناجح'
                                              : 'راسب'),
                                ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 5,
                                ),
                            itemCount: yearWorks.length),
                      ),
                    if (yearWorks.isEmpty) buildNoItem('لأعمال السنة'),

                    //----------------------------------- final Exam Tab ----------------------------//
                    if (finalExams.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    navigateTo(
                                        context,
                                        DetailsScreen(
                                          date: finalExams[index].date,
                                          degree: finalExams[index]
                                              .degree
                                              .toString(),
                                          notes: finalExams[index].notes,
                                          subject:
                                              finalExams[index].subject?.name,
                                          teacher:
                                              finalExams[index].teacher?.name,
                                          image:
                                              finalExams[index].subject?.image,
                                        ));
                                  },
                                  child: buildExamItem(
                                      isDegree: true,
                                      context: context,
                                      index: index,
                                      hight: 125,
                                      degree: finalExams[index].degree,
                                      text:
                                          'المادة : ${finalExams[index].subject?.name}',
                                      details:
                                          'الدرجة : ${finalExams[index].degree}/100',
                                      image: (finalExams[index]
                                                  .subject
                                                  ?.image) ==
                                              null
                                          ? 'https://img.freepik.com/free-vector/font-abc-happy-children_1308-5923.jpg?size=626&ext=jpg&uid=R76996913&ga=GA1.2.1634405249.1648830357'
                                          : imageLink! +
                                              (finalExams[index]
                                                  .subject
                                                  ?.image)!,
                                      imageWidth: 120,
                                      isExam: false,
                                      additionalDetails:
                                          ((finalExams[index].degree) ?? 0) >=
                                                  50
                                              ? 'ناجح'
                                              : 'راسب'),
                                ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 5,
                                ),
                            itemCount: finalExams.length),
                      ),
                    if (finalExams.isEmpty) buildNoItem('لدرجات اخر العام'),
                  ],
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
