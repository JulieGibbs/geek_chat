import 'dart:io';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geek_chat/controller/settings.dart';
import 'package:geek_chat/i18n/translations.dart';
import 'package:geek_chat/pages/unkown_page.dart';
import 'package:geek_chat/repository/localstore_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:window_manager/window_manager.dart';
import 'package:geek_chat/routers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      size: Size(1280, 900),
      center: true,
      windowButtonVisibility: false,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  // print("system locale: ${Get.deviceLocale}");
  await GetStorage.init();
  await initServices();
  runApp(const GeekerChat());
}

initServices() async {
  // TODO zh_Hans_CN, en_US
}

class GeekerChat extends StatelessWidget {
  const GeekerChat({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LocalStoreRepository());
    Get.put(SettingsController());

    return GetMaterialApp(
      initialRoute: '/mobile',
      getPages: routers,
      unknownRoute: GetPage(
        name: '/404',
        page: () => const UnkownRoutePage(),
      ),
      theme: FlexThemeData.light(
        scheme: FlexScheme.materialBaseline,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 7,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 10,
          blendOnColors: false,
          useTextTheme: true,
          useM2StyleDividerInM3: true,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.materialBaseline,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 13,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
          useTextTheme: true,
          useM2StyleDividerInM3: true,
        ),
      ),
      themeMode: SettingsController.to.settings.theme,
      locale: Locale(SettingsController.to.settings.language),
      translations: GeekChatTranslations(),
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
    );
  }
}
