import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/consts/views/home_screen/home.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:emart_app/widgets_common/loading_indicator.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:get/get.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Payment Method"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: darkFontGrey,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => Column(
                  children: List.generate(paymentMethodsImg.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        controller.changePaymentIndex(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: controller.paymentIndex.value == index
                                ? redColor
                                : Colors.transparent,
                            width: 4,
                          ),
                        ),
                        clipBehavior: Clip.antiAlias,
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Stack(alignment: Alignment.topRight, children: [
                          Image.asset(
                            paymentMethodsImg[index],
                            width: double.infinity,
                            height: 120,
                            fit: BoxFit.cover,
                            colorBlendMode:
                                controller.paymentIndex.value == index
                                    ? BlendMode.darken
                                    : BlendMode.color,
                            color: controller.paymentIndex.value == index
                                ? Colors.black.withOpacity(0.4)
                                : Colors.transparent,
                          ),
                          controller.paymentIndex.value == index
                              ? Transform.scale(
                                  scale: 1.3,
                                  child: Checkbox(
                                    activeColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    value: true,
                                    onChanged: (value) {},
                                  ),
                                )
                              : Container(),
                          Positioned(
                              bottom: 10,
                              right: 10,
                              child: paymentMethods[index]
                                  .text
                                  .white
                                  .fontFamily(semibold)
                                  .size(16)
                                  .make()),
                        ]),
                      ),
                    );
                  }),
                ),
              ),
            ),
            Obx(
              () => controller.placingOrder.value
                  ? Center(
                      child: loadingIndicator(),
                    )
                  : SizedBox(
                      width: context.screenWidth - 60,
                      child: ourButton(
                        color: redColor,
                        onPress: () async {
                          await controller.placeMyOrder(
                              orderPaymentMethod:
                                  paymentMethods[controller.paymentIndex.value],
                              totalAmount: controller.totalP.value);
                          await controller.cleaCart();
                          VxToast.show(context, msg: "Order Placed Successfully");
                          Get.offAll(const Home());
                        },
                        textColor: whiteColor,
                        title: "Place my order",
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
