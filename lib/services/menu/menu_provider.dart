import 'package:flutter/cupertino.dart';

class MenuProvider with ChangeNotifier{


  int currentMenuIndex = 0;
  PageController pageController = PageController();



  void swipe(int index){
    currentMenuIndex = index;
    notifyListeners();
  }

  void bottomBarTab(int index){
    currentMenuIndex = index;
    pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    notifyListeners();
  }
}