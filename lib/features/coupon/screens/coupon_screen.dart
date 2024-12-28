import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecartify/util/images.dart';
import 'package:ecartify/common/widgets/custom_app_bar_widget.dart';
import 'package:ecartify/common/widgets/custom_category_button_widget.dart';
import 'package:ecartify/common/widgets/custom_drawer_widget.dart';
import 'package:ecartify/features/coupon/screens/add_coupon_screen.dart';
import 'package:ecartify/features/coupon/screens/coupon_list_screen.dart';

class CouponScreen extends StatelessWidget {
  const CouponScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * .12;
    return Scaffold(
      endDrawer: const CustomDrawerWidget(),
      appBar: const CustomAppBarWidget(),
      body: Container(
          margin: const EdgeInsets.only(top: 20),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            children: [
              InkWell(
                onTap: () => Get.to(() => const CouponListScreen()),
                child: CustomCategoryButtonWidget(
                  padding: width,
                  buttonText: 'coupon_list'.tr,
                  icon: Images.couponListIcon,
                ),
              ),
              InkWell(
                onTap: () => Get.to(() => const AddCouponScreen()),
                child: CustomCategoryButtonWidget(
                  padding: width,
                  buttonText: 'add_new_coupon'.tr,
                  icon: Images.addCoupon,
                ),
              ),
            ],
          )),
    );
  }
}
