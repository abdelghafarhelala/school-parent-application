import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parent_app/network/endpoints.dart';
import 'package:parent_app/shared/colors.dart';

class DetailsScreen extends StatelessWidget {
  final String? subject;
  final String? teacher;
  final String? date;
  final String? degree;
  final String? notes;
  final String? image;
  const DetailsScreen(
      {Key? key,
      this.subject,
      this.teacher,
      this.date,
      this.degree,
      this.notes,
      this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      color: Colors.white,
                    )),
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      padding: EdgeInsets.zero,
                      margin: EdgeInsets.zero,

                      // height: screenHight / 2.7,
                      height: screenHight / 2.9,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                              image: NetworkImage(image == null
                                  ? 'https://img.freepik.com/free-photo/public-examination-preparation-concept_23-2149369862.jpg?w=900&t=st=1663161776~exp=1663162376~hmac=f77f55d794f37d3c0694d7b6eef8f27d1f4669d11d8acea17f245aa487a0ff76'
                                  : imageLink! + image!),
                              fit: BoxFit.contain)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 10),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                              size: 25,
                            ),
                          )),
                    )
                  ],
                ),
              ],
            ),
            Container(
              // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: screenHight / 1.46,
              width: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(33),
                    topRight: Radius.circular(33)),
                // color: Colors.grey[100],
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: screenHight / 50,
                        ),
                        Text(
                          subject ?? '',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        SizedBox(
                          height: screenHight / 40,
                        ),

                        //--------------------------Card for degree and teacher -------------------//
                        Card(
                          color: int.parse(degree ?? '0') >= 50
                              ? Colors.greenAccent[100]
                              : Colors.red[100],
                          // : HexColor('#EB5353'),
                          borderOnForeground: false,
                          semanticContainer: false,
                          surfaceTintColor: Colors.white,
                          elevation: 12,
                          clipBehavior: Clip.antiAlias,
                          shadowColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                              side: BorderSide.none,
                              borderRadius: BorderRadius.circular(25)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 8),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Your Degree',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '$degree/100',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Your Teacher',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Mr : $teacher',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: screenHight / 50,
                                ),
                                Text(
                                  date ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHight / 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Text(
                                'Notes ',
                                style: Theme.of(context).textTheme.subtitle2!,
                              ),
                              Text(
                                'about Exam',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(color: primaryColor),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            notes ?? '',
                            style: Theme.of(context).textTheme.bodyText1,
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
