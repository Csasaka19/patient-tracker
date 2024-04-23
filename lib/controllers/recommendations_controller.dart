import 'package:get/get.dart';

class RecommendationController extends GetxController {
  var recommendations = [].obs;

  updateRecommendations(list) {
    this.recommendations.value = list;
  }
}
