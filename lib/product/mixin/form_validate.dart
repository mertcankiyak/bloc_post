import 'package:bloc_post/product/constants/string_constants.dart';
import 'package:bloc_post/product/extensions/string_extensions.dart';

mixin FormValidate {
  String? emailValidation(String? mail) {
    if (mail != null && mail.isNotEmpty) {
      if (mail.emailValid()) {
        return null;
      } else {
        return gecersizEmailText;
      }
    } else {
      return emailBosGecilemez;
    }
  }

  String? passwordControl(String? value) {
    if (value != null && value.length > 5) {
      return null;
    } else {
      return sifreKarakterUyarisi;
    }
  }
}
