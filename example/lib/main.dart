import 'dart:core';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ondato_flutter/ondato_config.dart';
import 'package:ondato_flutter/ondato_flutter.dart';

const YOUR_IDENTIFICATION_ID = '63f13f19-7aa4-4e4a-9ee0-b2d39af5548e';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

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
