import 'package:emart_app/consts/views/home_screen/home_screen.dart';
import 'package:emart_app/widgets_common/exit_dialog.dart';
import 'package:get/get.dart';
import '../../../controllers/home_controller.dart';
import '../../consts.dart';
import '../cart_screen/cart_screen.dart';
import '../category_screen/category_screen.dart';
import '../profile_screen/profile_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //init home controller
    var controller = Get.put(HomeController());

    //navbar items list
    // var navbarItem = [
    //   BottomNavigationBarItem(icon: Image.asset(icHome, width: 26),label: home),
    //   BottomNavigationBarItem(icon: Image.asset(icCategories, width: 26),label: categories),
    //   BottomNavigationBarItem(icon: Image.asset(icCart, width: 26),label: cart),
    //   BottomNavigationBarItem(icon: Image.asset(icProfile, width: 26),label: account),
    // ];

    var navbarItem = [
      const BottomNavigationBarItem(icon: Icon(Icons.home,size: 26),label: home),
      const BottomNavigationBarItem(icon: Icon(Icons.category,size: 26),label: categories),
      const BottomNavigationBarItem(icon: Icon(Icons.shopping_cart,size: 26),label: cart),
      const BottomNavigationBarItem(icon: Icon(Icons.manage_accounts,size: 26),label: account),
    ];

    //Nav ontap bodies
    var navBody = [
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];

    return WillPopScope (
      onWillPop: () async {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => exitDialog(context),
        );
        return false;

      },
      child: Scaffold(
        // resizeToAvoidBottomInset: false,

        body: Column(
          children: [
            Obx( ()=> Expanded(child: navBody.elementAt(controller.currentNavIndex.value)) ),
          ],
        ),
        
        bottomNavigationBar: Obx(() =>
           BottomNavigationBar(
             currentIndex: controller.currentNavIndex.value,
               onTap: (value){
               controller.currentNavIndex.value = value;
               },
               type: BottomNavigationBarType.fixed,
              selectedItemColor: redColor,
               selectedIconTheme: const IconThemeData(color: redColor),
              selectedLabelStyle: const TextStyle(fontFamily: semibold),
              backgroundColor: whiteColor,
              items: navbarItem),
        ),
      ),
    );
  }
}
