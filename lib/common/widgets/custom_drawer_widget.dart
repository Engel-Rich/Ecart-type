import 'package:ecartify/util/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecartify/features/dashboard/controllers/menu_controller.dart';
import 'package:ecartify/features/dashboard/domain/tab_type_enum.dart';
import 'package:ecartify/features/employe_role/screens/employee_management_screen.dart';
import 'package:ecartify/features/shop/controllers/profile_controller.dart';
import 'package:ecartify/features/splash/controllers/splash_controller.dart';
import 'package:ecartify/util/dimensions.dart';
import 'package:ecartify/util/images.dart';
import 'package:ecartify/util/styles.dart';
import 'package:ecartify/common/widgets/custom_category_button_widget.dart';
import 'package:ecartify/common/widgets/sign_out_dialog_widget.dart';
import 'package:ecartify/features/account_management/screens/account_mangement_screen.dart';
import 'package:ecartify/features/dashboard/screens/nav_bar_screen.dart';
import 'package:ecartify/features/langulage/screens/change_language_screen.dart';
import 'package:ecartify/features/product_setup/screens/product_setup_menu_screen.dart';
import 'package:ecartify/features/order/screens/order_screen.dart';
import 'package:ecartify/features/shop/screens/shop_setting_screen.dart';
import 'package:ecartify/features/user/screens/option_list_screen.dart';

import '../../helper/animated_custom_dialog_helper.dart';

class CustomDrawerWidget extends StatelessWidget {
    const CustomDrawerWidget({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        final BottomManuController manuController = Get.find<BottomManuController>();
        final SplashController splashController = Get.find<SplashController>();

        return Container(
            width: MediaQuery.of(context).size.width * 0.7,
            color: Theme.of(context).cardColor,
            child: GetBuilder<ProfileController>(
                builder: (profileController) {
                    bool isShowProduct = (profileController.modulePermission?.product ?? false)
                        || (profileController.modulePermission?.coupon ?? false)
                        || (profileController.modulePermission?.brand ?? false)
                        || (profileController.modulePermission?.category ?? false)
                        || (profileController.modulePermission?.unit ?? false);

                    return Column(
                        children: [
                            Container(
                                width: MediaQuery.of(context).size.width,
                                color: ColorResources.primaryColor,
                                height: 200,
                                child: Column(
                                    children: [
                                        const SizedBox(
                                            height: 40
                                        ),
                                        SizedBox(
                                            width: 80,
                                            height: 80,
                                            child: ClipRRect(
                                                borderRadius: const BorderRadius.all(Radius.circular(50)),
                                                child: ClipRRect(
                                                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                                                    child: FadeInImage.assetNetwork(
                                                        placeholder:  Images.placeholder,
                                                        height: 80, width: 80, fit: BoxFit.cover,
                                                        image: '${splashController.baseUrls?.adminImageUrl}/${profileController.profileModel?.image ?? ''}',
                                                        imageErrorBuilder: (c, o, s) => Image.asset(
                                                            Images.placeholder,
                                                            height: 80, width: 80, fit: BoxFit.cover,
                                                        ),
                                                    ),
                                                ),
                                            ),
                                        ),
                                        Text(
                                            '${profileController.profileModel?.fName} ${profileController.profileModel?.lName}',
                                            style: fontSizeRegular.copyWith(
                                                color: Theme.of(context).cardColor,
                                                fontSize: Dimensions.fontSizeExtraLarge,
                                            ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5),
                                            child: Text(
                                                '${profileController.profileModel?.email}',
                                                style: fontSizeRegular.copyWith(
                                                    color: Theme.of(context).cardColor,
                                                    fontSize: Dimensions.fontSizeSmall,
                                                ),
                                            ),
                                        ),
                                    ]
                                ),
                            ),
                            Expanded(
                                child: ListView(
                                    padding: EdgeInsets.zero, 
                                    children: [
                                        CustomCategoryButtonWidget(
                                            icon: Images.dashboard,
                                            buttonText: 'dashboard'.tr, onTap: (){
                                                Get.back();
                                                Get.to(()=> const NavBarScreen());
                                                manuController.onChangeMenu(type: NavbarType.dashboard);
                                            },
                                        ),

                                        


                                        if(isShowProduct) 
                                            CustomCategoryButtonWidget(
                                                icon: Images.productSetup,
                                                buttonText: 'product_setup'.tr,
                                                onTap: ()=> Get.to(()=> const ProductSetupMenuScreen(isFromDrawer: true)),
                                                showDivider: true,
                                            ),

                                        if(profileController.modulePermission?.pos ?? false) 
                                            CustomCategoryButtonWidget(
                                                icon: Images.pos,
                                                buttonText: 'pos_section'.tr, onTap: (){
                                                Get.back();
                                                Get.to(()=> const NavBarScreen());
                                                manuController.onChangeMenu(type: NavbarType.pos);
                                                },
                                            ),

                                        if(profileController.modulePermission?.pos ?? false)
                                            CustomCategoryButtonWidget(
                                                icon: Images.item,
                                                buttonText: 'orders'.tr,
                                                onTap: ()=> Get.to(()=> const OrderScreen(fromNavBar: false)),
                                                showDivider: true,
                                            ),

                                        if(profileController.modulePermission?.account ?? false)
                                            CustomCategoryButtonWidget(
                                                icon: Images.accountManagement,
                                                buttonText: 'accounts_management'.tr,
                                                onTap: ()=> Get.to(()=> const AccountManagementScreen()),
                                                showDivider: true,
                                            ),

                                        if((profileController.modulePermission?.customer ?? false) || (profileController.modulePermission?.supplier ?? false))
                                            CustomCategoryButtonWidget(
                                                icon: Images.profilePlaceHolder,
                                                buttonText: 'users'.tr,
                                                onTap: ()=> Get.to(()=> const OptionListScreen()),
                                                showDivider: true,
                                            ),

                                        if(profileController.modulePermission?.setting ?? false) 
                                        CustomCategoryButtonWidget(
                                            icon: Images.shopIcon,
                                            buttonText: 'shop_settings'.tr,
                                            onTap: ()=> Get.to(()=> const ShopSettingScreen()),
                                            showDivider: true,
                                        ),

                                        if(profileController.modulePermission?.employee ?? false)
                                            CustomCategoryButtonWidget(
                                                icon: Images.employeeRole,
                                                buttonText: 'employee_section'.tr,
                                                onTap: ()=> Get.to(()=> const EmployeeManagementScreen()),
                                                showDivider: true,
                                            ),

                                        CustomCategoryButtonWidget(
                                            icon: Images.languageLogo,
                                            buttonText: 'change_language'.tr,
                                            onTap: ()=> Get.to(()=> const ChooseLanguageScreen()),
                                            showDivider: true,
                                        ),

                                        CustomCategoryButtonWidget(
                                            icon: Images.logout,
                                            buttonText: 'log_out'.tr,
                                            onTap: () => showAnimatedDialogHelper(context, const SignOutDialogWidget(), isFlip: true),
                                            showDivider: true,
                                        ),

                                    ]
                                ),
                            ),
                        ]
                    );
                }
            ),
        );
    }
}
