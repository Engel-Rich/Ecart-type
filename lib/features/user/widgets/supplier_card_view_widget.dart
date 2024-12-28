import 'package:ecartify/util/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecartify/features/shop/controllers/profile_controller.dart';
import 'package:ecartify/features/splash/controllers/splash_controller.dart';
import 'package:ecartify/features/user/controllers/supplier_controller.dart';
import 'package:ecartify/features/user/domain/models/supplier_model.dart';
import 'package:ecartify/util/dimensions.dart';
import 'package:ecartify/util/images.dart';
import 'package:ecartify/util/styles.dart';
import 'package:ecartify/helper/animated_custom_dialog_helper.dart';
import 'package:ecartify/common/widgets/custom_image_widget.dart';
import 'package:ecartify/common/widgets/custom_on_tap_widget.dart';
import 'package:ecartify/common/widgets/custom_dialog_widget.dart';
import 'package:ecartify/features/product/screens/product_screen.dart';
import 'package:ecartify/features/user/screens/add_new_user_screen.dart';
import 'package:ecartify/features/user/screens/supplier_transaction_screen.dart';
import 'package:ecartify/features/user/widgets/custom_divider_widget.dart';
class SupplierCardViewWidget extends StatelessWidget {
  final Suppliers? supplier;
  const SupplierCardViewWidget({Key? key, this.supplier}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();

    return Column(children: [
      Container(height: 5, color: ColorResources.primaryColor.withOpacity(0.06)),
      Container(
        padding: const EdgeInsets.symmetric(
          vertical: Dimensions.paddingSizeExtraSmall,
          horizontal: Dimensions.paddingSizeSmall,
        ),
        child: Column( crossAxisAlignment:CrossAxisAlignment.start, children: [
          Row(
            children: [
              Expanded(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Card(child: CustomImageWidget(
                    image: '${Get.find<SplashController>().configModel!.baseUrls!.supplierImageUrl}/${supplier!.image}',
                    width: 50, height: 50, fit: BoxFit.cover, placeholder: Images.profilePlaceHolder,
                  )),
                  title: Text(supplier!.name!),
                  subtitle: Text('${'total_products'.tr} ${supplier!.productCount}'),

                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: CustomOnTapWidget(child: Image.asset(Images.editIcon, height: 30), onTap: () {
                  Get.to(AddNewUserScreen(supplier: supplier));

                },),
              ),

              GetBuilder<SupplierController>(
                builder: (supplierController) {
                  return CustomOnTapWidget(child: Image.asset(Images.deleteIcon, height: 30), onTap: () {
                    showAnimatedDialogHelper(context,
                        CustomDialogWidget(
                          delete: true,
                          icon: Icons.exit_to_app_rounded, title: '',
                          description: 'are_you_sure_you_want_to_delete_supplier'.tr, onTapFalse:() => Navigator.of(context).pop(true),
                          onTapTrue:() {
                            supplierController.deleteSupplier(supplier!.id);
                          },
                          onTapTrueText: 'yes'.tr, onTapFalseText: 'cancel'.tr,
                        ),
                        dismissible: false,
                        isFlip: true);
                  },);
                }
              ),
            ],
          ),

          CustomDividerWidget(color: Theme.of(context).hintColor),

          Row(children: [
            Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Padding( padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                child: Text('contact_information'.tr, style: fontSizeMedium.copyWith(
                  color: ColorResources.primaryColor,
                  fontSize: Dimensions.fontSizeLarge,
                )),
              ),

              Padding( padding: const EdgeInsets.only(bottom: 2),
                child: Text(supplier!.email!, style: fontSizeRegular.copyWith(
                  color: Theme.of(context).hintColor,
                  fontSize: Dimensions.fontSizeSmall,
                )),
              ),

              Padding( padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(supplier!.mobile!, style: fontSizeRegular.copyWith(
                  color: Theme.of(context).hintColor,
                  fontSize: Dimensions.fontSizeSmall,
                )),
              ),
            ],),
            const Spacer(),
            Column(crossAxisAlignment: CrossAxisAlignment.end,children: [
              InkWell(
                onTap: ()=> Get.to(SupplierTransactionListScreen(supplierId: supplier!.id, supplier: supplier)),
                child: Row(children: [
                  Text('transactions'.tr, style: fontSizeMedium.copyWith(color: ColorResources.primaryColor)),
                  const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                  SizedBox(width: 20,height: 20,child: Image.asset(Images.item))
                ],),
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall,),



             if(profileController.modulePermission?.product ?? false) InkWell(
                onTap: ()=> Get.to(ProductScreen(supplierId: supplier?.id)),
                child: Row(children: [
                  Text('products'.tr,style: fontSizeMedium.copyWith(color: Theme.of(context).secondaryHeaderColor),),
                  const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                  SizedBox(width: 20,height: 20,child: Image.asset(Images.stock,color: Theme.of(context).secondaryHeaderColor,))
                ],),
              ),
            ],)
          ],)
        ]),
      ),
    ],);
  }
}
