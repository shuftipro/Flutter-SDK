
# What is Shufti Pro?
Shufti Pro, UK-based Software as a Service (SaaS) provider is a pioneer in offering real-time identity verification services across 230+ countries and territories, helping businesses to comply with KYC, KYB and AML regulations. The solution also helps companies to determine and overcome the fraud risk with its fully automated ID verification services including document authentication, face verification, consent verification, facial biometric recognition, phone verification, anti-money laundering screening and 2-factor authentication.

A user-friendly interface with an easy API integration procedure enables businesses to onboard legit customers seamlessly and helps to develop trustworthy B2B relationships. Shufti Pro’s ID verification services are fit for all industries including FinTechs, Virtual asset service providers, banks and much more. Choosing Shufti Pro can fight crimes, increase productivity, and enhance conversion rate, everything in just less than a second.

## Table of contents
* [General Requirements](#general-requirements)
* [Permissions](#permissions)
* [SDK Installation Guide](#sdk-installation-guide)
* [Verification Types You Can Get](#verification-types-you-can-get)
* [Integration](#Integration)
* [Initiate Request](#Initiate-Request)
* [Auth Key Object Parameters ](#Auth-Key-Object-Parameters)
* [Config Object Parameters ](#Config-Object-Parameters)
* [Request Object Parameters](#Request-Object-Parameters)
* [Customisations ](#Customisations)
* [HTTP Codes](#HTTP-Codes)
* [Response Logging](#response-logging)
* [Status Response](#status-response)
* [Test IDs](#test-ids)
* [Contact](#contact)
* [Copyright](#copyright)



## General Requirements
Minimum requirements for SDK include
- Android 6.0 (API level 23) or higher
- Internet connection
- Camera
## Permissions:
The Shufti Pro application requires permission to access the following:
- Camera
- External Storage

**Note:** All permissions are handled in the SDK.
## SDK Installation Guide
In your **Project** follow the steps given below.
1. Run this command: "dart pub add shuftipro_sdk" with dart or "flutter pub add shuftipro_sdk" with flutter
2. Add dependency in pubspec.yaml as
   dependencies:
   shuftipro_sdk: ^1.1.6
3. Import this 'package:shuftipro_sdk/ShuftiPro.dart' in your class in order to send the request to ShuftiPro's SDK.

## Verification Types You Can Get:
Shufti Pro’s services come in three variations. You have an option of choosing all or any one of them that fulfills your client's requirements. Following are the types of verification services;

**With OCR:** Verification services API embedded with OCR technology can extract personally identifiable information from user’s ID documents and authenticate them as a part of a single identity verification process.

**Without OCR:** In case you are choosing this service, your clients need to provide additional proof of data in the form of identity documents other than verification information.

**Verification Through Hybrid View:** Shufti Pro’s hybrid view includes mobile verifications along with a web view built on HTML 5 that will show the results to the end-user. The verification data will be sent through a JSON object, quite similar to OCR/Non-OCR in the mobile authentication formats. In case the value for OpenViewParameter is set to true, the hybrid view will be enabled, else the other models will be triggered.


## Integration:
A sample project is shown below, that will help you learn to integrate Shufti Pro’s Verification APIs’.

**Step 1:** Make AuthKeys object using Client ID and Secret Key

```
        var authObject = {
          "auth_type": "basic_auth",
          "client_id": clientId,
          "secret_key": secretKey,
        };

```

Or AuthKeys object using Access Token

```
        var authObject = {
          "auth_type": "access_token",
          "access_token": accessToken,
        };

```

AuthKeys object parameters are explained [here](#auth-key-object-parameters).

**Step 2:** Make Config object

```
    Map<String,Object> configObj = {
      "open_webview": false,
      "asyncRequest": false,
      "captureEnabled": false,
    };

```

Config object parameters are explained [here](#config-object-parameters).

**Step 4:** Request Object

       Map<String, Object> createdPayload = {
            "country": "US",
            "reference": "12345678",
            "language": "EN",
            "email": "",
            "callback_url": "http://www.example.com",
            "redirect_url": "https://www.dummyurl.com/",
            "verification_mode": "image_only",
            "show_consent": 1,
            "show_results": 1,
            "show_privacy_policy": 1,
          };

        //Creating Verification Object

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
              /* Keep name, dob, document_number, expiry_date, issue_date empty for with-OCR request*/

              "name": {
                "first_name": "Johon",
                "last_name": "Johsan",
                "middle_name": "Livone",
              },
              "dob": "",
              "document_number": "19901112",
              "expiry_date": "1996-11-12",
              "issue_date": "1990-11-12",
              "gender": "M",
              "backside_proof_required": "1",
            },

            //Creating Document Two Object is exactly same as document object. 

            "address": {
              "full_address": "ST#2, 937-B, los angeles.",
              "name": {
                "first_name": "Johon",
                "last_name": "Johsan",
                "middle_name": "Livone",
              },
              "supported_types": ["id_card", "utility_bill", "bank_statement", "passport", "driving_license"],
            },
            /* Keep name and full_address empty for with-OCR request */


            "consent": {
              "supported_types": ["printed", "handwritten"],
              "text": "My name is John Doe and I authorize this transaction of \$100/-",
            },
          };

        //Adding Face Verification Service to Payload

        createdPayload["face"] = verificationObj['face'];

        //Adding Document Verification Service to Payload

        createdPayload["document"] = verificationObj['document'];

        //Adding Document Two Verification Service to Payload

        createdPayload["document_two"] = verificationObj['document_two'];

        //Adding Address Verification Service to Payload

        createdPayload["address"] = verificationObj['address'];

        //Adding Consent Verification Service to Payload

        createdPayload["consent"] = verificationObj['consent'];


Request Object parameters are explained [here](#Request-Object-Parameters).

## Initiate Request

    ShuftiproSdk.sendRequest(authObject: authObject,
          createdPayload: createdPayload, configObject: configObject);


## Auth Key Object Parameters
In this object, we add authorization key in verification request.
* ## Basic Auth
  The server provides authorization keys to clients through Basic Auth header. The IDs’ will be used as usernames while the Secret Key will act as passwords. Upon each API hit, this header will be requested.

* ## Access Token
  Shufti Pro provides a Bearer Access Token Authorization method. The client can generate a temporary access token using the new access token endpoint. The shared token will be used to authorize API requests. The token shared with the client will be valid for 10 minutes and can be used once only.

## Config Object Parameters
In this object, we add an extra configuration of verification that the user wants.
* ## open_webview
  Required: **No**<br>
  Type: **boolean**<br>
  Accepted Values: **true, false**<br><br>
  This is a boolean type parameter that determines whether to run or terminate the hybrid view. However, its **default value** is set as **false**.

* ## asyncRequest
  Required: **No**<br>
  Type: **boolean**<br>
  Accepted Values: **true, false**<br><br>
  If the value of this parameter is set to True, the client will get control back and don't have to wait for verification results. However, when the request completes an automated callback is generated.

* ## captureEnabled
  Required: **No**<br>
  Type: **boolean**<br>
  Accepted Values: **true, false**<br><br>
  This parameter identifies whether the client wants to open the camera in Iframe or not. If the value is set to true the camera will open and vice versa.

## Request Object Parameters
Shufti Pro offers exclusive services to its clients, and is tailored to meet users’ requests. You can choose one or all of the optional API keys.<br>
In case a key is given in document or address verification, and no value is provided, then OCR will be performed for those particular keys.
* ## Reference
  Required: **Yes**<br>
  Type: **string**<br>
  Minimum: **6 characters**<br>
  Maximum: **250 characters**<br><br>
  This is the unique reference ID, which the server will send you with each response, so you can verify the requests. Only alphanumeric values are allowed.

* ## Country
  Required: **No**<br>
  Type: **string**<br>
  Length: **2 characters**<br><br>
  Input  2 characters long [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Officially_assigned_code_elements)  country code of your client. Here is the list of [Countries](https://api.shuftipro.com/api/docs/#supported-countries) that Shufti Pro APIs support.

* ## Language
  Required: **No**<br>
  Type: **string**<br>
  Length: **2 characters**<br><br>
  Input 2 characters long language code as per your client's requirements to see verification results accordingly. Default language English will be selected if this key is missing in the request. Here are the [Supported Languages](https://api.shuftipro.com/api/docs/#supported-languages) you can choose from.

* ## Email
  Required: **No**<br>
  Type: **string**<br>
  Minimum: **6 characters**<br>
  Maximum: **128 characters**<br><br>
  This field represents the email of the end-user. This is an optional field.

* ## callback_url
  Required: **No**<br>
  Type: **string**<br>
  Minimum: **6 characters**<br>
  Maximum: **250 characters**<br><br>
  This generates several server-to-server calls to keep you updated about the verification status. This way you can update the request status at your end even if the customer is lost midway through the process.

* ## verification_mode
  Required: **No**<br>
  Type: **string**<br>
  Accepted Values: **image_only, video_only, any**<br><br>
  This defines the types of proofs that are allowed for verification. In the case of video_only user will upload videos and if the verification mode is image_only, the user will upload images. Any mode allows both types of proofs.

* ## show_privacy_policy
  Required: **No**<br>
  Type: **string**<br>
  Accepted Values: **0, 1**<br><br>
  This key specifies whether that is a privacy policy shown to the user or not. If show_privacy_policy is 0 then privacy policy is not shown and vice versa.

* ## show_results
  Required: **No**<br>
  Type: **string**<br>
  Accepted Values: **0, 1**<br><br>
  This key specifies whether the verification results will be displayed to the user or not. If show_results is 0, then verification results are not shown and vice versa.

* ## show_consent
  Required: **No**<br>
  Type: **string**<br>
  Accepted Values: **0, 1**<br><br>
  This key specifies if the consent is shown to the user or not. If show_consent is 0, then the consent screen is not shown to the user and vice versa.

* ## allow_online
  Required: **No**<br>
  Type: **string**<br>
  Accepted Values: **0, 1**<br><br>
  This key specifies if the proof needs to be captured. The 1 value means that the user must capture the proof for verification. It has priority over allow_offline if both parameters are set to 0.

* ## allow_offline
  Required: **No**<br>
  Type: **string**<br>
  Accepted Values: **0, 1**<br><br>
  This key specifies if the proof needs to be uploaded. The 1 value means that the user must upload the proof for verification and vice versa.

* ## Face
  Face verification is considered the simplest type out of all. For this verification, the user has to upload a live image of their face as initial data.

  * ### proof
    An image captured or uploaded by user is converted to BASE64 and placed in this key. Uploaded proof is accepted only in given format and size.<br>
    Image Format: **JPG, JPEG, PNG, PDF Maximum: 16MB**<br>
    Video Format: **MP4/MOV Maximum: 20MB**<br>

  * ### allow_online
    Required: **No**<br>
    Type: **string**<br>
    Accepted Values: **0, 1**<br><br>
    This key specifies if the proof needs to be captured.

  * ### allow_offline
    Required: **No**<br>
    Type: **string**<br>
    Accepted Values: **0, 1**<br><br>
    This key specifies if the proof needs to be uploaded.

* ## Document or Document Two
  Shufti Pro provides document verification and can validate the identities through 3000+ types of documents including passports, ID Cards, driving licenses and debit/credit cards. You can opt for more than 1 document type as well.

  * ### proof
    Front side image of document, captured or uploaded by user, is converted to BASE64 and placed in this key. Uploaded proof is accepted only in given format and size.<br>
    Image Format: **JPG, JPEG, PNG, PDF Maximum: 16MB**<br>
    Video Format: **MP4/MOV Maximum: 20MB**<br>

  * ### additional_proof
    Backside image of document, captured or uploaded by user, is converted to BASE64 and placed in this key. Uploaded proof is accepted only in given format and size.<br>
    Image Format: **JPG, JPEG, PNG, PDF Maximum: 16MB**<br>
    Video Format: **MP4/MOV Maximum: 20MB**<br>

  * ### backside_proof_required
    Required: **No**<br>
    Type: **string**<br>
    Accepted values: **0, 1**<br>
    Default value: **0**<br>
    The 0 value means that the user has the option to skip the backside proof of the document provided and vice versa.

  * ### supported_types
    Required: **No**<br>
    Type: **Array**<br>
    You can provide two or more types of documents to verify the identity of the user. All supported types are listed below.
    * passport
    * id_card
    * driving_license
    * credit_or_debit_card

    **Example 1** ["driving_license"]<br>
    **Example 2** ["id_card", "credit_or_debit_card", "passport"]<br>

  * ### name
    Required: **No**<br>
    Type: **object**<br>
    In the name object, first_name and last_name are extracted from the document uploaded.

  * ### first_name
    Required: **No**<br>
    Type: **string**<br>
    Minimum: **2 characters**<br>
    Maximum: **32 characters**<br>
    Allowed Characters are alphabets, - (dash), comma, space, dot and single quotation mark.

    **Example** John'O Harra

  * ### middle_name
    Required: **No**<br>
    Type: **string**<br>
    Minimum: **2 characters**<br>
    Maximum: **32 characters**<br>

    Allowed Characters are alphabets, - (dash), comma, space, dot and single quotation mark.<br>
    **Example** Carter-Joe

  * ### last_name
    Required: **No**<br>
    Type: **string**<br>
    Minimum: **2 characters**<br>
    Maximum: **32 characters**<br>
    Allowed Characters are alphabets, - (dash), comma, space, dot and single quotation mark.<br>
    **Example** John, Hurricane Jr.

  * ### fuzzy_match
    Required: **No**<br>
    Type: **string**<br>
    Value Accepted: **1**<br>
    Provide 1 for enabling a fuzzy match of the name. Enabling fuzzy matching attempts to find a match which is not 100% accurate.

  * ### dob
    Required: **No**<br>
    Type: **string**<br>
    Format: **yyyy-mm-dd**<br>
    Leave empty to perform data extraction from uploaded documents. Please note that the date should be before today with a valid format. <br>
    **Example** 1990-12-31

  * ### gender
    Required: **No**<br>
    Type: **string**<br>
    Accepted values: **M,F,O,m,f,o**<br>
    Leave empty to perform data extraction from uploaded documents. Provide the gender which is given on the document.<br>
    **Example** M

  * ### document_number
    Required: **No**<br>
    Type: **string**<br>
    Minimum: **2 characters**<br>
    Maximum: **100 characters**<br>
    Leave empty to perform data extraction from the uploaded documents. Allowed Characters are numbers, alphabets, dots, dashes, spaces, underscores, and commas.<br>
    **Examples** 35201-0000000-0, ABC1234XYZ098

  * ### issue_date
    Required: **No**<br>
    Type: **string**<br>
    Format: **yyyy-mm-dd**<br>
    Leave empty to perform data extraction from the uploaded documents. Provide a valid date.<br>
    **Example** 2015-12-31

  * ### expiry_date
    Required: **No**<br>
    Type: **string**<br>
    Format: **yyyy-mm-dd**<br>

    Leave empty to perform data extraction from the uploaded documents.<br>
    **Example** 2025-12-31

  * ### allow_online
    Required: **No**<br>
    Type: **string**<br>
    Accepted Values: **0, 1**<br>
    This key specifies if the proof needs to be captured. The 1 value means that the user must capture the proof for verification and vice versa.

  * ### allow_offline
    Required: **No**<br>
    Type: **string**<br>
    Accepted Values: **0, 1**<br>

    This key specifies if the proof needs to be uploaded. The 1 value means that the user must upload the proof for verification.

  * ### fetch_enhanced_data
    Required: **No**<br>
    Type: **string**<br>
    Accepted value: **1**<br>
    Provide 1 for enabling enhanced data extraction for the document. Shufti Pro provides its customers with the facility of extracting enhanced data features using OCR technology. Now, instead of extracting just personal information input fields, Shufti Pro can fetch all the additional information comprising more than 100 data points from the official ID documents supporting 150 languages.

* ## Address Verification
  Addresses of clients can be verified from the document but they have to enter it before it can be verified from an applicable document image.
  * ### proof
    Front side image of document, captured or uploaded by user, is converted to BASE64 and placed in this key. Uploaded proof is accepted only in given format and size.<br>
    Image Format: **JPG, JPEG, PNG, PDF Maximum: 16MB**<br>
    Video Format: **MP4/MOV Maximum: 20MB**<br>

  * ### supported_types
    Required: **No**<br>
    Type: **Array**<br>
    Provide any one, two, or more document types in the supported_types parameter in the Address verification service. Following is the list of supported types for address verification.
    * id_card
    * passport
    * driving_license
    * utility_bill
    * bank_statement
    * rent_agreement
    * employer_letter
    * insurance_agreement
    * tax_bill

    **Example 1** [ "utility_bill" ]<br>
    **Example 2** [ "id_card", "bank_statement" ]

  * ### full_address
    Required: **No**<br>
    Type: **string**<br>
    Minimum: **2 characters**<br>
    Maximum: **250 characters**<br>
    Leave empty to perform data extraction from the uploaded proof. Allowed Characters are numbers, alphabets, dots, dashes, spaces, underscores, hashes and commas.

  * ### name
    Required: **No**<br>
    Format: **object**<br>
    In the name object used in the address service, first_name is required if you don't want to perform OCR of the name parameter. Other fields are optional.

  * ### first_name
    Required: **No**<br>
    Type: **string**<br>
    Minimum: **2 characters**<br>
    Maximum: **32 characters**<br>

    Allowed Characters are alphabets, - (dash), comma, space, dot and single quotation mark.<br>
    **Example** John'O Harra

  * ### middle_name
    Required: **No**<br>
    Type: **string**<br>
    Minimum: **2 characters**<br>
    Maximum: **32 characters**<br>
    Allowed Characters are alphabets, - (dash), comma, space, dot and single quotation mark.<br>
    **Example** Carter-Joe

  * ### last_name
    Required: **No**<br>
    Type: **string**<br>
    Minimum: **2 characters**<br>
    Maximum: **32 characters**<br>

    Allowed Characters are alphabets, - (dash), comma, space, dot and single quotation mark.<br>
    **Example** John, Hurricane Jr.

  * ### allow_online
    Required: **No**<br>
    Type: **string**<br>
    Accepted Values: **0, 1**<br>
    This key specifies if the proof needs to be captured. The 1 value means that the user must capture the proof for verification and vice versa.

  * ### allow_offline
    Required: **No**<br>
    Type: **string**<br>
    Accepted Values: **0, 1**<br>
    This key specifies if the proof needs to be uploaded. The 1 value means that the user must upload the proof for verification.

  * ### fuzzy_match
    Required: **No**<br>
    Type: **string**<br>
    Value Accepted: **1**<br>
    Provide 1 for enabling a fuzzy match of the name. Enabling fuzzy matching attempts to find a match which is not 100% accurate.

* ## consent
  Shufti Pro’s solution is capable of verifying identities through customized notes. Company documents, employee cards or any other personalized note can be authenticated by this module. Whether a handwritten or printed document, only one form of the document can be verified in this verification module.

  * ### proof
    Front side image of document, captured or uploaded by user, is converted to BASE64 and placed in this key. Uploaded proof is accepted only in given format and size.<br>
    Image Format: **JPG, JPEG, PNG, PDF Maximum: 16MB**<br>
    Video Format: **MP4/MOV Maximum: 20MB**<br>

  * ### supported_types
    Required: **No**<br>
    Type: **array**<br>
    Text provided in the consent verification can be verified by handwritten documents or printed documents. Following is the list of supported types for consent service:
    * handwritten
    * printed

    **Example 1** ["printed"]<br>
    **Example 2** ["printed", "handwritten"]

  * ### text
    Required: **Yes**<br>
    Type: **string**<br>
    Minimum: **2 characters**<br>
    Maximum: **100 characters**<br>
    Provide text in the string format which will be verified from the document which the end-user will provide us.

  * ### with_face
    Required: **No**<br>
    Type: **string**<br>
    Accepted Values: **0,1**<br>
    Default Value: **1**<br>

    This parameter is applicable if supported_type is handwritten and the default value is 1. If the value of with_face is 1 then a handwritten note will be accepted and the user needs to show his/her face along with the consent on a paper. If the value of with_face is 0 then a handwritten note is accepted with or without a face.

  * ### allow_online
    Required: **No**<br>
    Type: **string**<br>
    Accepted Values: **0, 1**<br>
    This key specifies if the proof needs to be captured. The 1 value means that the user must capture the proof for verification

  * ### allow_offline
    Required: **No**<br>
    Type: **string**<br>
    Accepted Values: **0, 1**<br>
    This key specifies if the proof needs to be uploaded. The 1 value means that the user must upload the proof for verification.
* ## phone
  Shufti Pro Phone verification services validate mobile numbers by sending a  code to its client number.<br>
  It’s essential for on-site verification and the client has to provide the phone number of the end-user, in addition to the verification code and the message that is to be forwarded to the end-user. Shufti Pro is only responsible for sending the message along with the verification code to the end-user as well as verifying the code entered by the end-user.
  * ### phone_number
    Required: **No**<br>
    Type: **string**<br>
    Minimum: **2 characters**<br>
    Maximum: **64 characters**<br>
    Allowed Characters, numbers and plus sign at the beginning. Provide a valid customer’s phone number with country code.

  * ### random_code
    Required: **No**<br>
    Type: **string**<br>
    Minimum: **2 characters**<br>
    Maximum: **10 characters**<br>
    Provide a random code. If this field is missing or empty. Shufti Pro will generate a random code.

  * ### text
    Required: **No**<br>
    Type: **string**<br>
    Minimum: **2 characters**<br>
    Maximum: **100 characters**<br>

    Provide a short description and random code in this field. This message will be sent to customers. This field should contain random_code. If the random_code field is empty then Shufti Pro will generate a random code and append the code with this message at the end.

* ## background_checks
  It is a verification process that will require the full name of the end-user in addition to the date of birth. Shufti Pro will perform AML background screening based on this information. The name and dob keys will be extracted from the document service if these keys are empty.
  * ### name
    Required: **No**<br>
    Format: **object**<br>
    In the name object used in the background checks service, first_name is required and other fields are optional.

  * ### first_name
    Required: **No**<br>
    Type: **string**<br>
    Minimum: **2 characters**<br>
    Maximum: **32 characters**<br>
    Allowed Characters are alphabets, - (dash), comma, space, dot and single quotation mark.<br>
    **Example** John'O Harra

  * ### middle_name
    Required: **No**<br>
    Type: **string**<br>
    Minimum: **2 characters**<br>
    Maximum: **32 characters**<br>
    Allowed Characters are alphabets, - (dash), comma, space, dot and single quotation mark.<br>
    **Example** Carter-Joe

  * ### last_name
    Required: **No**<br>
    Type: **string**<br>
    Minimum: **2 characters**<br>
    Maximum: **32 characters**<br>
    Allowed Characters are alphabets, - (dash), comma, space, dot and single quotation mark.<br>
    **Example** John, Hurricane Jr.

  * ### dob
    Required: **No**<br>
    Type: **string**<br>
    Format: **yyyy-mm-dd**<br>
    Provide a valid date. Please note that the date should be before today.<br>
    **Example** 1990-12-31

## Customisations
ShuftiPro supports a set of customisation options that will influence the appearance of the sdk. The color of buttons and font can be customised by changing the values of corresponding variables in [color.xml.](https://github.com/shuftipro/Android_Core_SDK/blob/main/Core%20SDK/ShuftiProCore/app/src/main/res/values/colors.xml)<br>
The strings of SDK can also be customised through [strings.xml](https://github.com/shuftipro/Android_Core_SDK/blob/main/Core%20SDK/ShuftiProCore/app/src/main/res/values/strings.xml) class. Translations of choice can be added in the provided [strings.xml](https://github.com/shuftipro/Android_Core_SDK/blob/main/Core%20SDK/ShuftiProCore/app/src/main/res/values/strings.xml)<br>
To apply and use dark theme/mode in SDK, initialise the SDK with provided parameter in config object.

ShuftiPro supports a set of customization options that will influence the appearance of the button, font Color and verification flow modal. You can easily customize the all options by adding these keys in config object.To apply and use dark theme/mode in SDK, initialise the SDK with provided parameter in config object.

        Map<String,Object> configObj = {
          ...
             "dark_mode" : false,
        };

* ## iOS
  To customise the colors of your iOS module you can use hex values of choice in the config object.

        Map<String,Object> configObj = {
          ...
          "font_color": "#263B54",
          "button_text_color": "#FFFFFF",
          "button_background_color": "#1F5AF6",
        }


* ## Localization <br>
  Add your own Localizable.strings file to your ios project using standard iOS localization mechanism. To change a specific text, copy file from [here](https://github.com/shuftipro/Flutter-SDK/tree/main/ios/Runner/en.lproj/Localizable.strings) and override corresponding keys.

* ## Android
  To customise the UI of your Android module you can add the related files in **"android>app>src>main>res>values"** directory.

  * ## Colors <br>
    To change the colors add [**colors.xml**](https://github.com/shuftipro/Flutter-SDK/tree/main/android/app/src/main/res/values/colors.xml) file in [**values**](https://github.com/shuftipro/Flutter-SDK/tree/main/android/app/src/main/res/values) directory and override following variables:

        <color name="light_button_color">#2B6AD8</color>
        <color name="light_text_color">#1D2C42</color>
        <color name="dark_button_color">#FF7A77</color>
        <color name="dark_text_color">#ffffff</color>
        <color  name="button_text_color">#FFFFFFFF</color>

  * ## Localization <br>
    To customise the text of SDK, add **strings.xml** file in [**values**](https://github.com/shuftipro/Flutter-SDK/tree/main/android/app/src/main/res/values) directory and override the corresponding string variables defined [here](https://github.com/shuftipro/Flutter-SDK/tree/main/android/app/src/main/res/values/strings.xml).

## HTTP Codes
Following is a list of HTTP codes which are generated in responses by Shufti Pro Verification API.
HTTP code     | HTTP message         | Message        |                                   
--------------|----------------------| -------------- |
200           | OK                   | success                                    
400           | Bad Request          | bad request: one or more parameter is invalid or missing
401           | Unauthorized         | unauthorized: invalid signature key provided in the request
402           | Request Failed       | invalid request data: missing required parameters
403           | Forbidden            | forbidden: service not allowed
404           | Not Found            | resource not found
409           | Conflict             | conflicting data: already exists
500           | Server Error         | internal server error

<br>


## Response Logging
Response of the verification will be returned by the function. You can save or do whatever you want with the response.

```sh

        var response = await ShuftiproSdk.sendRequest(authObject: AuthObject,
          createdPayload: createdPayload, configObject: ConfigObject);

```

## Status Response
The Shufti Pro Verification API will send a JSON response if a status request is made.
Reference: This is the user’s unique request reference provided at the time of request, in order for the unique response to be identified.
Event: The request event shows the status of the user's request and is different for every response. For more information, click here
Note: request.invalid response with HTTP status code 400 means the request is invalid.
Sample Response
{
"reference": "17374217",
"event": "request.declined",
"error": "",
"verification_url": ""
}

## Supported Document Types
Address | Document | 
--------------- | ------------ | 
id_card | id_card
passport  | passport
driving_license | driving_lisence
utility_bill | credit_or_debit_card
bank_statement |
rent_agreement |
employer_letter |
insurance_agreement |
tax_bill |


## Test IDs
Shufti Pro provides users with a number of test documents. Customers may use these to test the demo, instead of presenting their actual information.

[![](https://api.shuftipro.com/api/docs/images/test_ids/real_ID_card-01.png)](https://api.shuftipro.com/api/docs/images/test_ids/real_ID_card-01.png)

[![](https://api.shuftipro.com/api/docs/images/test_ids/fake_ID_card-02.png)](https://api.shuftipro.com/api/docs/images/test_ids/fake_ID_card-02.png)

## Contact
If you have any queries regarding the implementation of SDK, please feel free to contact Shufti Pro [tech support](mailto:tech@shuftipro.com).

## Copyright
2017-22 © Shufti Pro Ltd.
