import 'package:ecartify/util/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecartify/features/product/controllers/product_controller.dart';
import 'package:ecartify/util/dimensions.dart';
import 'package:ecartify/util/images.dart';
import 'package:ecartify/common/widgets/custom_header_widget.dart';
import 'package:ecartify/common/widgets/secondary_header_widget.dart';
import 'package:ecartify/features/product/widgets/limited_stock_product_list_widget.dart';


class LimitedStockProductScreen extends StatefulWidget {
  const LimitedStockProductScreen({Key? key}) : super(key: key);

  @override
  State<LimitedStockProductScreen> createState() => _LimitedStockProductScreenState();
}

class _LimitedStockProductScreenState extends State<LimitedStockProductScreen> {
  final ScrollController _scrollController = ScrollController();



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          color: Theme.of(context).cardColor,
          backgroundColor: ColorResources.primaryColor,
          onRefresh: () async {
            Get.find<ProductController>().getLimitedStockProductList(1);

          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(children: [
                  CustomHeaderWidget(title:  'stock_limit_product_list'.tr , headerImage: Images.peopleIcon),
                  const SizedBox(height: Dimensions.paddingSizeBorder),
                  SecondaryHeaderWidget(key: UniqueKey(), isLimited: true),

                  LimitedStockProductListWidget(scrollController: _scrollController, isHome: false,)

                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
