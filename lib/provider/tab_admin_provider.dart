import 'package:flutter/material.dart';
import 'package:texno_bozor/ui/tab_admin/category/category_admin_screen.dart';
import 'package:texno_bozor/ui/tab_admin/product/product_admin_screen.dart';
import 'package:texno_bozor/ui/tab_user//profile/profile_screen.dart';


class TabAdminProvider with ChangeNotifier {

  TabAdminProvider()  {
    getWidgets();
  }

  int currentIndex = 0;
  List<Widget> screens = [];
  Widget? widget;

  void getWidgets(){
    screens.add(const CategoryAdminScreen());
    screens.add(const ProductsAdminScreen());
    screens.add(const ProfileUserScreen());
    widget = screens[0];
    notifyListeners();
  }

  getScreen(int index){
    widget =  screens[index];
    currentIndex = index;
    notifyListeners();
  }

}


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
