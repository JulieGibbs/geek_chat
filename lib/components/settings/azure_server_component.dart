import 'package:flutter/material.dart';
import 'package:geek_chat/controller/settings.dart';
import 'package:geek_chat/controller/settings_server_controller.dart';
import 'package:geek_chat/util/functions.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

// ignore: must_be_immutable
class AzureServerSettingsComponent extends StatelessWidget {
  AzureServerSettingsComponent({super.key});

  SettingsController settingsController = Get.find();
  SettingsServerController settingsServerController = Get.find();
  Logger logger = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsServerController>(builder: (controller) {
      return Wrap(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          ListTile(
            title: Text("Server Configuration".tr),
          ),
          // Padding(padding: paddingOnly())
          // Padding(
          //   padding:
          //       const EdgeInsets.only(left: 20, top: 0, bottom: 0, right: 10),
          //   child: TextFormField(
          //     initialValue: controller.defaultServer.apiHost,
          //     decoration: const InputDecoration(
          //       labelText: 'API Host',
          //       filled: false,
          //       // errorText: 'Error!',
          //       // border: OutlineInputBorder(),
          //     ),
          //     onChanged: (value) {
          //       controller.defaultServer.apiHost = value.trim();
          //     },
          //   ),
          // ),
          /*
          Padding(
            padding:
                const EdgeInsets.only(left: 20, top: 20, bottom: 10, right: 10),
            child: TextFormField(
              initialValue: controller.defaultServer.apiKey,
              decoration: const InputDecoration(
                labelText: 'API Key',
                filled: false,
              ),
              onChanged: (value) {
                controller.defaultServer.apiKey = value.trim();
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, top: 20, bottom: 10, right: 10),
            child: TextFormField(
              initialValue: controller.defaultServer.azureApiVersion,
              decoration: const InputDecoration(
                labelText: 'API Version',
                filled: false,
              ),
              onChanged: (value) {
                controller.defaultServer.azureApiVersion = value.trim();
              },
            ),
          ),*/
          Padding(
            padding:
                const EdgeInsets.only(left: 15, top: 20, bottom: 10, right: 10),
            child: SizedBox(
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, right: 10, left: 10),
                  child: Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text("Deploymentid: "),
                      Text("Model name deployed on Azure".tr)
                    ],
                  ),
                ),
              ),
            ),
          ),
          for (var modelName in controller.defaultServer.azureConfig.keys)
            Column(
              children: [
                ListTile(
                  title: Text(modelName),
                  dense: true,
                ),
                for (var ckey
                    in controller.defaultServer.azureConfig[modelName]!.keys)
                  if (ckey != "name")
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, top: 10, bottom: 10, right: 10),
                      child: TextFormField(
                        initialValue: controller
                            .defaultServer.azureConfig[modelName]![ckey],
                        decoration: InputDecoration(
                          labelText: ckey.capitalizeFirst,
                          filled: false,
                        ),
                        onChanged: (value) {
                          logger.d("on change: $value");
                          controller.defaultServer
                              .azureConfig[modelName]![ckey] = value.trim();
                        },
                      ),
                    ),
              ],
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    controller.defaultServer.isActived = false;
                    controller.saveSettings(controller.defaultServer);
                    settingsController.settings.provider =
                        controller.defaultServer.provider;
                    settingsController.saveSettings();
                    showCustomToast(
                        title: "Saved successfully!".tr, context: context);
                    // controller.needReactive = true;
                    // controller.saveSettings();
                    // Get.snackbar(
                    //   "Saved successfully!".tr,
                    //   "The configuration has been updated!".tr,
                    //   icon: const Icon(
                    //     Icons.check,
                    //     color: Colors.green,
                    //   ),
                    //   snackPosition: SnackPosition.TOP,
                    // );
                  },
                  child: Text('Save'.tr),
                ),
                const SizedBox(
                  width: 30,
                ),
                OutlinedButton(
                  onPressed: () {
                    // controller.resetSettings();
                    Get.back();
                  },
                  child: Text('Cancel'.tr),
                )
              ],
            ),
          )
        ],
      );
    });
  }
}
