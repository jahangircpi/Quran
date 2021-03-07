import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/Controller/qurancontroller.dart';
import 'package:audioplayers/audioplayers.dart';

class detailspage extends StatelessWidget {
  var quranct = Get.put(qurancontroller());
  AudioPlayer audioPlayer = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: Obx(
            () => Slider(
                min: quranct.min.value,
                max: quranct.max.value,
                value: quranct.value.value,
                onChanged: (e) {
                  quranct.value.value = e;
                }),
          )),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scrollbar(
          child: ListView.builder(
            itemCount: quranct.arabiclists.value.data.ayahs.length,
            itemBuilder: (BuildContext context, int index) {
              return Obx(() => Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            audioPlayer.play(quranct.arabiclists.value.data
                                .ayahs[index].audioSecondary[1]);
                          },
                          child: Text(
                            quranct.arabiclists.value.data.ayahs[index].text,
                            style: TextStyle(fontSize: quranct.value.value),
                          ),
                        ),
                      ),
                      Text(
                        quranct.banglalists.value.data.ayahs[index].text,
                        style: TextStyle(fontSize: quranct.value.value),
                      ),
                      Text(
                        quranct.englishlists.value.data.ayahs[index].text,
                        style: TextStyle(fontSize: quranct.value.value),
                      )
                    ],
                  ));
            },
          ),
        ),
      )),
    );
  }
}
