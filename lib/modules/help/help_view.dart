import 'package:flutter/material.dart';
import 'package:uplant/modules/help/singelhelp_view.dart';
import 'package:uplant/shared/bottom_nav_bar.dart';
import 'package:get/get.dart';
import 'package:uplant/shared/content_card.dart';

import 'add_help_view.dart';
import 'help_controller.dart';

class HelpView extends GetView<HelpController> {
  const HelpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'help',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: GetX<HelpController>(
              init: Get.put<HelpController>(HelpController()),
              builder: (HelpController helpsController) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: helpsController.helps.length,
                    itemBuilder: (BuildContext context, int index) {
                      final help = helpsController.helps[index];
                      return ContentCard(
                        onPressed: () {
                          Get.to(SingleHelpView(help: help));
                        },
                        title: help.title,
                        infoText: help.infoText,
                        imageURL: help.imageURL,
                      );
                    });
              })),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: 2,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(AddHelpView());
        },
        label: const Text('need help'),
        icon: const Icon(Icons.help),
      ),
    );
  }
}
