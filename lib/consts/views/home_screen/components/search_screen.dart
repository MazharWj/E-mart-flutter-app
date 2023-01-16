import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/views/category_screen/item_details.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/widgets_common/loading_indicator.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: const Icon(Icons.arrow_back,color: darkFontGrey),
          ),
        title: title!.text.color(darkFontGrey).make(),
      ),
      body: FutureBuilder(
        future: FirestoreServices.searchProducts(title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(child: loadingIndicator());
          }else if(snapshot.data!.docs.isEmpty){
            return "No products found".text.size(16).color(darkFontGrey).make();
          }else {
            
            var data = snapshot.data!.docs;
            var filteredData = data.where((element) => element['p_name'].toString().toLowerCase().contains(title!.toLowerCase())).toList();
          
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8, mainAxisExtent: 310,
                ),
                children: filteredData.mapIndexed((currentValue, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(filteredData[index]['p_imgs'][0], width: 200, fit: BoxFit.cover,),
                    const Spacer(),
                    "${filteredData[index]['p_name']}".text.color(darkFontGrey).fontFamily(semibold).make(),
                    5.heightBox,
                    "Rs.${filteredData[index]['p_price']}".text.color(redColor).fontFamily(bold).size(16).make(),

                  ],
                ).box.white.outerShadowMd.roundedSM.p12.margin(const EdgeInsets.symmetric(horizontal: 4)).make().onTap(() {
                  Get.to(()=> ItemDetails(title: "${filteredData[index]['p_name']}",
                      data: filteredData[index]) );
                })
                ).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
