import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/views/orders_screen/components/seller_order_place_details.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class SellerOrderDetails extends StatelessWidget {
  const SellerOrderDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 60,
        width: context.screenWidth,
        child: ourButton(
          color: green,
          title: "Confirm Order",
          onPress: (){

          }
        ),
      ),
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Order Details".text.size(16.0).color(darkFontGrey).make(),
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: const Icon(Icons.arrow_back,color: darkFontGrey,),
        ),
        actions: [
          Center(
            child: intl.DateFormat('EEE, MMM d, ' 'yy').format(DateTime.now()).text.color(darkFontGrey).make(),
          ),
        ],

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              //order delivery status section
              Visibility(
                visible: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Order Status".text.size(16.0).color(fontGrey).make(),
                    SwitchListTile(
                        value: true,
                        onChanged: (value){},
                      title: "Placed".text.fontFamily(bold).color(darkFontGrey).make(),
                      activeColor: green,
                    ),
                    SwitchListTile(
                      value: false,
                      onChanged: (value){},
                      title: "Confirmed".text.fontFamily(bold).color(darkFontGrey).make(),
                      activeColor: green,
                    ),
                    SwitchListTile(
                      value: false,
                      onChanged: (value){},
                      title: "On Delivery".text.fontFamily(bold).color(darkFontGrey).make(),
                      activeColor: green,
                    ),
                    SwitchListTile(
                      value: false,
                      onChanged: (value){},
                      title: "Delivered".text.fontFamily(bold).color(darkFontGrey).make(),
                      activeColor: green,
                    ),

                  ],
                ).box.p8.outerShadowMd.border(color: lightGrey).roundedSM.white.make(),
              ),


              //order details section
              Column(
                children: [
                  sellerOrderPlaceDetails(
                      d1: "239483",
                      d2: "Cash On Delivery",
                      title1: "Order Code",
                      title2: "Shipping Method"
                  ),

                  sellerOrderPlaceDetails(
                      // d1: intl.DateFormat().add_yMd().format((data['order_date'].toDate())),
                    d1: "12/5/2022",
                      d2: "Cash On Delivery",
                      title1: "Order Date",
                      title2: "Payment Method"
                  ),
                  sellerOrderPlaceDetails(
                      d1: "Unpaid",
                      d2: "Order Placed",
                      title1: "Payment Status",
                      title2: "Delivery Status"
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             "Shipping Address".text.fontFamily(semibold).make(),
                            "Zahid".text.make(),
                            "zahid@gmail.com".text.make(),
                            "xyz street, Dha city".text.make(),
                            "lahore".text.make(),
                            "Punjab".text.make(),
                            "0302-5587968".text.make(),
                            "75290".text.make(),
                            // "${data['order_by_name']}".text.make(),
                            // "${data['order_by_email']}".text.make(),
                            // "${data['order_by_address']}".text.make(),
                            // "${data['order_by_city']}".text.make(),
                            // "${data['order_by_state']}".text.make(),
                            // "${data['order_by_phone']}".text.make(),
                            // "${data['order_by_postalcode']}".text.make(),
                          ],
                        ),
                        SizedBox(
                          width: 120,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Total Amount".text.fontFamily(semibold).make(),
                              // "${data['total_amount']}".text.color(redColor).fontFamily(bold).make(),
                              "Rs.30000".text.color(redColor).fontFamily(bold).make(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ).box.outerShadowMd.border(color: lightGrey).roundedSM.white.make(),

              const Divider(),
              10.heightBox,
              "Ordered Products".text.fontFamily(semibold).color(darkFontGrey).makeCentered(),
              10.heightBox,
              ListView(
                // data['orders'].length
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(1, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sellerOrderPlaceDetails(
                          // title1: data['orders'][index]['title'],
                          title1: "Beauty Box",
                          title2: "Rs.15000",
                          d1: "x2",
                          d2: "Product Amount"),

                      // not working
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      //   child: Container(
                      //     width: 30,
                      //     height: 20,
                      //     color: Color(data['orders'][index]['color']),
                      //   ),
                      // ),
                      const Divider(),
                    ],
                  );

                }).toList(),
              ).box.outerShadowMd.margin(const EdgeInsets.only(bottom:4)).white.make(),

              20.heightBox,


            ],
          ),
        ),
      ),
    );
  }
}
