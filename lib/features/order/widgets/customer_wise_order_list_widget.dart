import 'package:ecartify/util/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecartify/features/user/controllers/customer_controller.dart';
import 'package:ecartify/common/models/order_model.dart';
import 'package:ecartify/util/dimensions.dart';
import 'package:ecartify/common/widgets/custom_loader_widget.dart';
import 'package:ecartify/common/widgets/no_data_widget.dart';
import 'package:ecartify/features/order/widgets/order_card_widget.dart';


class CustomerWiseOrderListWidget extends StatelessWidget {
  final int? customerId;
  final ScrollController? scrollController;
  const CustomerWiseOrderListWidget({Key? key, this.scrollController, this.customerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    scrollController?.addListener(() {
      if(scrollController!.position.maxScrollExtent == scrollController!.position.pixels
          && Get.find<CustomerController>().customerWiseOrderList.isNotEmpty
          && !Get.find<CustomerController>().isLoading) {
        int? pageSize;
        pageSize = Get.find<CustomerController>().customerWiseOrderListLength;

        if(Get.find<CustomerController>().offset < pageSize!) {
          Get.find<CustomerController>().setOffset(Get.find<CustomerController>().offset);
          Get.find<CustomerController>().showBottomLoader();
          Get.find<CustomerController>().getCustomerWiseOrderListList(customerId, Get.find<CustomerController>().offset, reload: false);
        }
      }

    });

    return GetBuilder<CustomerController>(
      builder: (customerWiseOrderController) {
        List<Orders> customerWiseOrderList;
        customerWiseOrderList = customerWiseOrderController.customerWiseOrderList;

        return Column(children: [

          !customerWiseOrderController.isFirst ? customerWiseOrderList.isNotEmpty ?
          ListView.builder(
            shrinkWrap: true,
              itemCount: customerWiseOrderList.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (ctx,index){
                return OrderCardWidget(order: customerWiseOrderList[index]);

              }): const NoDataWidget() : const CustomLoaderWidget(),
          customerWiseOrderController.isGetting && !customerWiseOrderController.isFirst? const Center(child: Padding(
            padding: EdgeInsets.all(Dimensions.iconSizeExtraSmall),
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(ColorResources.primaryColor)),
          )) : const SizedBox.shrink(),

        ]);
      },
    );
  }
}
