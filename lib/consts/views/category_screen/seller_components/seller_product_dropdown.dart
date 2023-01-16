import 'package:emart_app/consts/consts.dart';

Widget productDropdown(){
  return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        hint: "Choose category".text.color(darkFontGrey).make(),
        value: null,
          isExpanded: true,
          items: const[], onChanged: (value){}
      ),
  ).box.white.roundedSM.padding(const EdgeInsets.symmetric(horizontal: 4.0)).make();
}