import 'package:ecartify/util/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:ecartify/common/widgets/custom_asset_image_widget.dart';
import 'package:ecartify/helper/gradient_color_helper.dart';
import 'package:ecartify/util/dimensions.dart';
import 'package:ecartify/util/styles.dart';

class CustomCategoryButtonWidget extends StatelessWidget {
  final String icon;
  final String buttonText;
  final bool isSelected;
  final double padding;
  final bool isDrawer;
  final Function? onTap;
  final bool? showDivider;
  const CustomCategoryButtonWidget({
    Key? key,
    required this.icon,
    required this.buttonText,
    this.isSelected = false,
    this.padding = Dimensions.paddingSizeDefault,
    this.isDrawer = true, this.onTap,
    this.showDivider = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap as void Function()?,
          child: Padding(
            padding: isDrawer? const EdgeInsets.all(0.0):
            const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
            child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: isDrawer ? BorderRadius.zero : BorderRadius.circular(Dimensions.paddingSizeSmall),
                  gradient: GradientColorHelper.gradientColor(opacity: 0.03),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: padding),
                  child: Column(children: [
                    CustomAssetImageWidget(
                      icon,
                      width: 30,
                      color: isSelected ? Theme.of(context).secondaryHeaderColor : ColorResources.primaryColor,
                    ),

                    Text(buttonText, style: fontSizeMedium.copyWith(
                      color: isSelected ?  Theme.of(context).secondaryHeaderColor : ColorResources.primaryColor,
                      fontSize: Dimensions.fontSizeDefault,
                    ),),
                  ]),
                )
            ),
          ),
        ),

        if(isDrawer) Divider(height: 3, color: Theme.of(context).cardColor),

      ],
    );
  }
}
