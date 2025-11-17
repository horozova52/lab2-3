import 'package:get/get.dart';
import '../data/v3.dart';

class ProductController extends GetxController {
//variabile reactive
  var sections = [].obs;
  var header = {}.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    header.value = eccomerceJson["header"] as Map<String, dynamic>;

    sections.value = (eccomerceJson["sections"] as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();
  }
}
