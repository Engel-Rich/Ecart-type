import 'package:ecartify/util/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecartify/common/controllers/category_controller.dart';
import 'package:ecartify/features/category/domain/models/category_model.dart';
import 'package:ecartify/util/dimensions.dart';
import 'package:ecartify/util/images.dart';
import 'package:ecartify/util/styles.dart';
import 'package:ecartify/common/widgets/custom_app_bar_widget.dart';
import 'package:ecartify/common/widgets/custom_drawer_widget.dart';
import 'package:ecartify/common/widgets/custom_header_widget.dart';
import 'package:ecartify/features/category/screens/add_new_sub_category_screen.dart';
import 'package:ecartify/features/category/widgets/sub_category_list_widget.dart';
class SubCategoryListScreen extends StatefulWidget {
  const SubCategoryListScreen({Key? key}) : super(key: key);

  @override
  State<SubCategoryListScreen> createState() => _SubCategoryListScreenState();
}

class _SubCategoryListScreenState extends State<SubCategoryListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final CategoryController categoryController = Get.find<CategoryController>();

    if((categoryController.categoryModel?.categoriesList?.isNotEmpty ?? false)) {
      categoryController.getSubCategoryList(1, categoryController.categoryModel?.categoriesList?.first.id, isUpdate: false);
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(),
      endDrawer: const CustomDrawerWidget(),


      body: SafeArea(
        child: RefreshIndicator(
          color: Theme.of(context).cardColor,
          backgroundColor: ColorResources.primaryColor,
          onRefresh: () async {

          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child:  Column(
                  children: [
                    CustomHeaderWidget(title: 'sub_category_list'.tr, headerImage: Images.categories),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    GetBuilder<CategoryController>(
                        builder: (categoryController) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault,0,Dimensions.paddingSizeDefault,0),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text('select_category'.tr, style: fontSizeRegular.copyWith(color: ColorResources.primaryColor),),
                              const SizedBox(height: Dimensions.paddingSizeSmall),

                              //todo need change
                              Builder(
                                builder: (context) {
                                  return Container(
                                    height: 50,
                                    padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeSmall),
                                    decoration: BoxDecoration(color: Theme.of(context).cardColor,
                                        border: Border.all(width: .5, color: Theme.of(context).hintColor.withOpacity(.7)),
                                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeMediumBorder)),
                                    child: DropdownButton<int>(
                                      hint: Text('select'.tr),
                                      value: categoryController.selectedCategoryId,
                                      items: categoryController.categoryModel?.categoriesList?.map((Categories? value) {
                                        return DropdownMenuItem<int>(
                                            value: value?.id,
                                            child: Text(value?.name ?? ''));
                                      }).toList(),
                                      onChanged: (int? value) {
                                        categoryController.setCategoryIndex(value!, true);
                                      },
                                      isExpanded: true, underline: const SizedBox(),),
                                  );
                                }
                              ),
                              const SizedBox(height: Dimensions.paddingSizeSmall),
                            ],),
                          );
                        }
                    ),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    SubCategoryListWidget(scrollController: _scrollController),
                  ],
                ),
              )
            ],
          ),
        ),
      ),






      floatingActionButton: FloatingActionButton(backgroundColor: ColorResources.primaryColor,
        onPressed: () {
          Get.to(const AddNewSubCategoryScreen());
        },child: Image.asset(Images.addCategoryIcon,width: 40,),),
    );
  }
}
