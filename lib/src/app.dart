import 'package:file_share_app/src/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'configs/config.dart';
import 'features/download/download.dart';
import 'router/router.dart';
import 'theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final materialTheme = MaterialTheme(textTheme: defaultTextTheme);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: GetMaterialApp(
        title: 'Shared File',
        theme: materialTheme.light(),
        darkTheme: materialTheme.dark(),
        themeMode: ThemeMode.system,
        locale: Get.locale ?? AppConfig.defaultLocale,
        supportedLocales: AppConfig.supportedLocales,
        getPages: AppRouter.routes,
        initialRoute: AppRouter.routes.first.name,
        debugShowCheckedModeBanner: false,
        initialBinding: BindingsBuilder(() {
          Get.put(AppController(), permanent: true);
          Get.put(
            DownloadViewModel(),
            permanent: true,
          );
        }),
      ),
    );
  }
}
