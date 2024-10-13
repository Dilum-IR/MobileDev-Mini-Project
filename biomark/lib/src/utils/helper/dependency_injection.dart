import 'package:get/get.dart';

import '../../app/controllers/network/network_connecion.dart';

class DependencyInjection {
  static void init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}
