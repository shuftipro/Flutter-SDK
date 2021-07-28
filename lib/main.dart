import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shuftipro_flutter_sdk/ShuftiPro.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


String clientId = ""; // enter client id here
String secretKey = ""; // enter secret key here


typedef CalbackFunction = void Function(String value);

var response = "null";
bool isDoc = false;
Map<String, Object> secondPayload;
var secondAuthObject,asyncVar;


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
            fontFamily: 'OpenSans'
        ),
        home: MyHomePage(title: 'ShuftPro'),
        routes: <String, WidgetBuilder>{
          "/ConsentScreen" : (BuildContext context)=> new ShuftiPro(),}
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isFace = false,
      isDoc = false,
      isDoc2 = false,
      isAddress = false,
      isConsent = false,
      isBackground = false,
      isPhone = false;

  var authObject = {
    "auth_type": "basic_auth",
    "client_id": clientId,
    "secret_key": secretKey,
  };
  Map<String, Object> createdPayload = {
    "country": "",
    "language": "EN",
    "email": "",
    "callback_url": "http://www.example.com",
    "redirect_url": "https://www.dummyurl.com/",
    "show_consent": 1,
    "show_results": 1,
    "show_privacy_policy": 1,
    "open_webView": false,
  };
  Map<String, Object> verificationObj = {
    "face": {},
    "background_checks": {},
    "phone": {},
    "document": {
      "supported_types": [
        "passport",
        "id_card",
        "driving_license",
        "credit_or_debit_card",
      ],
      "name": {
        "first_name": "frstName",
        "last_name": "",
        "middle_name": "",
      },
      "dob": "",
      "document_number": "",
      "expiry_date": "",
      "issue_date": "",
      "fetch_enhanced_data": "",
      "gender": "",
      "backside_proof_required": "1",
    },
    "document_two": {
      "supported_types": [
        "passport",
        "id_card",
        "driving_license",
        "credit_or_debit_card"
      ],
      "name": {"first_name": "", "last_name": "", "middle_name": ""},
      "dob": "",
      "document_number": "",
      "expiry_date": "",
      "issue_date": "",
      "fetch_enhanced_data": "",
      "gender": "",
      "backside_proof_required": "0",
    },
    "address": {
      "full_address": "",
      "name": {
        "first_name": "",
        "last_name": "",
        "middle_name": "",
        "fuzzy_match": "",
      },
      "supported_types": ["id_card", "utility_bill", "bank_statement"],
    },
    "consent": {
      "supported_types": ["printed", "handwritten"],
      "text": "My name is John Doe and I authorize this transaction of \$100/-",
    },
  };

  void faceChk(bool newVal) => setState(() {
    isFace = newVal;
    if (isFace) {
      createdPayload["face"] = verificationObj['face'];
    } else if (!isFace) {
      createdPayload.remove('face');
    }
  });

  void docChk(bool newVal) => setState(() {
    isDoc = newVal;
    if (isDoc) {
      createdPayload["document"] = verificationObj['document'];
    } else if (!isDoc) {
      createdPayload.remove('document');
    }
  });

  void docChk2(bool newVal) => setState(() {
    isDoc2 = newVal;
    if (isDoc2) {
      createdPayload["document_two"] = verificationObj['document_two'];
    } else if (!isDoc2) {
      createdPayload.remove('document_two');
    }
  });

  void addressChk(bool newVal) => setState(() {
    isAddress = newVal;
    if (isAddress) {
      createdPayload["address"] = verificationObj['address'];
    } else if (!isAddress) {
      createdPayload.remove('address');
    }
  });

  void consentChk(bool newVal) => setState(() {
    isConsent = newVal;
    if (isConsent) {
      createdPayload["consent"] = verificationObj['consent'];
    } else if (!isConsent) {
      createdPayload.remove('consent');
    }
  });


  void backgroundChk(bool newVal) => setState(() {
    isBackground = newVal;
    if (isBackground){
      createdPayload["background_checks"] = verificationObj['background_checks'];
    } else if (!isBackground) {
      createdPayload.remove('background_checks');
    }
  });

  void phoneChk(bool newVal) => setState(() {
    isPhone = newVal;
    if (isPhone) {
      createdPayload["phone"] = verificationObj['phone'];
    } else if (!isPhone) {
      createdPayload.remove('phone');
    }
  });

  void continueFun() {
    if(isFace || isDoc || isDoc2 || isAddress ||isConsent || isBackground || isPhone){
      var v = DateTime.now();
      var reference = "ShuftiPro_Flutter_$v";
      createdPayload["reference"] = reference;
      print('continue: $createdPayload');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => new MySecond(authObject: authObject, asyncval: asyncVar,
            createdPayload: createdPayload)),
      );
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Select atleast one method of verification.'),
      ));
    }
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        color: Colors.black45,
        width: 0.5,
      ),
    );
  }

  int web= 0, syn = 0, consnt = 1, privcy = 1, reslt = 1, backs = 0;
  var asyncVar= false;
  Map<String,Object> docObjTemp;


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: () =>
        Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: 45.w,
                    left: 15.w,
                    bottom: 35.w,
                    right: 15.w,
                  ),
                  child: new Text(
                    "Verification",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                    bottom: 20.w,
                  ),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: new Text(
                      "Choose your method \nof Verification",
                      style: new TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                Container(
                  height: 395.h,
                  child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20.w,
                            bottom: 10.w,
                            right: 20.w,
                            top: 0.w,
                          ),
                          child: new GestureDetector(
                            onTap: () {
                              faceChk(!isFace);
                            },
                            child: new Container(
                              decoration: myBoxDecoration(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 5.w,
                                    ),
                                    child: Container(
                                        child: new IconButton(
                                          icon: Image.asset('assets/images/face.png'),
                                          onPressed: null,
                                        )),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 5.w,
                                    ),
                                    child: Container(
                                      child: new Text(
                                        "Face Verification",
                                        style: new TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    child: Checkbox(
                                      value: isFace,
                                      onChanged: faceChk,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20.w,
                            bottom: 10.w,
                            right: 20.w,
                          ),
                          child: new GestureDetector(
                            onTap: () {
                              docChk(!isDoc);
                            },
                            child: new Container(
                              decoration: myBoxDecoration(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 5.w,
                                    ),
                                    child: Container(
                                      child: new IconButton(
                                        icon: Image.asset('assets/images/document.png'),
                                        onPressed: null,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 5.w,
                                    ),
                                    child: Container(
                                      child: new Text(
                                        "Document Verification",
                                        style: new TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: Checkbox(
                                      value: isDoc,
                                      onChanged: docChk,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20.w,
                            bottom: 10.w,
                            right: 20.w,
                          ),
                          child: new GestureDetector(
                            onTap: () {
                              docChk2(!isDoc2);
                            },
                            child: new Container(

                              decoration: myBoxDecoration(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 5.w,
                                    ),
                                    child: Container(
                                      child: new IconButton(
                                        icon: Image.asset('assets/images/document.png'),
                                        onPressed: null,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 5.w,
                                    ),
                                    child: Container(
                                      child: new Text(
                                        "Document Two Verification",
                                        style: new TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: Checkbox(
                                      value: isDoc2,
                                      onChanged: docChk2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20.w,
                            bottom: 10.w,
                            right: 20.w,
                          ),
                          child: new GestureDetector(
                            onTap: () {
                              addressChk(!isAddress);
                            },
                            child: new Container(
                              decoration: myBoxDecoration(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 5.w,
                                    ),
                                    child: Container(
                                      child: new IconButton(
                                        icon: Image.asset('assets/images/address.png'),
                                        onPressed: null,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 5.w,
                                    ),
                                    child: Container(
                                      child: new Text(
                                        "Address Verification",
                                        style: new TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: Checkbox(
                                      value: isAddress,
                                      onChanged: addressChk,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20.w,
                            bottom: 10.w,
                            right: 20.w,
                          ),
                          child: new GestureDetector(
                            onTap: () {
                              consentChk(!isConsent);
                            },
                            child: new Container(
                              decoration: myBoxDecoration(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 5.w,
                                    ),
                                    child: Container(
                                      child: new IconButton(
                                        icon: Image.asset('assets/images/consent.png'),
                                        onPressed: null,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 5.w,
                                    ),
                                    child: Container(
                                      child: new Text(
                                        "Consent Verification",
                                        style: new TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: Checkbox(
                                      value: isConsent,
                                      onChanged: consentChk,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                            left: 20.w,
                            bottom: 10.w,
                            right: 20.w,
                          ),
                          child: new GestureDetector(
                            onTap: () {
                              backgroundChk(!isBackground);
                            },
                            child: new Container(
                              decoration: myBoxDecoration(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 5.w,
                                    ),
                                    child: Container(
                                      child: new IconButton(
                                        icon: Image.asset('assets/images/bgChecks.png'),
                                        onPressed: null,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 5.w,
                                    ),
                                    child: Container(
                                      child: new Text(
                                        "Background Verification",
                                        style: new TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: Checkbox(
                                      value: isBackground,
                                      onChanged: backgroundChk,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20.w,
                            bottom: 5.w,
                            right: 20.w,
                          ),
                          child: new GestureDetector(
                            onTap: () {
                              phoneChk(!isPhone);
                            },
                            child: new Container(
                              decoration: myBoxDecoration(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 5.w,
                                    ),
                                    child: Container(
                                      child: new IconButton(
                                        icon: Image.asset('assets/images/2fa.png'),
                                        onPressed: null,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 5.w,
                                    ),
                                    child: Container(
                                      child: new Text(
                                        "Two Factor Verification",
                                        style: new TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: Checkbox(
                                      value: isPhone,
                                      onChanged: phoneChk,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(
                    top: 5.w,
                    left: 10.w,
                    bottom: 20.w,
                    right: 10.w,
                  ),
                  child: Container(
                    child: OutlinedButton(
                      onPressed: continueFun,
                      style: OutlinedButton.styleFrom(backgroundColor: Colors.blueAccent),
                      child: new Container(
                        alignment: Alignment.center,
                        height: 45.h,
                        width: 1.sw,
                        child: new Text(
                          "Continue",
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ) );
  }
}

class MySecond extends StatefulWidget {
  final String title;
  final CalbackFunction callback;


  MySecond(
      {
        Key key,
        this.title,
        var authObject,
        var asyncval,
        Map<String, Object> createdPayload, this.callback}) {
    asyncVar = asyncval;
    secondAuthObject = authObject;
    secondPayload = createdPayload;
  }

  @override
  SecondScreen createState() => new SecondScreen();
}

class SecondScreen extends State<MySecond>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            height: 27,
            width: 27,
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Image(
              image: AssetImage("assets/images/back_icon.png"),
              height: 20,
              width: 20,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 65.w,
                left: 15.w,
                bottom: 25.w,
                right: 15.w,
              ),
              child: Image(
                image: AssetImage("assets/images/selectTypeIcon.png"),
                height: 100.h,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 10.w,
                left: 15.w,
                bottom: 5.w,
                right: 15.w,
              ),
              child: Text(
                'Choose Verification Type',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                top: 15.w,
                left: 20.w,
                bottom: 10.w,
                right: 20.w,
              ),
              child: GestureDetector(
                onTap: () {
                  secondPayload["verification_mode"] = "image_only";
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new ShuftiPro(
                              authObject: secondAuthObject,
                              createdPayload: secondPayload,
                              async: asyncVar,
                              callback: (res) {

                                response = res.toString();
                                print("\n\nResponse: " +
                                    res.toString());

                                ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(
                                  content: Text(res.toString()),
                                ));
                              },
                              homeClass: MyHomePage())));

                },
                child: Container(
                  height: 40.h,
                  decoration:
                  BoxDecoration(border: Border.all(color: Colors.black12)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          left: 5.w,
                        ),
                        child: Container(
                          height: 40.h,
                          width: 0.11.sw,
                          child: new IconButton(
                            icon: Image.asset('assets/images/imageCam.png'),
                            onPressed: null,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 5.w,
                        ),
                        child: Container(
                          child: new Text(
                            "Image Proof",
                            style: new TextStyle(
                                fontSize: 16.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 6.w,
                        ),
                        child: Container(
                          height: 18.h,
                          width: 0.06.sw,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12)),
                          alignment: Alignment.centerRight,
                          child: Image(
                            image: AssetImage("assets/images/continue_next.png"),
                            height: 18.h,
                            width: 0.06.sw,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                bottom: 5.w,
                right: 20.w,
              ),
              child: GestureDetector(
                onTap: () {
                  secondPayload["verification_mode"] = "video_only";
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new ShuftiPro(
                              authObject: secondAuthObject,
                              createdPayload: secondPayload,
                              async: asyncVar,
                              callback: (res) {
                                print("\n\nResponse: " +
                                    res.toString());

                                ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(
                                  content: Text(res.toString()),
                                ));
                              },
                              homeClass: MyHomePage())));
                },
                child: Container(
                  height: 40.h,
                  decoration:
                  BoxDecoration(border: Border.all(color: Colors.black12)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          left: 5.w,
                        ),
                        child: Container(
                          height: 40.h,
                          width: 0.11.sw,
                          child: new IconButton(
                            icon: Image.asset('assets/images/videoCam.png'),
                            onPressed: null,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 5.w,
                        ),
                        child: Container(
                          child: new Text(
                            "Video Proof ",
                            style: new TextStyle(
                                fontSize: 16.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 6.w,
                        ),
                        child: Container(
                          height: 18.h,
                          width: 0.06.sw,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12)),
                          alignment: Alignment.centerRight,
                          child: Image(
                            image: AssetImage("assets/images/continue_next.png"),
                            height: 18.h,
                            width: 0.06.sw,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(
                bottom: 9.w,
              ),
              child: Container(
                  height: 13.h,
                  child: Image.asset("assets/images/footerImage.png")),
            ),

          ],
        ),
      ),
    );
  }

}