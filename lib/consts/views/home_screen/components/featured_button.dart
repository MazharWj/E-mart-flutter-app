import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/views/category_screen/category_details.dart';
import 'package:get/get.dart';

Widget featuredButton({String? title, icon}){
  return Row(
    children: [
      Image.asset(icon,width: 60, fit: BoxFit.fill,),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  ).box.white.width(200).p4.margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.outerShadowSm.make().onTap(() {
    Get.to(()=> CategoryDetails(title: title));
  });
}
