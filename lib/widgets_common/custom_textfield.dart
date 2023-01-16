import 'package:emart_app/consts/consts.dart';

Widget customTextField({String? title, String? hint, controller,isPass}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    title!.text.color(redColor).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
        obscureText: isPass,
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: semibold,
            color: textFieldGrey,
          ),
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: redColor
            ),
          ),
        ),
      ),
      5.heightBox,
    ],
  );
}


Widget sellerCustomTextField({label, hint, controller,isPass, isDesc = false, textFieldColor = false, hintTextColor = false, icon = false}){
  return TextFormField(
    style: textFieldColor ? const TextStyle(color: whiteColor) : const TextStyle(color: darkFontGrey),
        obscureText: isPass,
        controller: controller,
        maxLines: isDesc ? 4 : 1,
        decoration: InputDecoration(
          // prefixIcon: icon ? const Icon(Icons.email) : const Icon(Icons.lock),
          hintText: hint,
          label: Text(label),
          labelStyle: hintTextColor ? const TextStyle(color:  whiteColor) : const TextStyle(color: darkFontGrey),
          hintStyle: const TextStyle(
            fontFamily: semibold,
            color: whiteColor,
          ),
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
                color: whiteColor
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
                color: whiteColor
            ),
          ),
        ),
      );

}

Widget sellerCustomTextFieldLogin({label, hint, controller,isPass, isDesc = false, textFieldColor = false, hintTextColor = false, icon = false}){
  return TextFormField(
    style: textFieldColor ? const TextStyle(color: whiteColor) : const TextStyle(color: darkFontGrey),
    obscureText: isPass,
    controller: controller,
    maxLines: isDesc ? 4 : 1,
    decoration: InputDecoration(
      prefixIcon: icon ? const Icon(Icons.email) : const Icon(Icons.lock),
      hintText: hint,
      label: Text(label),
      labelStyle: hintTextColor ? const TextStyle(color:  whiteColor) : const TextStyle(color: darkFontGrey),
      hintStyle: const TextStyle(
        fontFamily: semibold,
        color: whiteColor,
      ),
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
            color: whiteColor
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
            color: whiteColor
        ),
      ),
    ),
  );

}


// Widget sellerCustomTextField({String? title, String? hint, controller,isPass, isDesc = false}){
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       title!.text.color(purpleColor).fontFamily(semibold).size(16).make(),
//       5.heightBox,
//       TextFormField(
//         obscureText: isPass,
//         controller: controller,
//         maxLines: isDesc ? 4 : 1,
//         decoration: InputDecoration(
//           hintText: hint,
//           hintStyle: const TextStyle(
//             fontFamily: semibold,
//             color: textFieldGrey,
//           ),
//           isDense: true,
//           fillColor: lightGrey,
//           filled: true,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(
//                 color: whiteColor
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(
//                 color: whiteColor
//             ),
//           ),
//         ),
//       ),
//       5.heightBox,
//     ],
//   );
// }