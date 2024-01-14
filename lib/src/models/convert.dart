import 'dart:core';

class Converter {
  static String urlToId(String url) {
    String result = "";
    Iterable<RegExpMatch> matches = RegExp(r"[0-9]")
        .allMatches(RegExp(r"\/-?[0-9]+\/$").stringMatch(url)!);
    for (Match m in matches) {
      result += m.group(0)!;
    }
    return result;
  }

  static String urlToCat(String url) {
    String result = "";
    Iterable<RegExpMatch> matches = RegExp(r"[a-z\-]")
        .allMatches(RegExp(r"\/[a-z\-]+\/-?[0-9]+\/$").stringMatch(url)!);
    for (Match m in matches) {
      result += m.group(0)!;
    }
    return result;
  }
}
