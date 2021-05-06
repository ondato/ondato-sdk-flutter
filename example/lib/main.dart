import 'dart:core';

import 'package:flutter/material.dart';
import 'package:ondato_flutter/ondato_config.dart';
import 'package:ondato_flutter/ondato_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String accessToken = '';
  String indetificationId = '';

  @override
  void initState() {
    super.initState();
    intializeOndatoConfiguration();
  }

  void intializeOndatoConfiguration() {
    OndatoFlutter.init(
      OndatoServiceConfiguration(
        appearance: OndatoIosAppearance(
          errorColor: Colors.orange,
          progressColor: Colors.orange,
        ),
        language: OndatoLanguage.en,
        credentials: OndataCredencials(
            accessToken: accessToken, identificationId: indetificationId),
        flowConfiguration: OndatoFlowConfiguration(
            recordProcess: false,
            ignoreLivenessErrors: true,
            ignoreVerificationErrors: true),
        mode: OndatoEnvironment.test,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ondato Fluttter example app'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () => OndatoFlutter.startIdentification()
                    .then((indetificationId) => print(indetificationId)),
                child: Text('Start Identification'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
