import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecartify/features/splash/controllers/splash_controller.dart';

class PriceConverterHelper {
  static String convertPrice(BuildContext context, double? price, {double? discount, String? discountType}) {
    if(discount != null){
      if(discountType == 'amount' || discountType == null ) {
        price = price! - discount;
      }else if(discountType == 'percent') {
        price = price! - ((discount / 100) * price);
      }
    }
    /* return '${Get.find<SplashController>().configModel!.currencySymbol} '
        '${price!.toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'; */
    // change position of currency symbol
    if(Get.find<SplashController>().configModel!.currencyPosition == 'right'){
      return '${price!.toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} ${Get.find<SplashController>().configModel!.currencySymbol}';
    }else {
      return '${Get.find<SplashController>().configModel!.currencySymbol} ${price!.toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
    }
  }

  static String convertWithDiscount(BuildContext context, double price, double discount, String discountType) {
    if(discountType == 'amount') {
      price = price - discount;
    }else if(discountType == 'percent') {
      price = price - ((discount / 100) * price);
    }
    // return '${Get.find<SplashController>().configModel!.currencySymbol}''$price' ;
    // change position of currency symbol
    if(Get.find<SplashController>().configModel!.currencyPosition == 'right'){
      return '$price ${Get.find<SplashController>().configModel!.currencySymbol}';
    }else {
      return '${Get.find<SplashController>().configModel!.currencySymbol} $price';
    }
  }


  static double discountCalculation(BuildContext context,double price, double discount, String? discountType) {
    if(discountType == 'amount') {
      discount =  discount;
    }else if(discountType == 'percent') {
      discount =  ((discount / 100) * price);
    }
    return discount;
  }
  static String discountCalculationWithOutSymbol(BuildContext context,double price, double discount, String? discountType) {
    if(discountType == 'amount') {
      discount =  discount;
    }else if(discountType == 'percent') {
      discount =  ((discount / 100) * price);
    }
    return discount.toStringAsFixed(2);
  }

  static String calculation(double amount, double discount, String type, int quantity) {
    double calculatedAmount = 0;
    if(type == 'amount') {
      calculatedAmount = discount * quantity;
    }else if(type == 'percent') {
      calculatedAmount = (discount / 100) * (amount * quantity);
    }
    // return '${Get.find<SplashController>().configModel!.currencySymbol} ${calculatedAmount.toStringAsFixed(2)}';
    // change position of currency symbol
    if(Get.find<SplashController>().configModel!.currencyPosition == 'right'){
      return '${calculatedAmount.toStringAsFixed(2)} ${Get.find<SplashController>().configModel!.currencySymbol}';
    }else {
      return '${Get.find<SplashController>().configModel!.currencySymbol} ${calculatedAmount.toStringAsFixed(2)}';
    }
  }

  static String percentageCalculation(BuildContext context, String price, String discount, String discountType) {
    // return '$discount${discountType == 'percent' ? '%' : '${Get.find<SplashController>().configModel!.currencySymbol}'} OFF';
    // change position of currency symbol
    if(Get.find<SplashController>().configModel!.currencyPosition == 'right'){
      return '$discount${discountType == 'percent' ? '%' : '${Get.find<SplashController>().configModel!.currencySymbol}'} OFF';
    }else {
      return '${Get.find<SplashController>().configModel!.currencySymbol} $discount OFF';
    }
  }

  static String priceWithSymbol(double amount){
    if(Get.find<SplashController>().configModel!.currencyPosition == 'right'){
      return '${amount.toStringAsFixed(2)} ${Get.find<SplashController>().configModel!.currencySymbol}';
    }else {
      return '${Get.find<SplashController>().configModel!.currencySymbol} ${amount.toStringAsFixed(2)}';
    }            
  }
}