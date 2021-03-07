import 'package:http/http.dart' as http;
import 'package:quran/Model/arabicmodel.dart';
import 'package:quran/Model/banglamodel.dart';
import 'package:quran/Model/englishmodel.dart';
import 'package:quran/Model/modelforsurah.dart';

class ApiQuran {
  var link = "https://api.alquran.cloud/v1/surah";
  var link2 = "http://api.alquran.cloud/v1/surah/114/ar.alafasy";
  Future fetchdata() async {
    var response = await http.get(Uri.parse(link));
    if (response.statusCode == 200) {
      return quranModelFromJson(response.body);
    }
  }

  Future fetchdata2(number) async {
    var response = await http.get(
        Uri.parse("https://api.alquran.cloud/v1/surah/$number/ar.alafasy"));
    if (response.statusCode == 200) {
      return arabicModelFromJson(response.body);
    }
  }

  Future fetchdata3(number) async {
    var response = await http.get(
        Uri.parse("https://api.alquran.cloud/v1/surah/$number/bn.bengali"));
    if (response.statusCode == 200) {
      return banglaQuranFromJson(response.body);
    }
  }

  Future fetchdata4(number) async {
    var response = await http
        .get(Uri.parse("https://api.alquran.cloud/v1/surah/$number/en.asad"));
    if (response.statusCode == 200) {
      return engModelFromJson(response.body);
    }
  }
}
