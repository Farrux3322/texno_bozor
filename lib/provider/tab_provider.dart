import 'package:flutter/material.dart';
import 'package:texno_bozor/ui/tab/bag/bag_screen.dart';
import 'package:texno_bozor/ui/tab/favorite/favorite_screen.dart';
import 'package:texno_bozor/ui/tab/home/home_screen.dart';
import 'package:texno_bozor/ui/tab/profile/profile_screen.dart';
import 'package:texno_bozor/ui/tab/shop/shop_screen.dart';

class TabProvider with ChangeNotifier {

  TabProvider()  {
    getWidgets();
  }

  int currentIndex = 0;
  List<Widget> screens = [];
  Widget? widget;

  void getWidgets(){
    screens.add(const HomeScreen());
    screens.add(const ShopScreen());
    screens.add(const BagScreen());
    screens.add(const FavoriteScreen());
    screens.add(const ProfileScreen());
    widget = screens[0];
    notifyListeners();
  }

  getScreen(int index){
    widget =  screens[index];
    currentIndex = index;
    notifyListeners();
  }

}
