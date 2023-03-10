import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/firebase_consts.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  @override
  void onInit(){
    getUsername();
    super.onInit();
  }

  //for navbar
  var currentNavIndex = 0.obs;

  //to get username
  var username = '';

  var searchController = TextEditingController();

  getUsername() async {
    var n = await firestore.collection(usersCollection).where('id', isEqualTo: currentUser!.uid).get().then((value) {
      if(value.docs.isNotEmpty) {
      return value.docs.single['name'];
    }
    });
    username = n;
  }




}