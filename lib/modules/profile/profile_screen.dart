import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:parent_app/modules/change_password/change_password_screen.dart';
import 'package:parent_app/modules/full_screen_image/full_screen_image.dart';
import 'package:parent_app/modules/qr_code/creat_qr_screen.dart';
import 'package:parent_app/network/endpoints.dart';
import 'package:parent_app/shared/appCubit/app_cubit.dart';
import 'package:parent_app/shared/appCubit/app_states.dart';
import 'package:parent_app/shared/colors.dart';
import 'package:parent_app/shared/components/components.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var profileModel = AppCubit.get(context).profile?.data;
        return Scaffold(
          //------------------ app bar ----------------------------//
          appBar: defaultAppBar(context, 'Profile', isSchool: false),
          body: ConditionalBuilder(
            condition: state is! AppGetUserDataLoadingState,
            fallback: (context) => const CircularProgressIndicator(),
            builder: (context) => profileModel != null
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          //##################### Section one of Screen (profile_image , id, phone , QR ) ##########################//
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //------------------------ user Image ---------------//
                              if (AppCubit.get(context).profile?.data?.img ==
                                  null)
                                InkWell(
                                  onTap: () {
                                    navigateTo(
                                        context,
                                        FullScreenImageScreen(
                                            imagePath: profileModel.img == null
                                                ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwnYnwftDUSjsQmLQvMBZ2pwDXhAJiIdfKvg&usqp=CAU'
                                                : imageLink! +
                                                    profileModel.img!));
                                  },
                                  child: CircleAvatar(
                                    radius: 55,
                                    backgroundImage: NetworkImage(profileModel
                                                .img ==
                                            null
                                        ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwnYnwftDUSjsQmLQvMBZ2pwDXhAJiIdfKvg&usqp=CAU'
                                        : imageLink! + profileModel.img!),
                                  ),
                                ),
                              if (AppCubit.get(context).profile?.data?.img !=
                                  null)
                                InkWell(
                                  onTap: () {
                                    navigateTo(
                                        context,
                                        FullScreenImageScreen(
                                            imagePath:
                                                '$imageLink${AppCubit.get(context).profile?.data?.img}'));
                                  },
                                  child: CircleAvatar(
                                    radius: 55,
                                    backgroundImage: NetworkImage(
                                        '$imageLink${AppCubit.get(context).profile?.data?.img}'),
                                  ),
                                ),
                              const SizedBox(
                                width: 20,
                              ),
                              //--------------- name , national_id and phone --------------//
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          profileModel.name ?? 'User Name',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.credit_card_rounded,
                                              size: 20,
                                              color: Colors.black87,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              profileModel.nationalId
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black87),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.phone,
                                          size: 20,
                                          color: Colors.grey,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          profileModel.mobile ?? 'لا يوجد هاتف',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          //##################### Section Two , Section three and section Four of screen ###########################//
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //<--------------- Section Two of screen (address , Email )----------------->//

                                //------------------------------- Email Design -----------------//
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.email,
                                      color: primaryColor,
                                      size: 30,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Text(
                                      profileModel.email ??
                                          'No specific address',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ))
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                //-------------- Address Design -------------------//
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
                                      profileModel.address ??
                                          'No specific address',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ))
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                //-------------------- line Divider ----------------//
                                Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.grey[300],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),

                                //######################### Section Three of screen (Links for Screens)##########################/
                                //---------- text of your children---------//
                                Row(
                                  children: const [
                                    Text(
                                      'قائمة ',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'الأولاد ',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) =>
                                        buildChildrenItem(
                                            className: profileModel
                                                .students?[index]
                                                .classRooms
                                                ?.name,
                                            name: profileModel
                                                    .students?[index].name ??
                                                '',
                                            image: profileModel
                                                .students?[index].image),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                          height: 10,
                                        ),
                                    itemCount:
                                        profileModel.students?.length ?? 0),
                                const SizedBox(
                                  height: 15,
                                ),
                                //-------------------- line Divider ----------------//
                                Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.grey[300],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                //######################### Section Four of screen (Links for Screens)##########################/
                                //--------------------- schedule -------------------//
                                InkWell(
                                  onTap: () {
                                    AppCubit.get(context).currentIndex = 1;
                                    AppCubit.get(context)
                                        .controller
                                        .animateToPage(1,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.ease);
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: Colors.amber.withOpacity(.6),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Icon(
                                          Icons.table_chart_rounded,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      const Text('جدول الحصص',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          )),
                                      const Spacer(),
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 20,
                                          ))
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                //--------------- degrees -------------------//
                                InkWell(
                                  onTap: () {
                                    AppCubit.get(context).currentIndex = 0;
                                    AppCubit.get(context)
                                        .controller
                                        .animateToPage(0,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.ease);
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: primaryColor.withOpacity(.6),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Icon(
                                          Iconsax.task_square,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      const Text('درجات الأولاد',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          )),
                                      const Spacer(),
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 20,
                                          ))
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                //--------------abcence--------------//
                                InkWell(
                                  onTap: () {
                                    AppCubit.get(context).currentIndex = 3;
                                    AppCubit.get(context)
                                        .controller
                                        .animateToPage(3,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.ease);
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: Colors.green.withOpacity(.6),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Icon(
                                          Icons.access_time,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      const Text('غياب الأولاد',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          )),
                                      const Spacer(),
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 20,
                                          ))
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                //------------------------change Password-----------------//
                                InkWell(
                                  onTap: () {
                                    navigateTo(
                                        context, const ChangePasswordScreen());
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: Colors.cyan.withOpacity(.6),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Icon(
                                          Icons.lock_outline,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      const Text('تغيير كلمة السر',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          )),
                                      const Spacer(),
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 20,
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : buildNoItem(''),
          ),
        );
      },
    );
  }
}

Widget buildChildrenItem(
        {String? image, required String name, String? className}) =>
    Row(
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: Colors.grey[100],
          backgroundImage: NetworkImage(
            // scale: 1,
            image == null
                ? 'https://img.freepik.com/free-photo/young-man-student-with-notebooks-showing-thumb-up-approval-smiling-satisfied-blue-studio-background_1258-65597.jpg?w=996&t=st=1664283767~exp=1664284367~hmac=6396fad37577d483360c324d9c23d5a8837247b094d03256298a0270a1e96943'
                : imageLink! + image,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                )),
            const SizedBox(
              height: 5,
            ),
            Text(className ?? 'غير مسجل في صف', // static class
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                )),
          ],
        ),
      ],
    );
