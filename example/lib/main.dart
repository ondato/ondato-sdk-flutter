// ignore_for_file: non_constant_identifier_names

import 'dart:core';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ondato_flutter/ondato_config.dart';
import 'package:ondato_flutter/ondato_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String get YOUR_IDENTIFICATION_ID => 'YOUR_IDENTIFICATION_ID';

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
    } catch (e) {
      if (e is OndatoException) {
        log('Exception ${e.error.toString()}');
      } else {
        log(e.toString());
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
