import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecartify/common/controllers/cart_controller.dart';
import 'package:ecartify/features/splash/controllers/splash_controller.dart';
import 'package:ecartify/common/models/cart_model.dart';
import 'package:ecartify/features/product/domain/models/categories_product_model.dart';
import 'package:ecartify/common/models/product_model.dart';
import 'package:ecartify/util/dimensions.dart';
import 'package:ecartify/util/images.dart';
import 'package:ecartify/util/styles.dart';
import 'package:ecartify/common/widgets/custom_image_widget.dart';
import 'package:ecartify/helper/show_custom_snackbar_helper.dart';
class SearchedProductItemWidget extends StatelessWidget {
  final Products? product;
  const SearchedProductItemWidget({Key? key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetBuilder<CartController>(
        builder: (cartController) {
          return InkWell(
            onTap: (){
              if(product!.quantity!<1){
                showCustomSnackBarHelper('stock_out'.tr);
              }else{
                CartModel cartModel = CartModel(product!.sellingPrice, product!.discount, 1, product!.tax, CategoriesProduct(
                    id: product!.id,title: product!.title,productCode: product!.productCode,unitType: product!.unitType, unitValue: product!.unitValue,
                    image: product!.image, sellingPrice: product!.sellingPrice, purchasePrice: product!.sellingPrice,discountType: product!.discountType,
                    discount: product!.discount,tax: product!.tax,quantity: product!.quantity
                ));
                cartController.addToCart(cartModel);
              }

            },
            child: Row(children: [
              Container(width: Dimensions.productImageSize,height: Dimensions.productImageSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeBorder),
                  child: CustomImageWidget(
                    fit: BoxFit.cover,
                    placeholder: Images.placeholder,
                    image: '${Get.find<SplashController>().baseUrls!.productImageUrl}/${product!.image}',
                  ),
                ),
              ),),
              const SizedBox(width: Dimensions.paddingSizeDefault,),
              Expanded(child: Text(product!.title!, style: fontSizeRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
                maxLines: 1,overflow: TextOverflow.ellipsis,))
            ]),
          );
        }
      ),
    );
  }
}
