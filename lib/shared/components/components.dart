import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:parent_app/modules/home/home_screen.dart';
import 'package:parent_app/modules/myDrawer/myDrawer.dart';
import 'package:parent_app/network/endpoints.dart';
import 'package:parent_app/shared/appCubit/app_cubit.dart';
import 'package:parent_app/shared/colors.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => widget), (route) {
      return false;
    });

Widget defaultButton(
        {double width = double.infinity,
        required double height,
        Color color = buttonColor,
        required Function onPress,
        required String text,
        double radius = 0.0,
        bool isUpper = false,
        double fontSize = 25}) =>
    MaterialButton(
      color: primaryColor,
      minWidth: width,
      height: height,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(27.0))),
      onPressed: () {
        onPress();
      },
      child: Text(
        isUpper ? text.toUpperCase() : text,
        style: TextStyle(color: Colors.white, fontSize: fontSize),
      ),
    );
Widget defaultButton2({
  required double width,
  required double height,
  required Color color,
  required Function onPress,
  required String text,
  double radius = 0.0,
  bool isUpper = false,
}) =>
    MaterialButton(
      color: color,
      minWidth: width,
      height: height,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(27.0))),
      onPressed: () {
        onPress();
      },
      child: Text(
        isUpper ? text.toUpperCase() : text,
        style: const TextStyle(color: Colors.white, fontSize: 25),
      ),
    );

Widget defaultTextField({
  required String lable,
  required IconData prefix,
  bool isEnabled = true,
  Function? validate,
  required context,
  IconData? suffix,
  ImageIcon? imageIcon,
  Function? suffixPressed,
  bool isSecure = false,
  required TextInputType type,
  List<TextInputFormatter> formats = const [],
  required var controller,
  Function? onTap,
  // Function? onChange,
}) =>
    TextFormField(
      enabled: isEnabled,
      inputFormatters: formats,
      // style: Theme.of(context).textTheme.button,
      decoration: InputDecoration(
        labelText: lable,
        prefixIcon: Icon(prefix),
        suffixIcon: IconButton(
            icon: Icon(suffix),
            onPressed: () {
              suffixPressed!();
            }),
      ),
      keyboardType: type,
      obscureText: isSecure,
      validator: (String? s) {
        return validate!(s);
      },
      controller: controller,
      onTap: () {
        onTap!();
      },
      // onChanged: (String s){
      //     onChange!(s);
      // },
    );

Widget defaultTextFieldWithCustomIconImage({
  String? lable,
  String? hint,
  ImageIcon? prefix,
  required Function? validate,
  bool isEnabled = true,
  required context,
  IconData? suffix,
  ImageIcon? imageIcon,
  Function? suffixPressed,
  bool isSecure = false,
  required TextInputType type,
  var controller,
  int maxLines = 1,
  // Function? onTap,
  // Function? onChange,
}) =>
    TextFormField(
      enabled: isEnabled,

      // style: Theme.of(context).textTheme.button,
      decoration: InputDecoration(
        hintText: hint,
        disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor)),
        labelText: lable,
        prefixIcon: prefix,
        prefixIconConstraints:
            const BoxConstraints(maxHeight: 40, maxWidth: 50, minWidth: 50),
        suffixIcon: IconButton(
            icon: Icon(suffix),
            onPressed: () {
              suffixPressed!();
            }),
      ),
      maxLines: maxLines,
      keyboardType: type,
      obscureText: isSecure,
      validator: (String? s) {
        return validate!(s);
      },
      controller: controller,
      onTap: () {
        // onTap!();
      },
      // onChanged: (String s){
      //     onChange!(s);
      // },
    );

void showToast({@required String? text, @required ToastStates? state}) =>
    Fluttertoast.showToast(
        msg: text!,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 7,
        backgroundColor: toastColor(state!),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { success, error, warning }

Color? color;
Color? toastColor(ToastStates state) {
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = HexColor('#F02525');

      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget defaultDrawer(context) => Container(
      padding: const EdgeInsets.all(0),
      width: 250,
      child: Drawer(
        child: Column(
          children: [
            const MyDrawer(),
            const MyDrawer().myDrawerList(context),
          ],
        ),
      ),
    );

PreferredSizeWidget defaultAppBar(context, String title,
        {required bool isSchool, GlobalKey<ScaffoldState>? key}) =>
    AppBar(
      leading: isSchool
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back))
          : null,
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      titleTextStyle: const TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      title: Text(title),
      centerTitle: true,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light),
      actions: [
        Card(
          // margin: EdgeInsets.all(0),

          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          clipBehavior: Clip.antiAlias,
          child: IconButton(
              padding: EdgeInsets.zero,
              iconSize: 16,
              onPressed: () {
                // isSchool ? print('key') : print('not key');
                isSchool
                    ? key!.currentState!.openDrawer()
                    : AppCubit.get(context)
                        .scaffoldKey
                        .currentState!
                        .openDrawer();
              },
              icon: const Icon(
                Iconsax.menu,
                size: 20,
              )),
        ),
      ],
    );

Widget buildNoItem(String type) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 250,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/no.png'),
                  fit: BoxFit.contain,
                  opacity: .8)),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'لا توجد بيانات $type هنا',
          style: const TextStyle(fontSize: 20, color: Colors.grey),
        )
      ],
    );

Widget buildSliderItem(double hight, double padding) => Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: CarouselSlider(
          items: imgList
              .map(
                (e) => Image(
                  image: NetworkImage(e),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              )
              .toList(),
          options: CarouselOptions(
            height: hight,
            initialPage: 0,
            viewportFraction: 1,
            autoPlay: true,
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
            reverse: false,
          ),
        ),
      ),
    );

//---------------------------Build Class and Stage Item ----------------//
Widget buildClassItem({
  required bool isClass,
  required String subject,
  required String date,
  required String image,
}) =>
    Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: isClass ? 160 : 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(image), fit: BoxFit.contain)),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                color: Colors.black.withOpacity(.5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isClass ? subject : '$subject Exam',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(
                          Icons.watch_later_outlined,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          isClass ? date : date,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );

//---------------------------Build Exam and Degree Item ----------------//
Widget buildExamItem({
  required int index,
  required double imageWidth,
  required double hight,
  required String text,
  required String details,
  required String image,
  required context,
  String? additionalDetails,
  String? sectionDuration,
  String? date,
  int? degree,
  required bool isExam,
  required bool isDegree,
}) =>
    Builder(builder: (context) {
      Color randomColor = AppCubit.get(context).getRandomColor();
      return Stack(
        clipBehavior: Clip.antiAlias,
        children: [
          Container(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            width: double.infinity,
            height: hight,
            decoration: BoxDecoration(
                color: randomColor, borderRadius: BorderRadius.circular(20)),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SizedBox(
              height: hight,
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        children: [
                          Container(
                            width: imageWidth,
                            height: hight - 12,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(image),
                                    fit: BoxFit.fill)),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Container(
                            height: hight + 12,
                            width: 1,
                            color: randomColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    text,
                                    style: TextStyle(
                                        fontSize: isExam ? 18 : 19,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    details,
                                    style: TextStyle(
                                        fontSize: isExam ? 16 : 17,
                                        fontWeight: FontWeight.w600,
                                        color: isExam
                                            ? Colors.grey
                                            : Colors.black),
                                  ),
                                  if (isDegree == false) ...[
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            isExam
                                                ? (date ?? '')
                                                : (sectionDuration ?? ''),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: primaryColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isExam == false)
                    Container(
                      width: 140,
                      height: 40,
                      decoration: BoxDecoration(
                          color:
                              (degree ?? 60) < 50 ? Colors.red : Colors.green,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(17),
                              topRight: Radius.circular(17))),
                      child: Center(
                          child: Text(
                        (degree ?? 60) < 50 ? 'راسب' : additionalDetails ?? '',
                        style: const TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      )),
                    )
                ],
              ),
            ),
          ),
        ],
      );
    });

//---------------build Absence and children item ----------------//
Widget buildAbsenceItem(
        {required context,
        required String reason,
        required String date,
        String? image}) =>
    Card(
      color: Colors.grey[100],
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(image == null
                        ? 'https://img.freepik.com/free-vector/red-prohibited-sign-no-icon-warning-stop-symbol-safety-danger-isolated-vector-illustration_56104-912.jpg?size=626&ext=jpg&uid=R76996913&ga=GA1.2.1634405249.1648830357'
                        : imageLink! + image))),
          ),
          const SizedBox(
            width: 1,
          ),
          Container(
            height: 120,
            width: 1,
            color: Colors.grey[300],
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  reason,
                  style: Theme.of(context).textTheme.headline2,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  date,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          )
        ],
      ),
    );
