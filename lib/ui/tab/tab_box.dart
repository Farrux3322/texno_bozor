import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/provider/tab_provider.dart';

class TabBox extends StatefulWidget {
  const TabBox({super.key});

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TabProvider>(context,listen: true);
    return Scaffold(
      body: provider.widget,
      bottomNavigationBar: SizedBox(
        height: 110,
        child: BottomNavigationBar(
          backgroundColor: Colors.black,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: const Color(0xFF9B9B9B),
          selectedItemColor: const Color(0xFFDB3022),
          onTap: (onTab){
            provider.getScreen(onTab);
          },
          currentIndex: provider.currentIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home, size: 30), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart, size: 30), label: "Shop"),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_bag, size: 30), label: "Bag"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite_border_outlined, size: 30), label: "Favorites"),
            BottomNavigationBarItem(icon: Icon(Icons.person, size: 30), label: "Profile"),
          ],
        ),
      ),
    );
  }
}