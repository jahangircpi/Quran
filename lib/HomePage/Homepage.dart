import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/Controller/qurancontroller.dart';
import 'package:quran/DetailsPage/detailspage.dart';
import 'package:quran/Service/servicequran.dart';

class homepage extends StatelessWidget {
  var quranct = Get.put(qurancontroller());

  var extrem = ApiQuran();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {},
                // controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: Obx(() {
                try {
                  return ListView.builder(
                    itemCount: quranct.surahlists.value.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Get.dialog(Dialog(
                              child: Container(
                                height: 400,
                                child:
                                    Center(child: CircularProgressIndicator()),
                              ),
                            ));

                            extrem.fetchdata2(index + 1).then((value) {
                              quranct.arabiclists.value = value;

                              extrem.fetchdata3(index + 1).then((value) {
                                quranct.banglalists.value = value;

                                extrem.fetchdata4(index + 1).then((value) {
                                  quranct.englishlists.value = value;

                                  Get.back();
                                  Get.to(detailspage());
                                });

                                // });
                              });
                            });
                          },
                          child: Container(
                              color: Colors.cyan.withOpacity(0.79),
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Center(
                                  child: Text(
                                    quranct.surahlists.value.data[index]
                                        .englishName,
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.black,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              )),
                        ),
                      );
                    },
                  );
                } catch (e) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
            )
          ]),
        ));
  }
}
