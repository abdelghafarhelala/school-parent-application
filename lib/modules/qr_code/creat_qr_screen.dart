import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateQRScreen extends StatefulWidget {
  final String qrStringCode;
  const CreateQRScreen({Key? key, required this.qrStringCode})
      : super(key: key);

  @override
  CreateQRScreenState createState() => CreateQRScreenState(qrStringCode);
}

class CreateQRScreenState extends State<CreateQRScreen> {
  final String qrCode;
  CreateQRScreenState(this.qrCode);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'كودك',
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: BarcodeWidget(
              data: qrCode,
              barcode: Barcode.qrCode(),
              color: Colors.black,
              height: 350,
              width: 250,
            ),
          ),
          // Container(
          //   alignment: Alignment.center,
          //   width: MediaQuery.of(context).size.width * .8,
          //   child: TextField(
          //     onChanged: (val) {
          //       setState(() {
          //         qrstr = val;
          //       });
          //     },
          //     decoration: const InputDecoration(
          //         hintText: 'Enter your data here',
          //         border: OutlineInputBorder(
          //             borderSide: BorderSide(color: Colors.black, width: 2))),
          //   ),
          // ),
          // SizedBox(
          //   width: MediaQuery.of(context).size.width,
          // )
        ],
      ),
    );
  }
}
