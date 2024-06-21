import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shuftipro_onsite_sdk/shuftipro_onsite_sdk.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Sample Application'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


String generateRandomHexReference() {
  const int length = 10;
  const String chars = '0123456789ABCDEF';
  Random random = Random();
  return List.generate(length, (index) => chars[random.nextInt(16)]).join();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child:  ElevatedButton(
          onPressed: () async{

            createdPayload["reference"] = generateRandomHexReference();
            var response = await ShuftiproSdk.sendRequest(
                authObject: authObject,
                createdPayload: createdPayload,
                configObject: configObject);
            print("shufti-sdk-response ${response.toString()}");

          }, child: Text("Initiate ShuftiPro SDK"),
        ),
      ),

    );
  }



  Map<String, Object> authObject = {
      "auth_type": "basic_auth",
      "client_id": "", // Enter you Client ID
      "secret_key": "",// Enter your Secret Key
    };

  Map<String, Object> authenticateWithToken = {
      "auth_type": "access_token",
      "access_token": "", // Enter your Access Token
  };

  Map<String, Object> configObject = {
      "base_url": "api.shuftipro.com",
      "consent_age": 16,
  };

  Map<String, Object> createdPayload = {
    "country": "",
    "reference": "Unique-Reference",
    "language": "EN",
    "email": "",
    "verification_mode": "image_only",
    "show_results": 1,
    "face": {
      "allow_online" : "1",
      "allow_offline" : "0",},
    "document": {
      "supported_types": [
        "passport",
        "id_card",
        "driving_license",
        "credit_or_debit_card",
      ],
      "name": {
        "first_name": "",
        "last_name": "",
        "middle_name": "",
      },
      "dob": "",
      "document_number": "",
      "expiry_date": "",
      "issue_date": "",
      "gender": "",
      "allow_online" : "1",
      "allow_offline" : "0",
      "show_ocr_form" : "0",
      "backside_proof_required": "1",
    },
  };

}
