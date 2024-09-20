import 'package:cross_local_storage/cross_local_storage.dart';
import 'package:get/get.dart';
import 'package:memory_lane_challange/config/config.dart';
import 'package:uuid/uuid.dart';

Future<void> setupLocator() async {
  Uuid uuid = const Uuid();

  LocalStorageInterface localStorage = await LocalStorage.getInstance();

  var savedDeviceId = localStorage.getString("DEVICE_ID");

  savedDeviceId ??= uuid.v4();

  localStorage.setString("DEVICE_ID", savedDeviceId);

  Config config = Config();
  config.setDeviceId(savedDeviceId);

  Get.put(config);
}
