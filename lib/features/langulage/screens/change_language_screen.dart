import 'package:ecartify/util/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecartify/features/langulage/controllers/localization_controller.dart';
import 'package:ecartify/util/app_constants.dart';
import 'package:ecartify/util/dimensions.dart';
import 'package:ecartify/util/images.dart';
import 'package:ecartify/util/styles.dart';
import 'package:ecartify/common/widgets/custom_app_bar_widget.dart';
import 'package:ecartify/common/widgets/custom_button_widget.dart';
import 'package:ecartify/common/widgets/custom_drawer_widget.dart';
import 'package:ecartify/helper/show_custom_snackbar_helper.dart';
import '../widgets/language_item_widget.dart';

class ChooseLanguageScreen extends StatefulWidget {
  const ChooseLanguageScreen({Key? key}) : super(key: key);

  @override
  State<ChooseLanguageScreen> createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {

  @override
  void initState() {
    super.initState();

    Get.find<LocalizationController>().loadCurrentLanguage(isUpdate: false);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(),
      endDrawer: const CustomDrawerWidget(),
      body: GetBuilder<LocalizationController>(
        builder: (localizationController) {
          return Column(children: [
          Expanded(child: Center(
            child: Scrollbar(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: Center(child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                        child: Text('select_language'.tr, style: fontSizeMedium.copyWith(
                          color: ColorResources.primaryColor,
                          fontSize: Dimensions.fontSizeExtraLarge,
                        )),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                      GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: (1 / 1),
                        ),
                        itemCount: localizationController.languages.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => LanguageItemWidget(
                          languageModel: localizationController.languages[index],
                          localizationController: localizationController,
                          index: index,
                        ),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeLarge),

                      Text('you_can_change_language'.tr, style: fontSizeRegular.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: Theme.of(context).disabledColor,
                      )),
                    ],
                  ),
                ),),
              ),
            ),
          ),),
          Container(
            padding: const EdgeInsets.only(
              left: Dimensions.paddingSizeDefault,
              right: Dimensions.paddingSizeDefault,
              bottom: Dimensions.paddingSizeExtraLarge,
            ),
            child: Row(children: [
              Expanded(child: CustomButtonWidget(
                buttonText: 'save'.tr,
                onPressed: () {
                  if (localizationController.languages.isNotEmpty && localizationController.selectedIndex != -1) {
                    localizationController.setLanguage(Locale(
                      AppConstants.languages[localizationController.selectedIndex].languageCode!,
                      AppConstants.languages[localizationController.selectedIndex].countryCode,
                    ),);
                    Get.back();
                  } else {
                    showCustomSnackBarHelper('select_a_language'.tr, isError: false);
                  }
                },
                ),
              ),
            ],
            ),
          ),
        ]);
      },),
    );
  }
}
