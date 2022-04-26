import 'package:bloc_post/product/enums/service_enums.dart';

extension ServiceExtensions on ServiceEnum {
  String rawValue() {
    switch (this) {
      case ServiceEnum.BASEURL:
        return "https://reqres.in";
      case ServiceEnum.LOGINPATH:
        return "/api/login";
    }
  }
}
