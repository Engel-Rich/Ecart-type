import 'dart:async';

import 'package:ecartify/util/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ecartify/features/auth/controllers/auth_controller.dart';
import 'package:ecartify/helper/email_checker.dart';
import 'package:ecartify/util/app_constants.dart';
import 'package:ecartify/util/dimensions.dart';
import 'package:ecartify/util/images.dart';
import 'package:ecartify/util/styles.dart';
import 'package:ecartify/helper/animated_custom_dialog_helper.dart';
import 'package:ecartify/common/widgets/custom_button_widget.dart';
import 'package:ecartify/common/widgets/custom_field_with_title_widget.dart';
import 'package:ecartify/helper/show_custom_snackbar_helper.dart';
import 'package:ecartify/common/widgets/custom_text_field_widget.dart';
import 'package:ecartify/common/widgets/custom_dialog_widget.dart';
import 'package:ecartify/features/dashboard/screens/nav_bar_screen.dart';

class LogInScreen extends StatefulWidget {
    const LogInScreen({Key? key}) : super(key: key);

    @override
    State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
    final FocusNode _emailFocus = FocusNode();
    final FocusNode _passwordFocus = FocusNode();

    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    @override
    void initState() {
        // TODO: implement initState
        super.initState();

        _emailController.text = Get.find<AuthController>().getUserEmail();
        _passwordController.text = Get.find<AuthController>().getUserPassword();

        if(_passwordController.text != ''){
            Get.find<AuthController>().setRememberMe();
        }
    }

    @override
    void dispose() {
        _emailController.dispose();
        _passwordController.dispose();
        super.dispose();
    }


    @override
    Widget build(BuildContext context) {
        return PopScope(
            canPop: false,
            onPopInvoked: (_) => _onWillPop(context),
            child: Scaffold(
                body: Container(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Images.background),
                            fit: BoxFit.cover,
                        ),
                    ),
                    child: Center(
                        child: Padding(
                            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                            child: GetBuilder<AuthController>(
                                builder: (authController) {
                                    return Column(
                                        mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, 
                                        children: [
                                            Flexible(
                                                child: SingleChildScrollView(
                                                    child: Column(
                                                        children: [
                                                            Image.asset(Images.logoWithName, width: 100),
                                                            const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                                                            Text('sign_in'.tr, style: fontSizeBlack.copyWith(fontSize: Dimensions.fontSizeOverOverLarge)),
                                                            const SizedBox(height: 50),
                                                            CustomFieldWithTitleWidget(
                                                                customTextField: CustomTextFieldWidget(
                                                                    fillColor: Colors.transparent,
                                                                    hintText: 'enter_email_address'.tr,
                                                                    controller: _emailController,
                                                                    focusNode: _emailFocus,
                                                                    nextFocus: _passwordFocus,
                                                                    inputType: TextInputType.emailAddress,
                                                                ),
                                                                title: 'email'.tr,
                                                            ),

                                                            CustomFieldWithTitleWidget(
                                                                customTextField: CustomTextFieldWidget(
                                                                    fillColor: Colors.transparent,
                                                                    hintText: 'password'.tr,
                                                                    controller: _passwordController,
                                                                    focusNode: _passwordFocus,
                                                                    inputAction: TextInputAction.done,
                                                                    inputType: TextInputType.visiblePassword,
                                                                    isPassword: true,
                                                                ),
                                                                title: 'password'.tr,
                                                            ),
                                                            Row(
                                                                children: [
                                                                    Expanded(
                                                                        child: ListTile(
                                                                            onTap: () => authController.toggleRememberMe(),
                                                                            leading: Checkbox(
                                                                                activeColor: ColorResources.primaryColor,
                                                                                checkColor: Colors.white,
                                                                                value: authController.isActiveRememberMe,
                                                                                onChanged: (bool? isChecked) => authController.toggleRememberMe(),
                                                                            ),
                                                                            title: Text('remember_me'.tr),
                                                                            contentPadding: EdgeInsets.zero,
                                                                            dense: true,
                                                                            horizontalTitleGap: 0,
                                                                        ),
                                                                    ),
                                                                ]
                                                            ),
                                                        ],
                                                    ),
                                                ),
                                            ),

                                            CustomButtonWidget(
                                                isLoading: authController.isLoading,
                                                buttonText: 'sign_in'.tr,
                                                buttonColor: ColorResources.colorPrimary,
                                                onPressed: () => _login(authController, _emailController, _passwordController, context),
                                            ),

                                            // demo login credential
                                            AppConstants.demo?
                                            const SizedBox(height: Dimensions.paddingSizeExtraLarge):const SizedBox(),
                                            AppConstants.demo?
                                            Container(
                                                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                                                    color: ColorResources.primaryColor.withOpacity(.125),
                                                ),
                                                child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                        Column(
                                                            crossAxisAlignment:CrossAxisAlignment.start,
                                                            children: [
                                                                Row(
                                                                    children: [
                                                                        Text('${'email'.tr} : ',style: fontSizeBold,),
                                                                        const Text(' ${'admin@ecartify.com'}',style: fontSizeRegular,),
                                                                    ],
                                                                ),
                                                                const SizedBox(height: Dimensions.fontSizeExtraSmall),
                                                                Row(
                                                                    children: [
                                                                        Text('${'password'.tr} : ', style: fontSizeBold),
                                                                        const Text(' ${'12345678'}', style: fontSizeRegular),
                                                                    ],
                                                                ),

                                                            ],
                                                        ),
                                                        InkWell(
                                                            onTap: (){
                                                                _emailController.text = "admin@ecartify.com";
                                                                _passwordController.text = "12345678";
                                                                showCustomSnackBarHelper('successfully_copied'.tr, isError: false);
                                                            },
                                                            child: Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                                                                    color: ColorResources.primaryColor
                                                                ),
                                                                width: 50,height: 50,
                                                                child: Icon(Icons.copy,color: Theme.of(context).cardColor)
                                                            ),
                                                        ),
                                                    ],
                                                ),
                                            ):const SizedBox(),

                                            const SizedBox(height: Dimensions.paddingSizeSmall),
                                        ]
                                    );
                                }
                            ),
                        ),
                    ),
                ),
            ),
        );
    }

    void _login(
        AuthController authController,
        TextEditingController emailController,
        TextEditingController passController,
        BuildContext context) async {
        String password = passController.text.trim();
        String email = _emailController.text.trim();

        if (email.isEmpty) {
            showCustomSnackBarHelper('enter_email_address'.tr);
        } else if (EmailCheckerHelper.isNotValid(email)) {
            showCustomSnackBarHelper('enter_valid_email'.tr);
        } else if (password.isEmpty) {
            showCustomSnackBarHelper('enter_password'.tr);
        } else if (password.length < 6) {
            showCustomSnackBarHelper('password_should_be'.tr);
        } else {
            authController.login(emailAddress: email, password: password).then((status) async {
                if (status?.isSuccess ?? false) {
                    if (authController.isActiveRememberMe) {
                        authController.saveUserEmailAndPassword(emailAddress: email, password: password);
                    } else {
                        authController.clearUserEmailAndPassword();
                    }
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const NavBarScreen()));
                }
            });
        }
    }
}

Future<bool> _onWillPop(BuildContext context) async {
    showAnimatedDialogHelper(
        context,
        CustomDialogWidget(
            icon: Icons.exit_to_app_rounded, title: 'exit'.tr,
            description: 'do_you_want_to_exit_the_app'.tr, onTapFalse:() => Navigator.of(context).pop(false),
            onTapTrue:() {
                SystemNavigator.pop();
            },
            onTapTrueText: 'yes'.tr, onTapFalseText: 'no'.tr,
        ),
        dismissible: false,
        isFlip: true
    );
    return true;
}