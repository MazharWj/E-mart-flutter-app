import 'package:emart_app/consts/views/auth_screen/login_screen.dart';
import 'package:emart_app/consts/views/home_screen/seller_home.dart';
import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/widgets_common/applogo_widget.dart';
import 'package:get/get.dart';
import '../../../widgets_common/bg_widget.dart';
import '../../../widgets_common/custom_textfield.dart';
import '../../../widgets_common/our_button.dart';
import '../../consts.dart';

class SellerLoginScreen extends StatelessWidget {
  const SellerLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return bgWidget(
        child: Scaffold(
          backgroundColor: purpleColor,
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              children: [
                //for responsive margin top
                (context.screenHeight * 0.1).heightBox,
                sellerApplogoWidget(),
                10.heightBox,
                "Log in to $sellerappname".text.fontFamily(bold).white.size(18).make(),
                15.heightBox,
                Obx(
                      () => Column(
                    children: [
                      sellerCustomTextFieldLogin(
                        icon: true,
                        textFieldColor: false,
                          hint: emailHint,
                          label: email,
                          controller: controller.emailController,
                          isPass: false),
                      10.heightBox,
                      sellerCustomTextFieldLogin(
                          textFieldColor: false,
                          hint: passwordHint,
                          label: password,
                          controller: controller.passwordController,
                          isPass: true),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Get.to(()=> const LoginScreen());
                          },
                          child: customerlogin.text.make(),
                        ),
                      ),
                      5.heightBox,
                      //simple button
                      // ourButton().box.width(context.screenWidth - 50).make(),
                      //dynamic variables buttons

                      //SignIn Button
                      controller.isloading.value
                          ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                          : ourButton(
                          color: purpleColor,
                          title: login,
                          textColor: whiteColor,
                          // onPress: () async {
                          //   controller.isloading(true);
                          //   await controller
                          //       .loginMethod(context: context)
                          //       .then((value) {
                          //     if (value != null) {
                          //       VxToast.show(context, msg: loggedin);
                          //       Get.offAll(() => const Home());
                          //     } else {
                          //       controller.isloading(false);
                          //     }
                          //   });
                          // }
                        onPress: (){Get.to(()=> const SellerHome());}
                          ).box.width(context.screenWidth - 50).make(),
                      "Seller login portal is in construction mode.".text.color(Colors.red).make(),
                    ],
                  )
                      .box
                      .white
                      .rounded
                      .p16
                      .width(context.screenWidth - 70)
                      .shadowSm
                      .make(),
                ),
              ],
            ),
          ),
        ));
  }
}
