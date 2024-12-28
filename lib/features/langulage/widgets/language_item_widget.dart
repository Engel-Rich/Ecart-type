import 'package:ecartify/util/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecartify/features/langulage/controllers/localization_controller.dart';
import 'package:ecartify/features/langulage/domain/models/language_model.dart';
import 'package:ecartify/util/dimensions.dart';
import 'package:ecartify/util/styles.dart';
import 'package:ecartify/common/widgets/custom_on_tap_widget.dart';

class LanguageItemWidget extends StatelessWidget {
  final LanguageModel languageModel;
  final LocalizationController localizationController;
  final int index;
  const LanguageItemWidget({Key? key, required this.languageModel, required this.localizationController, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 800 : 200]!, blurRadius: 5, spreadRadius: 1)],
      ),
      child: CustomOnTapWidget(
        onTap: (){
          localizationController.setSelectIndex(index);
        },
        radius: Dimensions.radiusSmall,
        child: Stack(children: [

          Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(height: 65, width: 65,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                  border: Border.all(color: Theme.of(context).textTheme.bodyLarge!.color!, width: 1)),
                alignment: Alignment.center,
                child: Image.asset(languageModel.imageUrl!, width: 36, height: 36)),
              const SizedBox(height: Dimensions.paddingSizeLarge),

              Text(languageModel.languageName!, style: fontSizeMedium.copyWith(color: ColorResources.primaryColor)),
            ]),
          ),

          localizationController.selectedIndex == index ? const Positioned(top: 10, right: 10,
            child: Icon(Icons.check_circle, color: ColorResources.primaryColor, size: 25),
          ) : const SizedBox(),

        ]),
      ),
    );
  }
}
