import 'package:ecartify/util/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:ecartify/util/dimensions.dart';
import 'package:ecartify/util/styles.dart';

class InvoiceElementWidget extends StatelessWidget {
  final bool isBold;
  final String? title;
  final String? serial;
  final String? quantity;
  final String? price;
  const InvoiceElementWidget({
    Key? key,
    this.serial,
    this.isBold = false,
    this.title,
    this.quantity,
    this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(children: [
      Expanded(flex: 5,
        child: serial != null ? Row(mainAxisAlignment: MainAxisAlignment.start,children: [
          _textView(context, serial!, isBold),
          const SizedBox(width: Dimensions.paddingSizeDefault),

          _textView(context, title!, isBold),

        ],) : Text(title!, style: isBold ? fontSizeBold.copyWith(
          color: ColorResources.primaryColor,
          fontSize: Dimensions.fontSizeLarge,
        ) : fontSizeRegular.copyWith(color: Theme.of(context).hintColor)),
      ),

      Expanded(flex: 3,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          quantity != null ? _textView(context, quantity!, isBold) : const SizedBox(),
          const SizedBox(width: Dimensions.paddingSizeDefault),

          Text(price!, style: isBold ? fontSizeBold.copyWith(
            color: ColorResources.primaryColor,
            fontSize: Dimensions.fontSizeLarge,
          ) : fontSizeRegular.copyWith(color: Theme.of(context).hintColor)),
        ],),
      ),
    ],);
  }

  Text _textView(BuildContext context,String text, bool isBold) {
    return Text(text, style: isBold ? fontSizeRegular.copyWith(
            color: ColorResources.primaryColor,
            fontSize: Dimensions.fontSizeLarge,
          ) : fontSizeRegular.copyWith(color: Theme.of(context).hintColor));
  }
}
