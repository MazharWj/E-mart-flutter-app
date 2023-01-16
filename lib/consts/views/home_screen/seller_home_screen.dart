import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/views/category_screen/seller_produt_details.dart';
import 'package:emart_app/seller_widgets_common/dashboard_button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class SellerHomeScreen extends StatelessWidget {
  const SellerHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: sellerDashboard.text.size(16.0).color(darkFontGrey).make(),
        actions: [
          Center(
            child: intl.DateFormat('EEE, MMM d, ' 'yy').format(DateTime.now()).text.color(darkFontGrey).make(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                dashboardButton(title: sellerProducts,count: "57",icon: sellerIcProducts,context),
                dashboardButton(title: sellerOrdersText,count: "12",icon: sellerIcOrders,context),
              ],
            ),
            10.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                dashboardButton(title: sellerStar,count: "5",icon: sellerIcStar,context),
                dashboardButton(title: sellerSales,count: "210", icon: sellerIcVerify,context),
              ],
            ),

            10.heightBox,
            const Divider(),
            10.heightBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: "Top Products".text.color(darkFontGrey).size(16.0).make(),
            ),
            ListView(
              physics:const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(3, (index) => ListTile(
                onTap: (){
                  Get.to(()=> const SellerProductDetails());
                },
                leading: Image.asset(sellerImgProduct,width: 100,height: 100,fit: BoxFit.cover),
                title: "Product title".text.color(darkFontGrey).make(),
                subtitle: "Rs. 4000".text.color(fontGrey).make(),
              )),
            ),

          ],
        ),
      ),
    );
  }
}
