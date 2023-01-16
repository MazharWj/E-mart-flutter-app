import 'dart:io';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/profile_controller.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;

  const EditProfileScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //if data image url and controller path is empty
              data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                  ? Image.asset(imgProfile3, width: 50, fit: BoxFit.cover)
                      .box
                      .roundedFull
                      .clip(Clip.antiAlias)
                      .make()
                  //if data is not empty but controller path is empty
                  : data['imageUrl'] != '' &&
                          controller.profileImgPath.isEmpty
                      ? Image.network(data['imageUrl'],
                              width: 100, fit: BoxFit.cover)
                          .box
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make()
                      //else if controller path is not empty but data image url is
                      : Image.file(File(controller.profileImgPath.value),
                              width: 100, fit: BoxFit.cover)
                          .box
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make(),
              10.heightBox,
              ourButton(
                  color: redColor,
                  title: "change",
                  textColor: whiteColor,
                  onPress: () {
                    controller.changeImage(context);
                  }),
              const Divider(),
              20.heightBox,
              customTextField(
                  hint: nameHint,
                  title: name,
                  isPass: false,
                  controller: controller.nameController),
              10.heightBox,
              customTextField(
                  hint: passwordHint,
                  title: oldpass,
                  isPass: true,
                  controller: controller.oldpassController),
              10.heightBox,
              customTextField(
                  hint: passwordHint,
                  title: newpass,
                  isPass: true,
                  controller: controller.newpassController),

              20.heightBox,

              controller.isloading.value
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    )
                  : SizedBox(
                      width: context.width - 60,
                      child: ourButton(
                          color: redColor,
                          title: "save",
                          textColor: whiteColor,
                           onPress: () async {
                            controller.isloading(true);

                            //if image is not selected
                            if(controller.profileImgPath.value.isNotEmpty){
                              await controller.uploadProfileImage();
                            }else{
                             controller.profileImageLink = data['imageUrl'];
                            }

                            //if old password matches database
                            if(data['password'] == controller.oldpassController.text){
                              await controller.changeAuthPassword(
                                email: data['email'],
                                password: controller.oldpassController.text,
                                  newPassword: controller.newpassController.text);

                              await controller.updateProfile(
                                imgUrl: controller.profileImageLink,
                                name: controller.nameController.text,
                                password: controller.newpassController.text);
                              controller.isloading(false);
                              VxToast.show(context, msg: "Profile Updated");
                            }
                            else{
                              VxToast.show(context, msg: "Wrong old password");
                              controller.isloading(false);
                            }

                           }
                           ),
                    ),
            ],
          )
              .box
              .white
              .shadowSm
              .p16
              .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
              .roundedSM
              .make(),
        ),
      ),
    );
  }
}
