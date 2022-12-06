import 'dart:core';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ondato_flutter/ondato_config.dart';
import 'package:ondato_flutter/ondato_flutter.dart';

const YOUR_IDENTIFICATION_ID = '649def31-fa05-47f2-bea9-d45841a7df26';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // OndatoFlutter.init(
    //   OndatoServiceConfiguration(
    //     identificationId: YOUR_IDENTIFICATION_ID,
    //     language: OndatoLanguage.en,
    //     mode: OndatoEnvironment.test,
    //     flowConfiguration: OndatoFlowConfiguration(
    //       showSplashScreen: true,
    //       showStartScreen: true,
    //     ),
    //     appearance: OndatoIosAppearance(
    //       errorColor: Colors.orange,
    //       progressColor: Colors.orange,
    //     ),
    //   ),
    // );
  }

  Future<void> startIdentification() async {
    try {
      await OndatoFlutter.init(
      OndatoServiceConfiguration(
        identificationId: YOUR_IDENTIFICATION_ID,
        language: OndatoLanguage.en,
        mode: OndatoEnvironment.test,
        flowConfiguration: OndatoFlowConfiguration(
          showSplashScreen: true,
          showStartScreen: true,
        ),
        appearance: OndatoIosAppearance(
          errorColor: Colors.orange,
          progressColor: Colors.orange,
        ),
      ),
      );
      var identificationId = await OndatoFlutter.startIdentification();
      log('Success with ${identificationId!} IdentificationId');
    } catch (error) {
      if (error is OndatoException) {
        log('Exception ${error.error.toString()}');
      } else {
        log(error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ondato Flutter example app'),
        ),
        body: Center(
          child: TextButton(
            onPressed: () => startIdentification(),
            child: Text('Start Identification'),
          ),
        ),
      ),
    );
  }
}
