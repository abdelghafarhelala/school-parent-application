import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parent_app/models/absence/absence_model.dart';
import 'package:parent_app/modules/layoutScreen/layout_screen.dart';
import 'package:parent_app/shared/appCubit/app_cubit.dart';
import 'package:parent_app/shared/appCubit/app_states.dart';
import 'package:parent_app/shared/colors.dart';
import 'package:parent_app/shared/components/components.dart';

class AbsenceScreen extends StatelessWidget {
  final List<StudentAbcence> studentAbsence;
  const AbsenceScreen({Key? key, required this.studentAbsence})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHight = MediaQuery.of(context).size.height;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            key: AppCubit.get(context).scaffoldSchoolKey,
            drawer: defaultDrawer(context),
            bottomNavigationBar:
                buildNavBar(context, AppCubit.get(context), isNav: false),
            appBar: defaultAppBar(context, 'Absence',
                isSchool: true, key: AppCubit.get(context).scaffoldSchoolKey),
            body: ConditionalBuilder(
              condition: (state is! AppGetStudentAbsenceLoadingState),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
              builder: (context) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    buildSliderItem(screenHight > 780 ? 190 : 150, 12),
                    const SizedBox(
                      height: 12,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8),
                        child: Column(
                          children: [
                            Row(
                              children: const [
                                Text(
                                  'أيام ',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'الغياب ',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            if (studentAbsence.isNotEmpty)
                              Expanded(
                                child: ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        buildAbsenceItem(
                                          isAbsence: false,
                                          // image: model?.data?[index].image,
                                          context: context,
                                          reason:
                                              studentAbsence[index].reason ??
                                                  '',
                                          date:
                                              studentAbsence[index].date ?? '',
                                        ),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                          height: 5,
                                        ),
                                    itemCount: studentAbsence.length),
                              )
                            else
                              buildNoItem('غياب')
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
