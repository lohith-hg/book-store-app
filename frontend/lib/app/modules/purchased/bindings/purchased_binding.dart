import 'package:get/get.dart';

import '../controllers/purchased_controller.dart';

class PurchasedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PurchasedController>(
      () => PurchasedController(),
    );
  }
}
