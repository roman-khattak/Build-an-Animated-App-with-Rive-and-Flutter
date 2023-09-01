import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../models/rive_asset.dart';


// These are the Icons in the "Side Menu / Drawer"
class SideMenuTile extends StatelessWidget {
  const SideMenuTile({
    super.key,
    required this.menuObj,
    required this.press,
    required this.riveOnInit,
    required this.isActive,
  });

  final RiveAsset menuObj;   // These are the indiviual objects inside "List<RiveAsset> sideMenuIconsList" which are being passed here for every 'SideMenuTile()' that is being created by map funtion corresponding the respective object from the list to display its data
  final VoidCallback press;
  final ValueChanged<Artboard> riveOnInit;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24),
          child: Divider(
            color: Colors.white24,
            height: 1,
          ),
        ),

        Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,              // 'curves' are the animations we apply on the widgets
              height: 56,
              width: isActive ? 288 : 0, // if an icon is clicked then the following animated container will change color and appear over it for 300 milliseconds giving a good look
              left: 0,
              child: Container(   // this container will highlight the selected ListTile item based on the value stored in "selectedMenu"
                decoration: const BoxDecoration(
                  color: Color(0xFF6792FF),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              ),
            ),

            ListTile(
              onTap: press,
              leading: SizedBox(
                height: 34,
                width: 34,
                child: RiveAnimation.asset(
                  menuObj.src,  // this is the source file for all the icons
                  artboard: menuObj.artboard,
                  // onInit: (artboard){
                  //       /// It is an animated button, and we will apply the animation to it here through 'onInit'
                  // },

                  /// It is an animated button, and we will apply the animation to it here through 'onInit'
                  onInit: riveOnInit,
                ),
              ),

              title: Text(menuObj.title, style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ],
    );
  }
}