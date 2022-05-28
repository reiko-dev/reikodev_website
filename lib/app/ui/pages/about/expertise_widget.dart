import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reikodev_website/app/controller/expertises_controller.dart';
import 'package:reikodev_website/app/ui/pages/about/expertise_panel.dart';

class ExpertiseWidget extends StatelessWidget {
  const ExpertiseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Obx(() {
      final expertises = ExpertisesController.i.expertises;
      final keys = expertises.keys.toList();

      return ExpertisesController.i.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: keys.length,
              shrinkWrap: true,
              itemBuilder: (c, i) {
                return Padding(
                  padding: EdgeInsets.only(bottom: size.height * .15),
                  child: ExpertisePanelItem(
                    title: keys[i].name,
                    habilities: expertises[keys[i]]!,
                  ),
                );
              },
            );
    });
  }
}
