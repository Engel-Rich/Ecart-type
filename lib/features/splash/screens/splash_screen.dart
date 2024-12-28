import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ecartify/features/auth/controllers/auth_controller.dart';
import 'package:ecartify/features/splash/controllers/splash_controller.dart';
import 'package:ecartify/util/images.dart';
import 'package:ecartify/features/auth/screens/log_in_screen.dart';
import 'package:ecartify/features/dashboard/screens/nav_bar_screen.dart';

class SplashScreen extends StatefulWidget {
    const SplashScreen({Key? key}) : super(key: key);

    @override
    SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
    final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
    late StreamSubscription<List<ConnectivityResult>> _onConnectivityChanged;
    final Connectivity _connectivity = Connectivity();

    @override
    void initState() {
        super.initState();
        initConnectivity();
        bool firstTime = true;
        // _onConnectivityChanged = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
        //     if(!firstTime) {
        //         bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;
        //         isNotConnected ? const SizedBox() : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        //         ScaffoldMessenger.of(context).showSnackBar(
        //             SnackBar(
        //                 backgroundColor: isNotConnected ? Colors.red : Colors.green,
        //                 duration: Duration(seconds: isNotConnected ? 6000 : 3),
        //                 content: Text(
        //                     isNotConnected ? 'no_internet_connection'.tr : 'connected'.tr,
        //                     textAlign: TextAlign.center,
        //                 ),
        //             )
        //         );
        //         if(!isNotConnected) {
        //             _route();
        //         }
        //     }
        //     firstTime = false;
        // });
        _onConnectivityChanged = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

        Get.find<SplashController>().initSharedData();
       _route();

    }

    Future<void> initConnectivity() async {
        late List<ConnectivityResult> connectionStatus;
        try {
            connectionStatus = await _connectivity.checkConnectivity();
        } on PlatformException catch (e) {
            print(e.toString());
            connectionStatus = [ConnectivityResult.none];
        }
        _updateConnectionStatus(connectionStatus);
    }

    Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
        print("Result: $result");

        // Check if the result contains the required connectivity types
        bool isNotConnected = !(result.contains(ConnectivityResult.wifi) || result.contains(ConnectivityResult.mobile));

        print("Connection status: $isNotConnected");

        // Hide the current SnackBar if there is no connectivity
        if (isNotConnected) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }

        // Show a SnackBar based on connection status
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: isNotConnected ? Colors.red : Colors.green,
                duration: Duration(seconds: isNotConnected ? 6000 : 3),
                content: Text(
                    isNotConnected ? 'no_internet_connection'.tr : 'connected'.tr,
                    textAlign: TextAlign.center,
                ),
            ),
        );

        // If connected to WiFi or mobile, navigate to the next route
        if (!isNotConnected) {
            _route();
        }
    }


    @override
    void dispose() {
        _onConnectivityChanged.cancel();
        super.dispose();
    }

    void _route() {
        Get.find<SplashController>().getConfigData().then((value) {
            if( Get.find<SplashController>().configModel != null){
                Timer(const Duration(seconds: 1), () async {
                if (Get.find<AuthController>().isLoggedIn()) {
                    Get.offAll(()=> const NavBarScreen());
                } else {
                    Get.offAll(()=> const LogInScreen());
                }
                });
            }
        });
    }

    @override
    Widget build(BuildContext context) {
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;
        return Scaffold(
            key: _globalKey,
            body: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Images.background),
                        fit: BoxFit.cover,
                    ),
                ),
                width: width,
                height: height,
                child: Center(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                            SizedBox(width: width*.7, child: Image.asset(Images.splashLogo, height: 175)),
                        ],
                    ),
                ),
            ),
        );
    }
}
