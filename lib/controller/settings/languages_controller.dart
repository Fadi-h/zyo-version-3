import 'package:get/get.dart';

class LanguagesController extends GetxController {

  var select_value = 0.obs;
  String? value = "non";

  List languages = [
    {
      "name":"English",
      "id":"en"
    },
    {
      "name":"العربية",
      "id":"ar"
    },
    {
      "name":"русский",
      "id":"ru"
    },
    {
      "name":"हिन्दी",
      "id":"hi"
    },
    {
      "name":"Türkçe",
      "id":"tr"
    }
   ].obs;

}