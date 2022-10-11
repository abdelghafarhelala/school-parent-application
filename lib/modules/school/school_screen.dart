import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parent_app/network/endpoints.dart';
import 'package:parent_app/shared/appCubit/app_cubit.dart';
import 'package:parent_app/shared/appCubit/app_states.dart';
import 'package:parent_app/shared/colors.dart';
import 'package:parent_app/shared/components/components.dart';

import 'package:url_launcher/url_launcher.dart';

class SchoolScreen extends StatelessWidget {
  const SchoolScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = AppCubit.get(context).schoolModel;
        return Scaffold(
          key: AppCubit.get(context).scaffoldSchoolKey,
          drawer: defaultDrawer(context),
          //------------------App Bar ----------------------------//
          appBar:
              defaultAppBar(context, model?.data?.name ?? '', isSchool: true),
          body: ConditionalBuilder(
            condition: state is! AppGetSchoolDataLoadingState,
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
            builder: (context) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    //-------------------- School image ----------------------//
                    Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 190,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                                image: NetworkImage(
                                  'https://img.freepik.com/free-vector/school-building-bus-with-kids-scene_24640-46305.jpg?size=626&ext=jpg&uid=R76996913&ga=GA1.2.1634405249.1648830357',
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            MapUtils.openMap(
                                double.parse(model?.data?.langitude ?? ''),
                                double.parse(model?.data?.langitude ?? ''));
                            // MapUtils.openMap(-3.823216, -38.481700);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 22,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.location_on,
                                color: primaryColor,
                                size: 37,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //------------- title(text) of School details-------------//
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: const [
                          Text(
                            'تفاصيل',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' المدرسة',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                          ),
                        ],
                      ),
                    ),
                    //-----------------Card of School details -----------------//
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: primaryColor,
                                    size: 35,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Text(
                                    model?.data?.adress ??
                                        'No specific address',
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ))
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.info,
                                    color: primaryColor,
                                    size: 35,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Text(
                                    model?.data?.notes ??
                                        'There isn\'t any class notes',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //------------- title(text) of horizontal list of teachers-------------//
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: const [
                          Text(
                            'مدرسين',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' المدرسة',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //------------------- horizontal List of Teachers ---------------------//
                    SizedBox(
                      height: 180,
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => buildSchoolItem(
                              image: model?.data?.teachers?[index].image,
                              text: model?.data?.teachers?[index].name ?? '',
                              context: context,
                              width: 180.0,
                              imageHight: 129.0),
                          separatorBuilder: (context, index) => const SizedBox(
                                width: 5,
                              ),
                          itemCount: (model?.data?.teachers?.length ?? 0)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //------------- title(text) of Vertical list of School Stages -------------//
                    Row(
                      children: const [
                        Text(
                          'المراحل',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' الدراسية',
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
                    //------------------- Vertical List of School Stages ---------------------//
                    ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => buildSchoolItem(
                            image: model?.data?.stages?[index].img,
                            text: model?.data?.stages?[index].name ?? '',
                            context: context,
                            width: double.infinity,
                            imageHight: 170),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 4,
                            ),
                        itemCount: (model?.data?.stages?.length ?? 0))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget buildSchoolItem(
        {String? image,
        required String text,
        context,
        double? width,
        required double imageHight}) =>
    InkWell(
      onTap: () {},
      child: SizedBox(
        width: width,
        child: Card(
          elevation: 4,
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  if (image == null)
                    Container(
                      height: imageHight + 43,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(7),
                            topRight: Radius.circular(7),
                          ),
                          image: DecorationImage(
                              image: NetworkImage(
                                'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?size=626&ext=jpg&uid=R76996913&ga=GA1.2.1634405249.1648830357',
                              ),
                              fit: BoxFit.cover)),
                    ),
                  if (image != null)
                    Container(
                      height: imageHight + 43,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(7),
                            topRight: Radius.circular(7),
                          ),
                          image: DecorationImage(
                              image: NetworkImage(
                                imageLink! + image,
                              ),
                              fit: BoxFit.contain)),
                    ),
                  Container(
                    width: double.infinity,
                    color: Colors.black.withOpacity(.5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        text,
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              // const SizedBox(
              //   height: 10,
              // ),

              // const SizedBox(
              //   height: 5,
              // ),
            ],
          ),
        ),
      ),
    );

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    try {
      await launchUrl(
        Uri.parse(googleUrl),
      );
      // return true;
    } catch (e) {
      print(e.toString());
      // return false;
    }
    // if (await canLaunchUrl(Uri.parse(googleUrl))) {
    //   await launchUrl(Uri.parse(googleUrl));
    // } else {
    //   throw 'Could not open the map.';
    // }
  }
}
