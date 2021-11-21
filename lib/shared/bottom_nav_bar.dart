import 'package:flutter/material.dart';
import 'package:uplant/modules/guides/guides_view.dart';
import 'package:uplant/modules/help/help_view.dart';
import 'package:uplant/modules/projects/projects_view.dart';
import 'package:get/get.dart';

class MyBottomNavigationBar extends StatefulWidget {
  int currentIndex = 0;
  MyBottomNavigationBar({Key? key, required this.currentIndex})
      : super(key: key);

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: (value) {
        setState(() {
          widget.currentIndex = value;
        });
        switch (value) {
          case 0:
            Get.off(() => GuidesView(), transition: Transition.noTransition);
            break;
          case 1:
            Get.off(() => const ProjectsView(),
                transition: Transition.noTransition);
            break;
          case 2:
            Get.off(() => const HelpView(),
                transition: Transition.noTransition);
            break;
          default:
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Guides',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_florist),
          label: 'Projects',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.supervisor_account),
          label: 'Help',
        ),
      ],
    );
  }
}
