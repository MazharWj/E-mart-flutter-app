import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/views/auth_screen/login_screen.dart';
import 'package:get/get.dart';

class SellerSettingsScreen extends StatelessWidget {
  const SellerSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            "Working on it".text.makeCentered(),
            TextButton(onPressed: (){Get.to(()=> const LoginScreen());}, child: "Log out".text.make()),
          ],
        ),


      ),
    );
  }
}
