
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecartify/common/widgets/paginated_list_widget.dart';
import 'package:ecartify/features/user/controllers/supplier_controller.dart';
import 'package:ecartify/features/user/widgets/account_shimmer_widget.dart';
import 'package:ecartify/common/widgets/no_data_widget.dart';
import 'package:ecartify/features/user/widgets/supplier_card_view_widget.dart';

class SupplierListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const SupplierListWidget({Key? key, required this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupplierController>(
      builder: (supplierController) {

        if(supplierController.supplierModel == null) return const AccountShimmerWidget();

        return (supplierController.supplierModel?.supplierList?.isNotEmpty ?? false) ? PaginatedListWidget(
          scrollController: scrollController,
          onPaginate: (int? offset) async => await supplierController.getSupplierList(offset ?? 1),
          totalSize: supplierController.supplierModel?.totalSize,
          offset: supplierController.supplierModel?.offset,
          limit: supplierController.supplierModel?.limit,
          itemView: ListView.builder(
            shrinkWrap: true,
            itemCount: supplierController.supplierModel?.supplierList?.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (ctx,index){
              return SupplierCardViewWidget(
                supplier: supplierController.supplierModel?.supplierList?[index],
              );
            },
          ),
        ) : const NoDataWidget();
      },
    );
  }
}
