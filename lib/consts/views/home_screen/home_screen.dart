import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/views/category_screen/item_details.dart';
import 'package:emart_app/consts/views/home_screen/components/search_screen.dart';
import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/controllers/home_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/widgets_common/loading_indicator.dart';
import 'package:get/get.dart';

import '../../../widgets_common/home_buttons.dart';
import '../../consts.dart';
import '../../lists.dart';
import '../auth_screen/login_screen.dart';
import 'components/featured_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();

    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              color: lightGrey,
              child: TextFormField(
                controller: controller.searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: const Icon(Icons.search).onTap(() {
                    if(controller.searchController.text.isNotEmptyAndNotNull) {
                      Get.to(() =>
                          SearchScreen(
                              title: controller.searchController.text));
                    }
                  }),
                  filled: true,
                  fillColor: whiteColor,
                  hintText: searchanything,
                  hintStyle: const TextStyle(color: textFieldGrey),
                ),
              ),
            ),
            20.heightBox,

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [

                    //Swiper Brands
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 150,
                        viewportFraction: 1.0,
                        enlargeCenterPage: true,
                        itemCount: slidersList.length, itemBuilder: (context, index){
                      return Image.asset(slidersList[index],fit: BoxFit.fill,
                      ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make();
                    }
                    ),
                    20.heightBox,
                    //deal buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(2, (index) => homeButtons(
                        height: context.screenHeight * 0.15,
                        width: context.screenWidth / 2.5,
                        icon: index == 0 ? icTodaysDeal : icFlashDeal,
                        title: index == 0 ? todayDeal : flashsale,
                      )),
                    ),

                    //2nd Swiper
                    20.heightBox,
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 150,
                        enlargeCenterPage: true,
                        itemCount: secondSlidersList.length, itemBuilder: (context, index){
                      return Image.asset(secondSlidersList[index],fit: BoxFit.fill,
                      ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make();
                    }
                    ),

                    //category buttons
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(3, (index) => homeButtons(
                        height: context.screenHeight * 0.15,
                        width: context.screenWidth / 3.5,
                        icon: index == 0 ? icTopCategories : index == 1 ? icBrands : icTopSeller,
                        title: index == 0 ? topCategories : index == 1 ? brand : topSellers,
                      )),
                    ),

                    //featured categories
                    20.heightBox,

                    Align(
                        alignment: Alignment.centerLeft,
                        child: featuredCategories.text.color(darkFontGrey).size(18).fontFamily(semibold).make()),
                    20.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(3, (index) => Column(
                          children: [
                            featuredButton(icon: featuredImages1[index], title: featuredTitles1[index]),
                            10.heightBox,
                            featuredButton(icon: featuredImages2[index], title: featuredTitles2[index]),
                          ],
                        ),
                        ).toList(),
                      ),
                    ),

                    //featured product
                     20.heightBox,
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: redColor
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredProduct.text.white.fontFamily(bold).size(18).make(),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(3, (index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(imgP1, width: 150, fit: BoxFit.cover,),
                                  10.heightBox,
                                  "Laptop 4Gb/64GB".text.color(darkFontGrey).fontFamily(semibold).make(),
                                  10.heightBox,
                                  "\$600".text.color(redColor).fontFamily(bold).size(16).make(),
                                ],
                              ).box.white.roundedSM.p8.margin(const EdgeInsets.symmetric(horizontal: 4)).make(),),
                            ),
                          ),
                        ],

                      ),
                    ),

                    //third swiper
                    // 20.heightBox,
                    // VxSwiper.builder(
                    //     aspectRatio: 16 / 9,
                    //     autoPlay: true,
                    //     height: 150,
                    //     enlargeCenterPage: true,
                    //     itemCount: secondSlidersList.length, itemBuilder: (context, index){
                    //   return Image.asset(secondSlidersList[index],fit: BoxFit.fill,
                    //   ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make();
                    // }
                    // ),

                    // all products section
                    20.heightBox,
                    Column(
                      children: [
                        featuredCategories.text.color(darkFontGrey).size(18).fontFamily(semibold).make(),
                        20.heightBox,
                        StreamBuilder(
                          stream: FirestoreServices.getAllProducts(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                            if(!snapshot.hasData){
                              return loadingIndicator();
                            }else{
                              var allproductsdata = snapshot.data!.docs;
                              return GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: allproductsdata.length,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8, mainAxisExtent: 310,
                                ),
                                itemBuilder: (context, index){
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.network(allproductsdata[index]['p_imgs'][0], width: 200, fit: BoxFit.cover,),
                                      const Spacer(),
                                      "${allproductsdata[index]['p_name']}".text.color(darkFontGrey).fontFamily(semibold).make(),
                                      5.heightBox,
                                      "Rs.${allproductsdata[index]['p_price']}".text.color(redColor).fontFamily(bold).size(16).make(),

                                    ],
                                  ).box.white.roundedSM.p12.margin(const EdgeInsets.symmetric(horizontal: 4)).make().onTap(() {
                                    Get.to(()=> ItemDetails(title: "${allproductsdata[index]['p_name']}",
                                    data: allproductsdata[index]) );
                                  });

                                },
                              );

                            }

                          },
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: whiteColor)),
                          onPressed: () async {
                            await Get.put(AuthController()).signOutMethod(context);
                            Get.offAll( ()=>const LoginScreen() );
                          },
                          child: "Log out".text.fontFamily(semibold).white.make(),
                        )
                      ],

                    ),


                    // all products section
                    // 20.heightBox,
                    // GridView.builder(
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   shrinkWrap: true,
                    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //   crossAxisCount: 2,
                    //     mainAxisSpacing: 8,
                    //     crossAxisSpacing: 8,
                    //     mainAxisExtent: 300,
                    // ), itemBuilder: (context, index){
                    //   return Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Image.asset(imgP5, width: 200, fit: BoxFit.cover,),
                    //       const Spacer(),
                    //       "Laptop 4Gb/64GB".text.color(darkFontGrey).fontFamily(semibold).make(),
                    //       10.heightBox,
                    //       "\$600".text.color(redColor).fontFamily(bold).size(16).make(),
                    //
                    //     ],
                    //   ).box.white.roundedSM.p12.margin(const EdgeInsets.symmetric(horizontal: 4)).make();
                    // },),


                  ],
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
