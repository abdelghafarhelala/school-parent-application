import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parent_app/modules/absence/absence_screen.dart';
import 'package:parent_app/network/endpoints.dart';
import 'package:parent_app/shared/appCubit/app_cubit.dart';
import 'package:parent_app/shared/appCubit/app_states.dart';
import 'package:parent_app/shared/colors.dart';
import 'package:parent_app/shared/components/components.dart';

class ChildrenScreen extends StatelessWidget {
  const ChildrenScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = AppCubit.get(context).absenceModel;
    double screenHight = MediaQuery.of(context).size.height;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: defaultAppBar(context, 'الغياب', isSchool: false),
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
                                Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: Text(
                                    'أولادك ',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                // Text(
                                //   'Children ',
                                //   style: TextStyle(
                                //       fontSize: 22,
                                //       fontWeight: FontWeight.bold,
                                //       color: primaryColor),
                                // ),
                              ],
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
                                            print(model?.data?[index]
                                                .studentAbcence?.length);
                                            navigateTo(
                                                context,
                                                AbsenceScreen(
                                                    studentAbsence: model
                                                            ?.data?[index]
                                                            .studentAbcence ??
                                                        []));
                                          },
                                          child: buildAbsenceItem(
                                            image: model?.data?[index].image,
                                            context: context,
                                            reason:
                                                model?.data?[index].name ?? '',
                                            date:
                                                'عدد ايام الغياب ${model?.data?[index].studentAbcence?.length}',
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
