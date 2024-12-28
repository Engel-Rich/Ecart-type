
import 'package:ecartify/util/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:ecartify/util/dimensions.dart';


class CustomLoaderWidget extends StatelessWidget {
    const CustomLoaderWidget({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return SizedBox(
            height: Get.height / 1.3,
            child: Stack(
                children: [
                    Align(
                        alignment: Alignment.center,
                        child: Container(
                            height: 80,width: 80, decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault)
                            ),
                            child: const Center(
                                child: SpinKitWave(
                                    color: ColorResources.primaryColor,
                                    size: 40.0,
                                ),
                            )
                        ),
                    ),
                ],
            ),
        );
    }
}
