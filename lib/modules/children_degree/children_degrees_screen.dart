import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parent_app/modules/degrees/degrees_screen.dart';
import 'package:parent_app/shared/appCubit/app_cubit.dart';
import 'package:parent_app/shared/appCubit/app_states.dart';

import 'package:parent_app/shared/components/components.dart';

class ChildrenDegreeScreen extends StatelessWidget {
  const ChildrenDegreeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = AppCubit.get(context).degreesModel;
    double screenHight = MediaQuery.of(context).size.height;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: defaultAppBar(context, 'درجات اولادك', isSchool: false),
            body: ConditionalBuilder(
              condition: (state is! AppGetStudentDegreesLoadingState),
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
                            const Text(
                              ' أولادي',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            if ((model?.data?.length ?? 0) > 0)
                              Expanded(
                                child: ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) => InkWell(
                                          onTap: () {
                                            navigateTo(
                                                context,
                                                DegreeScreen(
                                                  name: model
                                                          ?.data?[index].name ??
                                                      '',
                                                  monthExams: model
                                                          ?.data?[index]
                                                          .monthExams ??
                                                      [],
                                                  finalExams: model
                                                          ?.data?[index]
                                                          .finalExams ??
                                                      [],
                                                  midExams: model?.data?[index]
                                                          .midExams ??
                                                      [],
                                                  yearWorks: model?.data?[index]
                                                          .yearWorks ??
                                                      [],
                                                ));
                                          },
                                          child: buildAbsenceItem(
                                            image: model?.data?[index].image,
                                            context: context,
                                            reason:
                                                model?.data?[index].name ?? '',
                                            date: '',
                                          ),
                                        ),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                          height: 5,
                                        ),
                                    itemCount: model?.data?.length ?? 0),
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
