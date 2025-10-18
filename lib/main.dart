import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/di/dependency_injection.dart';
import 'core/router/app_router.dart';
import 'core/theme/colors_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Setup dependency injection
  await setupDependencyInjection();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp.router(
        routerConfig: AppRouter.router,

        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: ColorsApp.white),
      ),
    );
  }
}
