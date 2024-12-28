import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecartify/util/images.dart';
import 'package:ecartify/common/widgets/custom_app_bar_widget.dart';
import 'package:ecartify/common/widgets/custom_category_button_widget.dart';
import 'package:ecartify/common/widgets/custom_drawer_widget.dart';
import 'package:ecartify/features/product/screens/product_screen.dart';
import 'package:ecartify/features/product_setup/screens/add_product_screen.dart';
import 'package:ecartify/features/product_setup/screens/product_bulk_export_screen.dart';
import 'package:ecartify/features/product_setup/screens/product_bulk_import_screen.dart';


class ProductSetupScreen extends StatelessWidget {
    const ProductSetupScreen({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        double width = MediaQuery.of(context).size.width * .12;
        return Scaffold(
            appBar: const CustomAppBarWidget(),
            endDrawer: const CustomDrawerWidget(),
            body: Container(
                margin: const EdgeInsets.only(top: 20),
                child: GridView.count(
                    crossAxisCount: 2,
                    children: [
                        CustomCategoryButtonWidget(buttonText: 'product_list'.tr,icon: Images.productSetup,
                            isSelected: false,
                            isDrawer: false,
                            padding: width,onTap: ()=> Get.to(const ProductScreen())),
                
                        CustomCategoryButtonWidget(buttonText: 'add_new_product'.tr,
                            icon: Images.addCategoryIcon,isSelected: false,
                            onTap: ()=> Get.to(const AddProductScreen()),
                            padding: width,isDrawer: false),
                
                        CustomCategoryButtonWidget(buttonText: 'bulk_import'.tr,
                            icon: Images.importData,isSelected: false,
                            onTap: ()=> Get.to(const ProductBulkImportScreen()),
                            padding: width,isDrawer: false),
                
                        CustomCategoryButtonWidget(buttonText: 'bulk_export'.tr,
                            icon: Images.exportData,isSelected: false,
                            onTap: ()=>  Get.to(const ProductBulkExportScreen()),
                            padding: width,isDrawer: false),
                    ],
                ),
            ),
        );
    }
}
