// ignore_for_file: body_might_complete_normally_catch_error, use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_upgrade_version/flutter_upgrade_version.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
// import 'package:image_cropper/image_cropper.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart'as url_launcher;
import 'package:xml/xml.dart' as xml;
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart' as custom_tabs;



import '../../constants/value_constant.dart';
import '../../utils/logger.dart';


import 'package:open_file/open_file.dart' as open_file;
// ignore: depend_on_referenced_packages
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart'
    as path_provider_interface;

Future<String?> getFbToken() async {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  try {
    String? token = defaultTargetPlatform == TargetPlatform.iOS
        ? await firebaseMessaging.getAPNSToken() ?? 'unable to get token [macos]'
        : await firebaseMessaging.getToken();
    debugPrint('FirebaseMessaging token: $token');
    return token;
  } catch (e) {
    debugPrint('Error getting FirebaseMessaging token: $e');
    return null;
  }
}


Future<File?> captureAndSave({
  required GlobalKey globalKey,
  String? fileName,
}) async {
  RenderRepaintBoundary boundary =
      globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  ui.Image image = await boundary.toImage(pixelRatio: 1.0);
  ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  Uint8List? pngBytes = byteData?.buffer.asUint8List();

  // Save the image or use it as needed
  // Example: save to file
  // File('example.png').writeAsBytes(pngBytes);

  // Example: show the image in a dialog
  if (pngBytes != null) {
    final filePath =
        await createFilePath(fileName: '${fileName ?? 'captured'}.png');
    if (filePath != null) {
      File(filePath).writeAsBytes(pngBytes);
      return File(filePath);
    }
  }
  return null;
}

Future<String?> createFilePath({
  required String fileName,
  String? dirName,
}) async {
  final directory = await getTemporaryDirectory();
  return "${directory.path}/${dirName ?? ''}${dirName != null ? '/' : ''}$fileName";
}

exitTheApp() async {
  if (Platform.isAndroid) {
    SystemNavigator.pop();
  } else if (Platform.isIOS) {
    exit(0);
  } else {
    print('App exit failed!');
  }
}

// Future<CroppedFile?> cropImage(String path) async {
//   var context = Get.context!;
//   final croppedFile = await ImageCropper().cropImage(
//     sourcePath: path,
//     compressFormat: ImageCompressFormat.jpg,
//     compressQuality: 100,
//     uiSettings: [
//       AndroidUiSettings(
//           toolbarTitle: 'Resize your image',
//           toolbarColor: getTheme(context).appLogoColor,
//           toolbarWidgetColor: Colors.white,
//           initAspectRatio: CropAspectRatioPreset.original,
//           lockAspectRatio: false),
//       IOSUiSettings(
//         title: 'Resize your image',
//         showActivitySheetOnDone: false,
//         showCancelConfirmationDialog: true,
//         cancelButtonTitle: 'Cancel',
//         doneButtonTitle: 'Update Profile',
//         hidesNavigationBar: true,
//         resetAspectRatioEnabled: true,
//         aspectRatioPickerButtonHidden: true,
//         aspectRatioLockEnabled: true,
//         aspectRatioLockDimensionSwapEnabled: true,
//       ),
//       WebUiSettings(
//         context: context,
//         presentStyle: CropperPresentStyle.dialog,
//         boundary: const CroppieBoundary(
//           width: 520,
//           height: 520,
//         ),
//         viewPort:
//             const CroppieViewPort(width: 480, height: 480, type: 'circle'),
//         enableExif: true,
//         enableZoom: true,
//         showZoomer: true,
//       ),
//     ],
//   );
//   return croppedFile;
// }

///save image to local
Future<String> downloadAndSaveFile(String url, String fileName) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final String filePath = '${directory.path}/$fileName';
  final http.Response respose = await http.get(Uri.parse(url));
  final File file = File(filePath);
  await file.writeAsBytes(respose.bodyBytes);
  return filePath;
}

///To save the Excel file in the Mobile and Desktop platforms.
Future<void> saveFileAndLaunch(List<int> bytes, String fileName) async {
  String? path;
  if (Platform.isAndroid ||
      Platform.isIOS ||
      Platform.isLinux ||
      Platform.isWindows) {
    if (Platform.isAndroid) {
      final Directory? directory = await getExternalStorageDirectory();
      if (directory != null) {
        path = directory.path;
      }
    } else {
      final Directory directory = await getApplicationSupportDirectory();
      path = directory.path;
    }
  } else {
    path = await path_provider_interface.PathProviderPlatform.instance
        .getApplicationSupportPath();
  }

  final String fileLocation =
      Platform.isWindows ? '$path\\$fileName' : '$path/$fileName';
  final File file = File(fileLocation);
  await file.writeAsBytes(bytes, flush: true);

  if (Platform.isAndroid || Platform.isIOS) {
    var res = await open_file.OpenFile.open(fileLocation);
    pl('open_file.OpenFile.open: $res');
  } else if (Platform.isWindows) {
    var res =
        await Process.run('start', <String>[fileLocation], runInShell: true);
    pl('saveFileAndLaunch Process.run: ${res.exitCode}');
  } else if (Platform.isMacOS) {
    var res =
        await Process.run('open', <String>[fileLocation], runInShell: true);
    pl('saveFileAndLaunch Process.run: ${res.exitCode}');
  } else if (Platform.isLinux) {
    var res =
        await Process.run('xdg-open', <String>[fileLocation], runInShell: true);
    pl('saveFileAndLaunch Process.run: ${res.exitCode}');
  }
}

///xml
Future<Map<String, String>> loadStringXml(String path) async {
  String xmlString = await rootBundle.loadString(path);
  Map<String, String> stringMap = parseStringXml(xmlString);
  return stringMap;
}

Map<String, String> parseStringXml(String xmlString) {
  var document = xml.XmlDocument.parse(xmlString);
  var stringNodes = document.findAllElements('string').toList();
  Map<String, String> stringMap = {};
  logger.i('parseStringXml stringNodes: $stringNodes');
  for (var node in stringNodes) {
    var name = node.getAttribute('name');
    var value = node.innerText;
    if (name != null) {
      stringMap[name] = value.validate();
    }
  }

  return stringMap;
}


Future<void> commonLaunchUrl(String address,
    {url_launcher.LaunchMode launchMode = url_launcher.LaunchMode.inAppWebView}) async {
  await url_launcher.launchUrl(Uri.parse(address), mode: launchMode).catchError((e) {
    toast('language.invalidURL}: $address');
  });
}

void launchCall(String? url,
    {url_launcher.LaunchMode launchMode = url_launcher.LaunchMode.inAppWebView}) {
  if (url.validate().isNotEmpty) {
    if (isIOS) {
      commonLaunchUrl('tel://${url!}',
          launchMode: url_launcher.LaunchMode.externalApplication);
    } else {
      commonLaunchUrl('tel:${url!}',
          launchMode: url_launcher.LaunchMode.externalApplication);
    }
  }
}

void launchMap(String? url) {
  if (url.validate().isNotEmpty) {
    commonLaunchUrl(GOOGLE_MAP_PREFIX + url!,
        launchMode: url_launcher.LaunchMode.externalApplication);
  }
}

void launchMail(String url) {
  if (url.validate().isNotEmpty) {
    commonLaunchUrl('$MAIL_TO$url', launchMode: url_launcher.LaunchMode.externalApplication);
  }
}

void checkIfLink(BuildContext context, String value, {String? title}) {
  if (value.validate().isEmpty) return;

  String temp = parseHtmlString(value.validate());
  if (temp.startsWith("https") || temp.startsWith("http")) {
    launchUrlCustomTab(temp.validate());
  } else if (temp.validateEmail()) {
    launchMail(temp);
  } else if (temp.validatePhone() || temp.startsWith('+')) {
    launchCall(temp);
  } else {
    // HtmlWidget(postContent: value, title: title).launch(context);
  }
}

void launchUrlCustomTab(String url) async {
  if (url.isNotEmpty) {
    final uri = Uri.parse(url);

    if (isMacOS || isWindows) {
      // Use url_launcher for desktop
      if (!await url_launcher.launchUrl(uri, mode: url_launcher.LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
      return;
    }

    // Use flutter_custom_tabs for Android/iOS
    await custom_tabs.launchUrl(
      uri,
      customTabsOptions: const custom_tabs.CustomTabsOptions(
        showTitle: true,
        shareState: custom_tabs.CustomTabsShareState.on,
        instantAppsEnabled: true,
      ),
      safariVCOptions: const custom_tabs.SafariViewControllerOptions(
        entersReaderIfAvailable: true,
        barCollapsingEnabled: true,
        dismissButtonStyle: custom_tabs.SafariViewControllerDismissButtonStyle.done,
      ),
    );
  }
}

List<LanguageDataModel> languageList() {
  return [
    LanguageDataModel(
        id: 1,
        name: 'English',
        languageCode: 'en',
        fullLanguageCode: 'en-US',
        flag: 'assets/flag/ic_us.png'),
    LanguageDataModel(
        id: 2,
        name: 'Hindi',
        languageCode: 'hi',
        fullLanguageCode: 'hi-IN',
        flag: 'assets/flag/ic_india.png'),
    LanguageDataModel(
        id: 3,
        name: 'Arabic',
        languageCode: 'ar',
        fullLanguageCode: 'ar-AR',
        flag: 'assets/flag/ic_ar.png'),
    LanguageDataModel(
        id: 4,
        name: 'French',
        languageCode: 'fr',
        fullLanguageCode: 'fr-FR',
        flag: 'assets/flag/ic_fr.png'),
    LanguageDataModel(
        id: 5,
        name: 'German',
        languageCode: 'de',
        fullLanguageCode: 'de-DE',
        flag: 'assets/flag/ic_de.png'),
  ];
}

InputDecoration inputDecoration(BuildContext context,
    {Widget? prefixIcon, String? labelText, double? borderRadius}) {
  return InputDecoration(
    contentPadding:
        const EdgeInsets.only(left: 12, bottom: 10, top: 10, right: 10),
    labelText: labelText,
    labelStyle: secondaryTextStyle(),
    alignLabelWithHint: true,
    prefixIcon: prefixIcon,
    enabledBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? DEFFAULT_RADIUS),
      borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? DEFFAULT_RADIUS),
      borderSide: const BorderSide(color: Colors.red, width: 0.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? DEFFAULT_RADIUS),
      borderSide: const BorderSide(color: Colors.red, width: 1.0),
    ),
    errorMaxLines: 2,
    border: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? DEFFAULT_RADIUS),
      borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? DEFFAULT_RADIUS),
      borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
    ),
    errorStyle: primaryTextStyle(color: Colors.red, size: 12),
    focusedBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? DEFFAULT_RADIUS),
      // borderSide: BorderSide(color: appLogoColor, width: 0.0),
    ),
    filled: true,
    fillColor: context.cardColor,
  );
}

String parseHtmlString(String? htmlString) {
  return parse(parse(htmlString).body!.text).documentElement!.text;
}

String formatDate(String? dateTime,
    {String format = DATE_FORMAT_1,
    bool isFromMicrosecondsSinceEpoch = false,
    bool isLanguageNeeded = true}) {
  final parsedDateTime = isFromMicrosecondsSinceEpoch
      ? DateTime.fromMicrosecondsSinceEpoch(dateTime.validate().toInt() * 1000)
      : DateTime.parse(dateTime.validate());

  return DateFormat(format).format(parsedDateTime);
}


String calculateTimer(int secTime) {
  int hour = 0, minute = 0, seconds = 0;

  hour = secTime ~/ 3600;

  minute = ((secTime - hour * 3600)) ~/ 60;

  seconds = secTime - (hour * 3600) - (minute * 60);

  String hourLeft = hour.toString().length < 2 ? "0$hour" : hour.toString();

  String minuteLeft =
      minute.toString().length < 2 ? "0$minute" : minute.toString();

  String minutes = minuteLeft == '00' ? '01' : minuteLeft;

  String result = "$hourLeft:$minutes";

  log(seconds);

  return result;
}

String getPaymentStatusText(String? status, String? method) {
  // if (status!.isEmpty) {
  //   return "language.lblPending";
  // } else if (status == SERVICE_PAYMENT_STATUS_PAID ||
  //     status == PENDING_BY_ADMIN) {
  //   return "language.pa"id;
  // } else if (status == SERVICE_PAYMENT_STATUS_ADVANCE_PAID) {
  //   return language.advancePaid;
  // } else if (status == SERVICE_PAYMENT_STATUS_PENDING &&
  //     method == PAYMENT_METHOD_COD) {
  //   return "language.pendingApproval";
  // } else if (status == SERVICE_PAYMENT_STATUS_PENDING) {
  //   return "language.lblPending";
  // } else {
  //   return "";
  // }

  return "";
}

String buildPaymentStatusWithMethod(String status, String method) {
  // return '${getPaymentStatusText(status, method)}${(status == SERVICE_PAYMENT_STATUS_PAID || status == PENDING_BY_ADMIN) ? ' language.by} ${method.capitalizeFirstLetter()}' : ''}';
  return "";
}

///TODO: check if this is needed
// Color getRatingBarColor(int rating, {bool showRedForZeroRating = false}) {
//   if (rating == 1 || rating == 2) {
//     return showRedForZeroRating ? showRedForZeroRatingColor : ratingBarColor;
//   } else if (rating == 3) {
//     return const Color(0xFFff6200);
//   } else if (rating == 4 || rating == 5) {
//     return const Color(0xFF73CB92);
//   } else {
//     return showRedForZeroRating ? showRedForZeroRatingColor : ratingBarColor;
//   }
// }

///TODO: check if this is needed
// Future<FirebaseRemoteConfig> setupFirebaseRemoteConfig() async {
//   final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

//   try {
//     remoteConfig.setConfigSettings(RemoteConfigSettings(
//         fetchTimeout: Duration.zero, minimumFetchInterval: Duration.zero));
//     await remoteConfig.fetch();
//     await remoteConfig.fetchAndActivate();
//   } catch (e) {
//     throw "language.firebaseRemoteCannotBe";
//   }
//   if (remoteConfig.getString(USER_CHANGE_LOG).isNotEmpty) {
//     await compareValuesInSharedPreference(
//         USER_CHANGE_LOG, remoteConfig.getString(USER_CHANGE_LOG));
//   }
//   if (remoteConfig.getString(USER_CHANGE_LOG).validate().isNotEmpty) {
//     remoteConfigDataModel = RemoteConfigDataModel.fromJson(
//         jsonDecode(remoteConfig.getString(USER_CHANGE_LOG)));

//     await compareValuesInSharedPreference(
//         IN_MAINTENANCE_MODE, remoteConfigDataModel.inMaintenanceMode);

//     if (isIOS) {
//       await compareValuesInSharedPreference(
//           HAS_IN_REVIEW, remoteConfig.getBool(HAS_IN_APP_STORE_REVIEW));
//     } else if (isAndroid) {
//       await compareValuesInSharedPreference(
//           HAS_IN_REVIEW, remoteConfig.getBool(HAS_IN_PLAY_STORE_REVIEW));
//     }
//   }

//   return remoteConfig;
// }




// void doIfLoggedIn(BuildContext context, VoidCallback callback) {
//   if (appStore.isLoggedIn) {
//     callback.call();
//   } else {
//     const AuthScreen(returnExpected: true, returnPath: '')
//         .launch(context)
//         .then((value) {
//       if (value ?? false) {
//         callback.call();
//       }
//     });
//   }
// }

Widget mobileNumberInfoWidget() {
  return RichTextWidget(
    list: [
      TextSpan(
          text: "language.addYourCountryCode", style: secondaryTextStyle()),
      TextSpan(text: ' "91-", "236-" ', style: boldTextStyle(size: 12)),
      TextSpan(
        text: ' (language.help})',
        // style: boldTextStyle(size: 12, color: appLogoColor),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            launchUrlCustomTab("https://countrycode.org/");
          },
      ),
    ],
  );
}

Future<bool> compareValuesInSharedPreference(String key, dynamic value) async {
  bool status = false;
  if (value is String) {
    status = getStringAsync(key) == value;
  } else if (value is bool) {
    status = getBoolAsync(key) == value;
  } else if (value is int) {
    status = getIntAsync(key) == value;
  } else if (value is double) {
    status = getDoubleAsync(key) == value;
  }

  if (!status) {
    await setValue(key, value);
  }
  return status;
}

/// donwload pdf file from url and convert to uint8list
Future<Uint8List?> getPdfBytes(String url) async {
  final Dio dio = Dio();
  try {
    final Response response = await dio.get(
      url,
      options: Options(responseType: ResponseType.bytes),
      onReceiveProgress: (received, total) {
        if (total != -1) {
          print('Downloaded ${(received / total * 100).toStringAsFixed(0)}%');
        }
      },
    );
    pl('getPdfBytes response: $response');
    return response.data;
  } catch (e) {
    print('Error downloading PDF: $e');
  }
  return null;
}

/// download pdf file from url and convert to uint8list and return process completion stream
class ProgressData {
  bool get isCompleted => received == total;
  final bool status;
  final double? received;
  final double? total;
  final Uint8List? data;
  final Object? error;

  ProgressData(this.received, this.total, this.data, this.status, {this.error});
}

Stream<ProgressData> getPdfBytesStream(String url) async* {
  final Dio dio = Dio();
  double? _received = 0;
  double? _total = 0;
  StreamController<ProgressData> progressStream =
      StreamController<ProgressData>();
  try {
    final Future<Response> response = dio.get(
      // 'https://sample-videos.com/video321/mp4/240/big_buck_bunny_240p_30mb.mp4',
      url,
      options: Options(responseType: ResponseType.bytes),
      onReceiveProgress: (received, total) {
        if (total != -1) {
          _received = received.toDouble();
          _total = total.toDouble();
          // pl('Downloaded ${(received / total * 100).toStringAsFixed(0)}%');
          progressStream.add(
              ProgressData(received.toDouble(), total.toDouble(), null, false));
        }
      },
    );
    response.then((value) =>
        progressStream.add(ProgressData(_received, _total, value.data, true)));

    // print('getPdfBytes response: ${response.statusCode}');
    // Yield final result with data
    // progressStream
    //     .add(ProgressData(_received, _total, (await response).data, true));
    yield* progressStream.stream;
  } catch (e) {
    yield ProgressData(_received, _total, null, false, error: e);
  }
}

Future<File?> pickImage({bool isCamera = false}) async {
  final pickedImage = await ImagePicker()
      .pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);
  pl('pickedImage: ${pickedImage?.name} ${pickedImage?.path} ${await pickedImage?.length()} ${pickedImage?.mimeType} ${pickedImage?.hashCode} }');
  return pickedImage != null ? File(pickedImage.path) : null;
}

Future<List<File>> getMultipleImageSource({bool isCamera = true}) async {
  final pickedImage = await ImagePicker().pickMultiImage();
  return pickedImage.map((e) => File(e.path)).toList();
}

////constants

//region DateFormat
const DATE_FORMAT_1 = 'dd-MMM-yyyy hh:mm a';
const DATE_FORMAT_2 = 'd MMM, yyyy';
const DATE_FORMAT_3 = 'dd-MMM-yyyy';
const HOUR_12_FORMAT = 'hh:mm a';
const DATE_FORMAT_4 = 'dd MMM';
const DATE_FORMAT_7 = 'yyyy-MM-dd';
const DATE_FORMAT_8 = 'd MMM, yyyy hh:mm a';
const YEAR = 'yyyy';
const BOOKING_SAVE_FORMAT = "yyyy-MM-dd kk:mm:ss";
//endregion

//region Mail And Tel URL
const MAIL_TO = 'mailto:';
const TEL = 'tel:';
const GOOGLE_MAP_PREFIX = 'https://www.google.com/maps/search/?api=1&query=';

SlideConfiguration sliderConfigurationGlobal =
    SlideConfiguration(duration: 400.milliseconds, delay: 50.milliseconds);
