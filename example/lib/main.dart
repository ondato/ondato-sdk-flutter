// ignore_for_file: non_constant_identifier_names

import 'dart:core';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ondato_flutter/ondato_config.dart';
import 'package:ondato_flutter/ondato_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String yourIdentificationId = "93f0d705-05c7-429b-895b-cbfda0216fb3";
  bool ondatoInitialized = false;

  @override
  void initState() {
    super.initState();
    initializeOndato();
  }

  Future<void> initializeOndato() async {
    /// Initialize Ondato SDK
    final result = await OndatoFlutter.init(
      OndatoServiceConfiguration(
        identificationId: yourIdentificationId,
        language: OndatoLanguage.en,
        mode: OndatoEnvironment.test,
        flowConfiguration: OndatoFlowConfiguration(
          showSuccessWindow: true,
          showStartScreen: true,
        ),
        appearance: OndatoIosAppearance(
          errorColor: Colors.orange,
          progressColor: Colors.orange,
        ),
      ),
    );

    /// Set state to true if initialization was successful
    setState(() {
      ondatoInitialized = result ?? false;
    });
  }

  Future<void> startIdentification() async {
    try {
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
            child: ondatoInitialized
                ? TextButton(
                    onPressed: () => startIdentification(),
                    child: Text('Start Identification'),
                  )
                : CircularProgressIndicator()),
      ),
    );
  }
}
