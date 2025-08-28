import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:madhang/core/constants/api_constant.dart';
import 'package:permission_handler/permission_handler.dart';

import 'core/data/database/dio/dio/dio_client.dart';
import 'core/data/database/dio/dio/logging_interceptor.dart';
import 'core/services/theme_service.dart';
import 'routes/route_settings.dart';

late DioClient dioClient;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  dioClient = DioClient(
   ApiConstants.baseUrl,
    null,
    loggingInterceptor: LoggingInterceptor(),
  );
  Get.put<DioClient>(dioClient);
  // Request location permission at startup
  await _requestPermissions();
  runApp(const MyApp());
}

Future<void> _requestPermissions() async {
  var status = await Permission.locationWhenInUse.status;
  if (!status.isGranted) {
    await Permission.locationWhenInUse.request();
  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeService themeService = Get.put(ThemeService());

    return Obx(() => MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: themeService.lightTheme,
      // darkTheme: themeService.darkTheme,
      themeMode: themeService.themeMode,
      routerConfig: router,
    ));
  }
}