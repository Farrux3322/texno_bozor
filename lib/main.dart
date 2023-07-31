import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/data/fairbase/auth_service.dart';
import 'package:texno_bozor/data/fairbase/category_service.dart';
import 'package:texno_bozor/data/fairbase/products_service.dart';
import 'package:texno_bozor/data/fairbase/profile_service.dart';
import 'package:texno_bozor/provider/auth_provider.dart';
import 'package:texno_bozor/provider/products_provider.dart';
import 'package:texno_bozor/provider/profiles_provider.dart';
import 'package:texno_bozor/provider/tab_admin_provider.dart';
import 'package:texno_bozor/provider/tab_user_provider.dart';
import 'package:texno_bozor/splash/splash_screen.dart';
import 'package:texno_bozor/utils/theme.dart';

import 'provider/category_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(firebaseServices: AuthService()),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (context) => TabAdminProvider(),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (context) =>
              ProfileProvider(profileService: ProfileService()),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (context) =>
              CategoryProvider(categoryService: CategoryService()),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (context) =>
              ProductsProvider(productsService: ProductsService()),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (context) =>
              TabUserProvider(),
          lazy: true,
        ),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: child,
          theme: AppTheme.darkTheme,
        );
      },
      child: const SplashScreen(),
    );
  }
}
