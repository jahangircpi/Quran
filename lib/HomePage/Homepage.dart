import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quran/Controller/qurancontroller.dart';
import 'package:quran/DetailsPage/detailspage.dart';
import 'package:quran/Service/servicequran.dart';

class homepage extends StatelessWidget {
  var quranct = Get.put(qurancontroller());

  var extrem = ApiQuran();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: WillPopScope(
        onWillPop: () {
          return Get.dialog(AlertDialog(
            title: Text("Alert!"),
            content: Text("Do you want to exit?"),
            actions: [
              FlatButton(
                child: Text("YES"),
                onPressed: () {
                  SystemNavigator.pop();
                },
              ),
              FlatButton(
                child: Text("NO"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
        },
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("Al-Quran"),
            ),
            body: Container(
              child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      quranct.onlylist.value = quranct.searchlist
                          .where((e) => e.englishName
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    },
                    // controller: editingController,
                    decoration: InputDecoration(
                        labelText: "Search",
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                  ),
                ),
                Expanded(
                  child: Obx(() {
                    try {
                      return ListView.builder(
                        itemCount: quranct.onlylist.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Get.dialog(Dialog(
                                  child: Container(
                                    height: 400,
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  ),
                                ));

                                extrem
                                    .fetchdata2(
                                        quranct.onlylist.value[index].number)
                                    .then((value) {
                                  quranct.arabiclists.value = value;

                                  extrem
                                      .fetchdata3(
                                          quranct.onlylist.value[index].number)
                                      .then((value) {
                                    quranct.banglalists.value = value;

                                    extrem
                                        .fetchdata4(quranct
                                            .onlylist.value[index].number)
                                        .then((value) {
                                      quranct.englishlists.value = value;

                                      Get.back();
                                      Get.to(detailspage());
                                    });
                                  });
                                });
                              },
                              child: Container(
                                  color: Colors.cyan.withOpacity(0.79),
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Center(
                                      child: Text(
                                        quranct
                                            .onlylist.value[index].englishName,
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
            )),
      ),
    );
  }
}
