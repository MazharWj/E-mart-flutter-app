import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/views/orders_screen/seller_order_details.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class SellerOrdersScreen extends StatelessWidget {
  const SellerOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: const Icon(Icons.arrow_back,color: darkFontGrey,),
          ),
          backgroundColor: whiteColor,
          automaticallyImplyLeading: false,
          title: sellerOrdersText.text.size(16.0).color(darkFontGrey).make(),
          actions: [
            Center(
              child: intl.DateFormat('EEE, MMM d, ' 'yy')
                  .format(DateTime.now())
                  .text
                  .color(darkFontGrey)
                  .make(),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: List.generate(
                  2,
                      (index) => ListTile(
                    onTap: (){
                      Get.to(()=> const SellerOrderDetails());
                    },
                    tileColor: textFieldGrey,
                    title: Column(
                      children: [
                        Row(
                          children: [
                            "873483434".text.make(),
                            10.widthBox,
                            "Product title".text.color(darkFontGrey).make(),
                          ],
                        )
                      ],
                    ),

                    subtitle: Row(
                      children:  [
                        const Icon(Icons.payment),
                        "Unpaid".text.color(purpleColor).make(),
                      ],
                    ),

                    // subtitle: Column(
                    //   children: [
                    //     Row(
                    //       children: [
                        // to retrieve date and time -> var time = data[index]['order_date'].toDate();
                    //         const Icon(Icons.calendar_month),
                    //         color(darkFontGrey),
                    //         10.widthBox,
                        //
                    //         intl.DateFormat()
                    //             .add_yMd()
                    //             .format(time)
                    //             .text
                    //             .color(purpleColor)
                    //             .make(),
                    //       ],
                    //     ),
                    //     Row(
                    //       children: [
                    //         const Icon(Icons.payment),
                    //         color(darkFontGrey),
                    //         10.widthBox,
                    //         "Unpaid".text.color(purpleColor).make(),
                    //       ],
                    //     )
                    //   ],
                    // ),
                    trailing: "Rs. 4000.00".text.size(16.0).color(purpleColor).make(),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                  ).box.margin(const EdgeInsets.only(bottom: 4.0)).make()),
            ),
          ),
        ),


      ),
    );
  }
}
