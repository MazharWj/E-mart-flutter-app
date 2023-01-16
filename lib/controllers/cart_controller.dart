import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/home_controller.dart';
import 'package:get/get.dart';

class CartController extends GetxController{

  var totalP = 0.obs;

  //text controllers for shipping details
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postalcodeController = TextEditingController();
  var phoneController = TextEditingController();

  var paymentIndex = 0.obs;

  //passing the data from cart screen
  late dynamic productSnapshot;
  var products = [];

  var placingOrder = false.obs;


//cart total amount calculate
  calculate(data){
    //to reset value when loading
    totalP.value = 0;
    //to calculate the total
    for (var i = 0; i < data.length; i++){
      totalP.value = totalP.value + int.parse(data[i]['tprice'].toString());
    }
  }

  //Change Payment Method CheckBox
  changePaymentIndex(index){
    paymentIndex.value = index;
  }

  //Place Order
  placeMyOrder({required orderPaymentMethod,required totalAmount})async{
    placingOrder(true);
    await getProductDetails();
    await firestore.collection(ordersCollection).doc().set({
      'order_code': "235484564",
      'order_date': FieldValue.serverTimestamp(),
      'order_by': currentUser!.uid,
      'order_by_name': Get.find<HomeController>().username,
      'order_by_email': currentUser!.email,
      'order_by_address': addressController.text,
      'order_by_state': stateController.text,
      'order_by_city': cityController.text,
      'order_by_phone': phoneController.text,
      'order_by_postalcode': postalcodeController.text,
      'shipping_method': "Home Delivery",
      'payment_method': orderPaymentMethod,
      'order_placed': true,
      'order_confirmed': false,
      'order_delivered': false,
      'order_on_delivery': false,
      'total_amount': totalAmount,
      'orders': FieldValue.arrayUnion(products)
    });
     placingOrder(false);
    //     .catchError((error){
    //   VxToast.show(context, msg: error.toString());
    // });
  }

  //getting product for place order method
  getProductDetails(){
     products.clear();
    for(var i = 0; i < productSnapshot.length; i++){
      products.add({
        'colors': productSnapshot[i]['color'],
        'img': productSnapshot[i]['img'],
        'vendor_id': productSnapshot[i]['vendor_id'],
        'tprice': productSnapshot[i]['tprice'],
        'qty': productSnapshot[i]['qty'],
        'title': productSnapshot[i]['title']
      });
    }
  }

//clear cart after placing order
  cleaCart(){
    for(var i = 0; i< productSnapshot.length; i++){
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }

  }



}