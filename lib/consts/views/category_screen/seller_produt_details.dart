import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;


class SellerProductDetails extends StatelessWidget {
  const SellerProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: "Product Title".text.size(16.0).color(darkFontGrey).make(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // data['p_imgs'].length
            VxSwiper.builder(
                viewportFraction: 1.0,
                autoPlay: true,
                height: 350,
                aspectRatio: 16 / 9,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Image.asset(sellerImgProduct,
                      width: double.infinity, fit: BoxFit.cover);
                }),
            10.heightBox,
            //title and details section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "Product Title".text
                      .size(16)
                      .color(darkFontGrey)
                      .fontFamily(semibold)
                      .make(),
                  10.heightBox,
                  Row(
                    children: [
                      "Category:".text.color(darkFontGrey).size(16.0).make(),
                      10.widthBox,
                      "Subcategory".text.color(darkFontGrey).size(16.0).make(),
                    ],
                  ),
                  //rating
                  VxRating(
                    isSelectable: false,
                    // value: double.parse(data['p_rating'] ),
                    onRatingUpdate: (value) {},
                    // maxRating: 5,
                    normalColor: textFieldGrey,
                    selectionColor: golden,
                    count: 5,
                    size: 25,
                  ),
                  10.heightBox,
                  // "Rs. ${data['p_price']}"
                "Rs.4000".text
                      .color(redColor)
                      .fontFamily(bold)
                      .size(18)
                      .make(),
                  //colors selection section
                  20.heightBox,
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: "Color: ".text.color(darkFontGrey).make(),
                          ),
                          Row(
                              // data['p_colors'].length
                            children: List.generate(3, (index) => VxBox().size(40, 40).roundedFull.margin(const EdgeInsets.symmetric(horizontal: 4)).color(Vx.randomPrimaryColor).make().onTap(() {
                              // controller.changeColorIndex(index);
                            }),
                            ),
                          ),
                        ],
                      ),
                      10.heightBox,
                      //quantity selection row
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: "Quantity: ".text.color(darkFontGrey).make(),
                          ),
                          "20 Items".text.make(),
                        ],
                      ),

                    ],
                  ).box.p12.white.shadowSm.make(),

                  //description section
                  10.heightBox,
                  "Description".text.color(darkFontGrey).fontFamily(semibold).make(),
                  10.heightBox,
                  "descp startskkc....".text.color(darkFontGrey).make(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
