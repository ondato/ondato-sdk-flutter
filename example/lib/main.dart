import 'dart:core';

import 'package:flutter/material.dart';
import 'package:ondato_flutter/ondato_config.dart';
import 'package:ondato_flutter/ondato_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const YOUR_ACCESS_TOKEN = '';
    const YOUR_IDENTIFICATION_ID = '';
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ondato Flutter example app'),
        ),
        body: Center(
          child: TextButton(
            onPressed: () async {
              await OndatoFlutter.init(
                OndatoServiceConfiguration(
                  appearance: OndatoIosAppearance(
                    errorColor: Colors.orange,
                    progressColor: Colors.orange,
                  ),
                  language: OndatoLanguage.en,
                  credentials: OndatoCredentials(
                    accessToken: YOUR_ACCESS_TOKEN,
                    identificationId: YOUR_IDENTIFICATION_ID,
                  ),
                  flowConfiguration: OndatoFlowConfiguration(
                    recordProcess: false,
                    ignoreLivenessErrors: true,
                    ignoreVerificationErrors: true,
                  ),
                  mode: OndatoEnvironment.test,
                ),
              );
              await OndatoFlutter.startIdentification().then(
                (identificationId) => print(identificationId),
              );
            },
            child: Text('Start Identification'),
          ),
        ),
      ),
    );
  }
}
