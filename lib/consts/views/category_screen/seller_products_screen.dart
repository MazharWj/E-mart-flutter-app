import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/views/category_screen/seller_add_product.dart';
import 'package:emart_app/consts/views/category_screen/seller_produt_details.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class SellerProductsScreen extends StatelessWidget {
  const SellerProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(()=> const SellerAddProduct());
        },
        backgroundColor: purpleColor,
        child: const Icon(Icons.add),
      ),
      backgroundColor: whiteColor,
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
        child: SingleChildScrollView(
          physics:const BouncingScrollPhysics(),
          child: Column(
            children: List.generate(6, (index) => ListTile(
              onTap: (){
                Get.to(()=> const SellerProductDetails());
              },
              leading: Image.asset(sellerImgProduct,width: 100,height: 100,fit: BoxFit.cover),
              title: "Product title".text.color(darkFontGrey).make(),
              subtitle: "Rs. 4000".text.color(fontGrey).make(),
            )),
          ),
        ),
      ),
    );
  }
}
