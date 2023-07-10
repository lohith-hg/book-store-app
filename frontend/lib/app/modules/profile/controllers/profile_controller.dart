import 'package:book_store_app/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../../../service/auth_service.dart';

class ProfileController extends GetxController {
  AuthService authService = Get.find();
  HomeController homeController = Get.find();

  get editMode => null;

  @override
  void onInit() async{
    await homeController.getUserDetails();
    super.onInit();
  }

}
