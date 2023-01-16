import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/views/category_screen/seller_components/seller_product_dropdown.dart';
import 'package:emart_app/consts/views/category_screen/seller_components/seller_product_images.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:get/get.dart';

class SellerAddProduct extends StatelessWidget {
  const SellerAddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: const Icon(Icons.arrow_back,color: whiteColor,),
        ),
        // backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        title: "Product Title".text.size(16.0).color(whiteColor).make(),
        actions: [
          TextButton(onPressed: (){}, child: "Save".text.fontFamily(bold).color(whiteColor).make())
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sellerCustomTextField(isPass: false, hint: "eg. BMW", label: "Product name",textFieldColor: true, hintTextColor: true),
              10.heightBox,
              sellerCustomTextField(isPass: false, hint: "eg. Nice product", label: "Description",isDesc: true,textFieldColor: true,hintTextColor: true),
              10.heightBox,
              sellerCustomTextField(isPass: false, hint: "eg. Rs.100", label: "Price",textFieldColor: true,hintTextColor: true),
              10.heightBox,
              sellerCustomTextField(isPass: false, hint: "eg. 20", label: "Quantity",textFieldColor: true,hintTextColor: true),
              10.heightBox,
              productDropdown(),
              10.heightBox,
              productDropdown(),
              10.heightBox,
              const Divider(color: whiteColor),
              "Choose product images:".text.fontFamily(bold).color(lightGrey).make(),
              5.heightBox,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(6, (index) => sellerProductImages(label: "${index + 1}")).toList(),
                ),
              ),
              5.heightBox,
              "First image will be your display image.".text.color(lightGrey).make(),
              const Divider(color: whiteColor),
              10.heightBox,
              "Choose product colors:".text.fontFamily(bold).color(lightGrey).make(),
              10.heightBox,
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: List.generate(6, (index) => Stack(
                  alignment: Alignment.center,
                  children: [
                    VxBox().color(Vx.randomPrimaryColor).roundedFull.size(50, 50).make(),
                    const Icon(Icons.done,color: whiteColor)
                  ],
                ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
