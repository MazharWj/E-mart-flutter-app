import 'package:emart_app/consts/views/auth_screen/seller_login_screen.dart';
import 'package:emart_app/consts/views/auth_screen/signup_screen.dart';
import 'package:emart_app/consts/views/home_screen/home.dart';
import 'package:emart_app/consts/views/home_screen/home_screen.dart';
import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/widgets_common/applogo_widget.dart';
import 'package:get/get.dart';
import '../../../widgets_common/bg_widget.dart';
import '../../../widgets_common/custom_textfield.dart';
import '../../../widgets_common/our_button.dart';
import '../../consts.dart';
import '../../lists.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            //for responsive margin top
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Obx(
              () => Column(
                children: [
                  customTextField(
                      hint: emailHint,
                      title: email,
                      controller: controller.emailController,
                      isPass: false),
                  customTextField(
                      hint: passwordHint,
                      title: password,
                      controller: controller.passwordController,
                      isPass: true),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: TextButton(
                  //     onPressed: () {},
                  //     child: forgetPass.text.make(),
                  //   ),
                  // ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Get.to(()=> const SellerLoginScreen());
                      },
                      child: selleraccount.text.make(),
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
                          color: redColor,
                          title: login,
                          textColor: whiteColor,
                          onPress: () async {
                            controller.isloading(true);
                            await controller
                                .loginMethod(context: context)
                                .then((value) {
                              if (value != null) {
                                VxToast.show(context, msg: loggedin);
                                Get.offAll(() => const Home());
                              } else {
                                controller.isloading(false);
                              }
                            });
                          }).box.width(context.screenWidth - 50).make(),
                  5.heightBox,
                  createNewAccount.text.color(fontGrey).make(),
                  5.heightBox,

                  //SignUp Button
                  ourButton(
                      color: lightGolden,
                      title: signup,
                      textColor: redColor,
                      onPress: () {
                        Get.to(() => const SignupScreen());
                      }).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  loginWith.text.color(fontGrey).make(),
                  5.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: lightGrey,
                                radius: 25,
                                child: Image.asset(
                                  socialIconList[index],
                                  width: 30,
                                ),
                              ).onTap(() async {
                                bool result = await AuthService().googleLoginMethod();
                                if(result){
                                  Get.to(()=> const HomeScreen());
                                }

                              }),
                            )),
                  )
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
