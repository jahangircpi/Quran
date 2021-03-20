import 'package:get/get.dart';
import 'package:quran/Model/arabicmodel.dart';
import 'package:quran/Model/banglamodel.dart';
import 'package:quran/Model/englishmodel.dart';
import 'package:quran/Model/modelforsurah.dart';
import 'package:quran/Service/servicequran.dart';

class qurancontroller extends GetxController {
  Rx<QuranModel> surahlists = QuranModel().obs;
  Rx<ArabicModel> arabiclists = ArabicModel().obs;
  Rx<BanglaQuran> banglalists = BanglaQuran().obs;
  Rx<EngModel> englishlists = EngModel().obs;

  var searchlist = List<Datum>().obs;
  var onlylist = List<Datum>().obs;

  var min = 10.0.obs;
  var max = 100.0.obs;
  var value = 20.0.obs;

  addmethod() {
    if (value.value + 10 < 100) {
      value + 10;
    }
  }

  minusmehtod() {
    if (value.value - 10 > 10) {
      value - 10;
    }
  }

  var apicalled = ApiQuran();
  @override
  void onInit() {
    apicalled.fetchdata().then((value) {
      surahlists.value = value;
      onlylist.value = surahlists.value.data;
      searchlist.value = surahlists.value.data;
    });

    super.onInit();
  }
}
