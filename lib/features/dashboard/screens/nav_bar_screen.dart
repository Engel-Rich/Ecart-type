
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ecartify/common/controllers/account_controller.dart';
import 'package:ecartify/common/controllers/category_controller.dart';
import 'package:ecartify/features/dashboard/domain/tab_type_enum.dart';
import 'package:ecartify/features/dashboard/widgets/bottom_item_widget.dart';
import 'package:ecartify/features/shop/controllers/profile_controller.dart';
import 'package:ecartify/features/user/controllers/customer_controller.dart';
import 'package:ecartify/features/dashboard/controllers/menu_controller.dart';
import 'package:ecartify/features/product/controllers/product_controller.dart';
import 'package:ecartify/features/account_management/controllers/transaction_controller.dart';
import 'package:ecartify/helper/show_custom_snackbar_helper.dart';
import 'package:ecartify/util/images.dart';
import 'package:ecartify/helper/animated_custom_dialog_helper.dart';
import 'package:ecartify/common/widgets/custom_app_bar_widget.dart';
import 'package:ecartify/common/widgets/custom_drawer_widget.dart';
import 'package:ecartify/common/widgets/custom_dialog_widget.dart';


class NavBarScreen extends StatefulWidget {
    const NavBarScreen({Key? key}) : super(key: key);

    @override
    State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
    final PageStorageBucket bucket = PageStorageBucket();
    bool _isExit = false;

    void _loadData(){
        Get.find<CategoryController>().getCategoryList(1, isUpdate: false);
        Get.find<ProfileController>().getProfileData();
        Get.find<CustomerController>().getCustomerList(1, isUpdate: false);
        Get.find<TransactionController>().getTransactionAccountList(1);
        Get.find<ProductController>().getLimitedStockProductList(1, isUpdate: false);
        Get.find<AccountController>().getRevenueDataForChart();
        Get.find<ProfileController>().getDashboardRevenueData('overall');
        Get.find<AccountController>().getAccountList(1, isUpdate: false);
    }

    @override
    void initState() {
        super.initState();
        _loadData();
    }

    @override
    Widget build(BuildContext context) {
        return PopScope(
            canPop: _isExit,
            onPopInvoked: (_) => _onWillPop(context),
            child: GetBuilder<BottomManuController>(builder: (menuController) {
                return GetBuilder<ProfileController>(builder: (profileController) {
                    return Scaffold(
                        onEndDrawerChanged: (bool status) {
                            setState(() {
                                _isExit = status;
                            });
                        },
                        resizeToAvoidBottomInset: false,
                        appBar:  const CustomAppBarWidget(isBackButtonExist: false),
                        backgroundColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
                        endDrawer: const CustomDrawerWidget(),
                        body: PageStorage(bucket: bucket, child: menuController.screen[menuController.currentTabIndex]),
                            bottomNavigationBar: Container(
                                height: 70,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                                    boxShadow: [
                                        BoxShadow(color: Colors.grey.withOpacity(0.14), blurRadius: 80, offset: const Offset(0, 20)),
                                        BoxShadow(color: Theme.of(context).cardColor, blurRadius: 0.5, offset: const Offset(0, 0)),
                                    ],
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                                    children: [
                                        BottomItemWidget(
                                            tap: ()=> menuController.onChangeMenu(type: NavbarType.dashboard),
                                            icon: menuController.currentTabIndex == 0 ? Images.dashboard : Images.dashboard,
                                            name: 'dashboard'.tr, 
                                            selectIndex: 0,
                                        ),

                                        BottomItemWidget(
                                            tap: profileController.profileModel == null ? null : (){
                                                if(profileController.modulePermission?.pos ?? false) {
                                                    menuController.onChangeMenu(type: NavbarType.items);
                                                }else {
                                                    showCustomSnackBarHelper('you_do_not_have_permission'.tr);
                                                }
                                            },
                                            icon: menuController.currentTabIndex == 1 ? Images.item : Images.item, name: 'items'.tr,
                                            selectIndex: 1,
                                        ),

                                        BottomItemWidget(
                                            tap: profileController.profileModel == null ? null : (){
                                                if(profileController.modulePermission?.pos ?? false) {
                                                    menuController.onChangeMenu(type: NavbarType.pos);
                                                }else {
                                                    showCustomSnackBarHelper('you_do_not_have_permission'.tr);
                                                }
                                            },
                                            icon: menuController.currentTabIndex == 2 ? Images.pos : Images.pos, name: 'pos'.tr,
                                            selectIndex: 2,
                                        ),
                                        
                                        BottomItemWidget(
                                            tap: profileController.profileModel == null ? null : (){
                                                if(profileController.modulePermission?.limitedStock ?? false) {
                                                    menuController.onChangeMenu(type: NavbarType.limitedStock);
                                                }else {
                                                    showCustomSnackBarHelper('you_do_not_have_permission'.tr);
                                                }
                                            },
                                            icon: menuController.currentTabIndex == 3 ? Images.stock : Images.stock, name: 'limited_stock'.tr,
                                            selectIndex: 3,
                                        ),
                                    ],
                                ),
                            ),
                        );
                    }
                );
            }),
        );
    }

    void _onWillPop(BuildContext context) async {
        if(!_isExit) {
            showAnimatedDialogHelper(
                context,
                CustomDialogWidget(
                    icon: Icons.exit_to_app_rounded, title: 'exit'.tr,
                    description: 'do_you_want_to_exit_the_app'.tr,
                    onTapFalse:() => Navigator.of(context).pop(false),
                    onTapTrue:() {
                        SystemNavigator.pop();
                    },
                    onTapTrueText: 'yes'.tr, onTapFalseText: 'no'.tr,
                ),
                dismissible: false,
                isFlip: true,
            );
        }
    }

}



