import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/consts/views/auth_screen/login_screen.dart';
import 'package:emart_app/consts/views/chat_screen/messaging_screen.dart';
import 'package:emart_app/consts/views/orders_screen/orders_screen.dart';
import 'package:emart_app/consts/views/profile_screen/components/details_cart.dart';
import 'package:emart_app/consts/views/profile_screen/edit_profile_screen.dart';
import 'package:emart_app/consts/views/wishlist_screen/wishlist_screen.dart';
import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/controllers/profile_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/loading_indicator.dart';
import 'package:get/get.dart';

import '../../consts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
             if(!snapshot.hasData){
               return const Center(
                 child: CircularProgressIndicator(
                   valueColor: AlwaysStoppedAnimation(redColor),
                 ),
               );
             }
             else {
               // variable to access data
               var data = snapshot.data!.docs[0];

               return SafeArea(
                   child: Column(
                     children: [
                       //edit profile button
                       Padding(
                         padding: const EdgeInsets.only(top: 10,right: 10),
                         child: const Align(
                             alignment: Alignment.topRight,
                             child: Icon(Icons.edit, color: whiteColor))
                             .onTap(() {
                               //for edit_profile_screen textfields
                           controller.nameController.text = data['name'];
                           auth.currentUser!.email;
                           Get.to(()=> EditProfileScreen(data: data));
                         }),
                       ),

                       //users detail section
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Row(
                           children: [
                             data['imageUrl'] == '' ?
                             Image.asset(imgProfile3, width: 50, fit: BoxFit.cover)
                                 .box
                                 .roundedFull
                                 .clip(Clip.antiAlias)
                                 .make()
                                 : Image.network(data['imageUrl'], width: 100, fit: BoxFit.cover)
                                 .box
                                 .roundedFull
                                 .clip(Clip.antiAlias)
                                 .make(),
                             10.widthBox,
                             Expanded(
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     "${data['name']}".text.fontFamily(semibold).white.make(),
                                     "${data['email']}".text.white.make(),
                                   ],
                                 )),
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
                       ),

                       20.heightBox,
                       FutureBuilder(
                         future: FirestoreServices.getCounts(),
                         builder: (BuildContext context, AsyncSnapshot snapshot){
                           if(!snapshot.hasData){
                             return Center(child: loadingIndicator());
                           }else{
                             var countData = snapshot.data;
                             return Row(
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               children: [
                                 detailsCard(
                                     count: countData[0].toString(),
                                     title: "in your cart",
                                     width: context.screenWidth / 3.4),
                                 detailsCard(
                                     count: countData[1].toString(),
                                     title: "in your wishlist",
                                     width: context.screenWidth / 3.4),
                                 detailsCard(
                                     count: countData[2].toString(),
                                     title: "your orders",
                                     width: context.screenWidth / 3.4),
                               ],
                             ).box.color(redColor).make();
                           }

                         },
                       ),


                       // Row(
                       //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       //   children: [
                       //     detailsCard(
                       //         count: data['cart_count'],
                       //         title: "in your cart",
                       //         width: context.screenWidth / 3.4),
                       //     detailsCard(
                       //         count: data['wishlist_count'],
                       //         title: "in your wishlist",
                       //         width: context.screenWidth / 3.4),
                       //     detailsCard(
                       //         count: data['order_count'],
                       //         title: "your orders",
                       //         width: context.screenWidth / 3.4),
                       //   ],
                       // ).box.color(redColor).make(),

                       //tab button section
                       ListView.separated(
                         shrinkWrap: true,
                         separatorBuilder: (context, index) {
                           return const Divider(
                             color: lightGrey,
                           );
                         },
                         itemCount: profileButtonsList.length,
                         itemBuilder: (context, index) {
                           return ListTile(
                             onTap: (){
                               switch(index){
                                 case 0:
                                   Get.to(()=> const OrdersScreen());
                                   break;
                                 case 1:
                                   Get.to(()=> const WishlistScreen());
                                   break;
                                 case 2:
                                   Get.to(()=> const MessagesScreen());
                                   break;
                               }
                               },
                             title: profileButtonsList[index].text.fontFamily(semibold).color(darkFontGrey).make(),
                             leading: Image.asset(profileButtonsIcon[index],width: 22,),
                           );
                         },
                       )
                           .box
                           .white
                           .roundedSM.margin(const EdgeInsets.all(12))
                           .padding(const EdgeInsets.symmetric(horizontal: 16))
                           .shadowSm.make().box.color(redColor).make(),
                     ],
                   ));

             }

          },
        ),
      ),
    );
  }
}

