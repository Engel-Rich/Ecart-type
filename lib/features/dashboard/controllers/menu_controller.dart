import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecartify/features/dashboard/domain/tab_type_enum.dart';
import 'package:ecartify/features/home/screens/home_screens.dart';
import 'package:ecartify/features/pos/screens/pos_screen.dart';
import 'package:ecartify/features/product/screens/limited_stock_product_screen.dart';
import 'package:ecartify/features/category/screens/category_product_list_screen.dart';

class BottomManuController extends GetxController implements GetxService{
    int _currentTabIndex = 0;
    int get currentTabIndex => _currentTabIndex;
    final List<Widget> _screen = [
            const HomeScreen(),
            const CategoryProductListScreen(),
            const PosScreen(),
            const LimitedStockProductScreen()
    ];

    List<Widget> get screen => _screen;

    void onChangeMenu({required NavbarType type}) {
        _currentTabIndex = _getPageIndex(type);
        update();
    }

    int _getPageIndex(NavbarType type) {
        switch(type) {
            case NavbarType.dashboard:
                return 0;
            case NavbarType.items:
                return 1;
            case NavbarType.pos:
                return 2;
            case NavbarType.limitedStock:
                return 3;
        }
    }
}
