import 'package:emart_app/consts/consts.dart';

Widget dashboardButton(context, {title,count,icon}){
  var size = MediaQuery.of(context).size;
  return Row(
    children: [
      Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,style: const TextStyle(fontSize: 16.0,color: whiteColor)),
              Text(count,style: const TextStyle(fontSize: 16.0,color: whiteColor)),
              // title.text.size(16.0).make(),
              // count.text.size(20.0).make(),
            ],
          ),
      ),
      Image.asset(icon,width: 40,color: whiteColor),
    ],
  ).box.color(purpleColor).rounded.p8.size(size.width * 0.4, 80).make();
}