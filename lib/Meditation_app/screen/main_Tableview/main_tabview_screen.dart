import 'package:flutter/material.dart';
import 'package:flutter_project/Meditation_app/common/color_extension.dart';
import 'package:flutter_project/Meditation_app/common_widget/Tab_button.dart';
import 'package:flutter_project/Meditation_app/screen/home/home_screen.dart';
import 'package:flutter_project/Meditation_app/screen/meditate/Maditate_screen.dart';
import 'package:flutter_project/Meditation_app/screen/music/Music_Screen.dart';
import 'package:flutter_project/Meditation_app/screen/sleep/sleep_screen.dart';


class MainTabViewScreen extends StatefulWidget {
  const MainTabViewScreen({super.key});

  @override
  State<MainTabViewScreen> createState() => _MainTabViewScreenState();
}

class _MainTabViewScreenState extends State<MainTabViewScreen> with SingleTickerProviderStateMixin {

  TabController? controller;
  int selectTab = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 4, vsync: this);
    controller?.addListener(() {
      selectTab = controller?.index ?? 0;
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
          controller: controller,
          children: [
            const HomeScreen(),
            const SleepScreen(),
            const MeditateScreen(),
            const MusicScreen(),
            // Container( color: Colors.red, )
          ]),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 15, bottom: 8),
        decoration:  BoxDecoration(
            color: selectTab == 3 || selectTab == 1 ? TColor.sleep : Colors.white,
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, -4))
            ]
        ),
        child: SafeArea(child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            TabButton(icon: "assets/logo/meditation_logo/home_tab.png", title: "Home", isSelect: selectTab == 0, onPressed: (){
              changeTab(0);
            }),
            TabButton(
                icon: "assets/logo/meditation_logo/sleep_tab.png",
                title: "Sleep",
                isSelect: selectTab == 1,
                onPressed: () {
                  changeTab(1);
                }),

            TabButton(
                icon: "assets/logo/meditation_logo/meditate_tab.png",
                title: "Meditate",
                isSelect: selectTab == 2,
                onPressed: () {
                  changeTab(2);
                }),

            TabButton(
                icon: "assets/logo/meditation_logo/music_tab.png",
                title: "Music",
                isSelect: selectTab == 3,
                onPressed: () {
                  changeTab(3);
                }),

            // TabButton(
            //     icon: "assets/logo/meditation_logo/profile_tab.png",
            //     title: "buddy",
            //     isSelect: selectTab == 4,
            //     onPressed: () {
            //       changeTab(4);
            //     }),

          ],
        )),
      ) ,
    );


  }

  void changeTab(int index) {
    selectTab = index;
    controller?.animateTo(index);
    setState(() {});
  }
}