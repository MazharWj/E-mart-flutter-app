import 'package:emart_app/consts/consts.dart';

Widget applogoWidget() {
  //using velocity-x here
  return Image.asset(icAppLogo).box.white.size(77,77).p8.rounded.make();
}

Widget sellerApplogoWidget() {
  //using velocity-x here
  return Image.asset(sellerIcLogo).box.size(77,77).p8.rounded.make();
}