

class StringUtils {
  static String rupeesSymbol = String.fromCharCodes(new Runes('\u{20B9}'));


  static String formatDouble(double value) {
    String returedValue = "";
    if (value != null) {
      returedValue = value.toStringAsFixed(0);
    }
    return returedValue;
  }

  // static String formatDoubleWith2Decimal(double value) {
  //   String returedValue = "";
  //   if (value != null) {
  //     returedValue = value.toStringAsFixed(2);
  //   }
  //   return returedValue;
  // }

  static bool isString(String value) {
    return RegExp('[a-zA-Z]').hasMatch(value);
  }

  static double parseDoubleWith2Decimal(double value) {
    double returedValue = 0.0;
    if (value != null) {
      returedValue = double.parse(value.toStringAsFixed(2));
    }
    return returedValue;
  }

  static bool isEmpty(String? value) {
    if (value == null || value.trim() == "" || value == '' || value == 'null') {
      return true;
    }
    return false;
  }

  static bool isNotEmpty(String? value) {
    if (value != null && value.trim() != "" && value != '' && value != 'null') {
      return true;
    }
    return false;
  }

  static bool isNotNumEmpty(dynamic value) {
    if (value != null && value != '' && value != 'null') {
      return true;
    }
    return false;
  }

  static String toCapitalized(String value) {
    String capitalized = '';
    if (value.length > 0)
      capitalized =
          '${value[0].toUpperCase()}${value.substring(1).toLowerCase()}';
    return capitalized;
  }

  static String toTitleCase(String value) {
    return value.toLowerCase().replaceAllMapped(
        RegExp(
            r'[A-Z]{2,}(?=[A-Z][a-z]+[0-9]*|\b)|[A-Z]?[a-z]+[0-9]*|[A-Z]|[0-9]+'),
        (Match match) {
      return "${match[0]![0].toUpperCase()}${match[0]!.substring(1).toLowerCase()}";
    }).replaceAll(RegExp(r'(_|-)+'), ' ');
  }

  /* static bool isResourceProtected(String apiPath) {
    List<String> unprotectedList = [
      "/api/bs-authentication-service/auth/sendOtp",
    ];
    if (unprotectedList.contains(apiPath)) {
      return false;
    }
    return true;
  } */

  static String getInitials(String name) {
    final _whitespaceRE = RegExp(r"\s+");
    name = name.replaceAll(_whitespaceRE, " ");
    return name.isNotEmpty
        ? name.trim().split(' ').map((l) => l[0]).take(2).join()
        : '';
  }

  static bool equalsIgnoreCase(String string1, String string2) {
    return string1.toLowerCase() == string2.toLowerCase();
  }

  static bool containsIgnoreCase(String string1, String string2) {
    return string1.toLowerCase().contains(string2.toLowerCase());
  }
}
