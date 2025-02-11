import 'dart:async';
import 'dart:io';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ecartify/features/langulage/controllers/localization_controller.dart';
import 'package:ecartify/common/controllers/theme_controller.dart';
import 'package:ecartify/helper/route_helper.dart';
import 'package:ecartify/theme/dark_theme.dart';
import 'package:ecartify/theme/light_theme.dart';
import 'package:ecartify/util/app_constants.dart';
import 'package:ecartify/util/messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';
import 'helper/get_di.dart' as di;


Future<void> main() async {
    if(GetPlatform.isIOS || GetPlatform.isAndroid) {
        HttpOverrides.global = MyHttpOverrides();
    }
    setPathUrlStrategy();
    WidgetsFlutterBinding.ensureInitialized();
    await FlutterDownloader.initialize(
        debug: true ,
        ignoreSsl: true
    );
    await Permission.location.request();
    await Permission.bluetooth.request();
    await Permission.bluetoothConnect.request();
    await Permission.bluetoothScan.request();
    Map<String, Map<String, String>> languages = await di.init();

    runApp(MyApp(languages: languages));
}

class MyApp extends StatelessWidget {
    final Map<String, Map<String, String>>? languages;

    const MyApp({Key? key, required this.languages}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        final Size size = MediaQuery.sizeOf(context);

        return GetBuilder<ThemeController>(
            builder: (themeController) {
                return GetBuilder<LocalizationController>(
                    builder: (localizeController) {
                        return MediaQuery(
                            data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(size.width < 380 ?  0.8 : 1)),
                            child: GetMaterialApp(
                                title: AppConstants.appName,
                                debugShowCheckedModeBanner: false,
                                navigatorKey: Get.key,
                                theme: themeController.darkTheme ? dark : light,
                                locale: localizeController.locale,
                                translations: Messages(languages: languages),
                                fallbackLocale: Locale(AppConstants.languages[0].languageCode!, AppConstants.languages[0].countryCode),
                                initialRoute: RouteHelper.splash,
                                getPages: RouteHelper.routes,
                                defaultTransition: Transition.topLevel,
                                transitionDuration: const Duration(milliseconds: 500),
                            ),
                        );
                    },
                );
            },
        );
    }
}

class MyHttpOverrides extends HttpOverrides {
    @override
    HttpClient createHttpClient(SecurityContext? context) {
        return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    }
}