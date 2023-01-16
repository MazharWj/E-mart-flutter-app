import 'package:emart_app/consts/views/category_screen/seller_products_screen.dart';
import 'package:emart_app/consts/views/home_screen/seller_home_screen.dart';
import 'package:emart_app/consts/views/orders_screen/seller_orders_screen.dart';
import 'package:emart_app/consts/views/settings_screen/seller_settings_screen.dart';
import 'package:emart_app/seller_controllers/seller_home_controller.dart';
import 'package:emart_app/widgets_common/exit_dialog.dart';
import 'package:get/get.dart';
import '../../consts.dart';

class SellerHome extends StatelessWidget {
  const SellerHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //init home controller
    var controller = Get.put(SellerHomeController());

    //navbar items list
    // var navbarItem = [
    //   BottomNavigationBarItem(icon: Image.asset(icHome, width: 26),label: home),
    //   BottomNavigationBarItem(icon: Image.asset(icCategories, width: 26),label: categories),
    //   BottomNavigationBarItem(icon: Image.asset(icCart, width: 26),label: cart),
    //   BottomNavigationBarItem(icon: Image.asset(icProfile, width: 26),label: account),
    // ];

    var navbarItem = [
      const BottomNavigationBarItem(icon: Icon(Icons.dashboard,size: 26),label: sellerDashboard),
      const BottomNavigationBarItem(icon: Icon(Icons.category,size: 26),label: sellerProducts),
      const BottomNavigationBarItem(icon: Icon(Icons.list,size: 26),label: sellerOrders),
      const BottomNavigationBarItem(icon: Icon(Icons.settings,size: 26),label: sellerSettings),
    ];

    //Nav ontap bodies
    var navBody = [
      const SellerHomeScreen(),
      const SellerProductsScreen(),
      const SellerOrdersScreen(),
      const SellerSettingsScreen(),
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
                selectedItemColor: purpleColor,
                selectedIconTheme: const IconThemeData(color: purpleColor),
                selectedLabelStyle: const TextStyle(fontFamily: semibold),
                backgroundColor: whiteColor,
                items: navbarItem),
        ),
      ),
    );
  }
}
