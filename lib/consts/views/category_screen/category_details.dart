import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/views/category_screen/item_details.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/loading_indicator.dart';
import 'package:get/get.dart';

class CategoryDetails extends StatefulWidget {
  final String? title;
  const CategoryDetails({Key? key, required this.title}) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switchCategory(widget.title);
  }

  //category switch between subcategory and product category
  switchCategory(title){
    if(controller.subcat.contains(title)){
      productMethod = FirestoreServices.getSubCategoryProducts(title);
    }else{
      productMethod = FirestoreServices.getProducts(title);
    }
  }

  var controller = Get.find<ProductController>();

  dynamic productMethod;

  @override
  Widget build(BuildContext context) {

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: widget.title!.text.fontFamily(bold).white.make(),
        ),
        body: StreamBuilder(
          stream: productMethod,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(!snapshot.hasData){
              return Center(
                child: loadingIndicator(),
              );
            } else if(snapshot.data!.docs.isEmpty) {
              return Center(
                child: "No products found!".text.color(darkFontGrey).make(),
              );
            }
            else{
              // show the products
              var data  = snapshot.data!.docs;

              return Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(controller.subcat.length, (index) => "${controller.subcat[index]}".text.fontFamily(semibold).size(12).color(darkFontGrey).makeCentered().box.rounded.white.size(120, 60).margin(const EdgeInsets.symmetric(horizontal: 4)).make().onTap(() {
                          switchCategory("${controller.subcat[index]}");
                          setState(() {});
                        })),
                      ),
                    ),

                    //GridView of Category Products
                    20.heightBox,
                    Expanded(
                        child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,mainAxisExtent: 250,crossAxisSpacing: 8,mainAxisSpacing: 8
                        ), itemBuilder: (context, index){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(data[index]['p_imgs'][0], width: 200,height: 150, fit: BoxFit.cover,),
                          "${data[index]['p_name']}".text.color(darkFontGrey).fontFamily(semibold).make(),
                          "Rs. ${data[index]['p_price']}".text.color(redColor).fontFamily(bold).size(16).make(),
                          10.heightBox,

                        ],
                      ).box.white.roundedSM.outerShadowSm.p12.margin(const EdgeInsets.symmetric(horizontal: 4)).make().onTap(() {
                        controller.checkIfFav(data[index]);
                        Get.to( ()=> ItemDetails(title: "${data[index]['p_name']}",data: data[index]));
                      });
                    }
                    ))


                  ],
                ),
              );

            }
          },
        ),
      ));
  }
}
