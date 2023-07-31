import 'package:flutter/material.dart';
import 'package:texno_bozor/ui/tab_user//profile/profile_screen.dart';
import 'package:texno_bozor/ui/tab_user/category/category_user_screen.dart';
import 'package:texno_bozor/ui/tab_user/product/product_user_screen.dart';


class TabUserProvider with ChangeNotifier {

  TabUserProvider()  {
    getWidgets();
  }

  int currentIndex = 0;
  List<Widget> screens = [];
  Widget? widget;

  void getWidgets(){
    screens.add(const CategoryUserScreen());
    screens.add(const ProductsUserScreen());
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
