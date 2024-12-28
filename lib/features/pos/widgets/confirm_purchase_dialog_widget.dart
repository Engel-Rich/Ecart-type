import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecartify/util/color_resources.dart';
import 'package:ecartify/util/dimensions.dart';
import 'package:ecartify/util/images.dart';
import 'package:ecartify/common/widgets/custom_button_widget.dart';
class ConfirmPurchaseDialogWidget extends StatelessWidget {
    final Function? onYesPressed;
    const ConfirmPurchaseDialogWidget({Key? key, required this.onYesPressed}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
            child: Container(
                padding: const EdgeInsets.all(Dimensions.paddingSizeExtraLarge),
                height: 210,
                child: Column(
                    children: [
                        SizedBox(
                            width: 70,
                            height: 70,
                            child: Image.asset(Images.confirmPurchase),
                        ),
                        Text('confirm_purchase'.tr),
                        Padding(
                            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                            child: SizedBox(
                                height: 40,
                                child: Row(
                                    children: [
                                        Expanded(
                                            child: CustomButtonWidget(
                                                buttonText: 'cancel'.tr,
                                                buttonColor: ColorResources.revenueCardOThreeColor(),textColor: ColorResources.whiteColor,isClear: true,
                                                onPressed: ()=>Get.back()
                                            )
                                        ),
                                        const SizedBox(width: Dimensions.paddingSizeDefault),
                                        Expanded(
                                            child: CustomButtonWidget(
                                                buttonText: 'yes'.tr,
                                                onPressed: (){
                                                    onYesPressed!();
                                                    Get.back();
                                                },
                                                buttonColor: ColorResources.gradientColor,textColor: ColorResources.whiteColor
                                            )
                                        ),
                                    ],
                                ),
                            ),
                        )

                    ],
                ),
            )
        );
    }
}
