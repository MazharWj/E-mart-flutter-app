import 'package:emart_app/consts/consts.dart';

Widget sellerProductImages({required label, onPress}){
  return "$label".text.bold.color(darkFontGrey).size(16.0).makeCentered().box.color(lightGrey).size(100, 100).roundedSM.margin(const EdgeInsets.symmetric(horizontal: 4.0)).make();
}