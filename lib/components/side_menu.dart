import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/components/side_menu_tile.dart';

import '../models/rive_asset.dart';
import '../utils/rive_utils.dart';
import 'info_card.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

// This line initializes a variable named selectedMenu with the first item from the sideMenuIconsList.
// This variable is used to keep track of the currently selected "menu" item so that we can highlight the selected "menu".
// It is defined outside the State class and is global within the file.
// This 'selectedMenu' variable is declared so that we can highlight and unhighlight the items in side bar on click
RiveAsset selectedMenu = sideMenuIconsList.first;   // When the sideBar is opened so by default the 1st item will be selected this is done so that we can highlight the first Item by default

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: Color(0xFF17203A),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const InfoCard(name: "Rive Animation App", profession: "Animated Effects & Icons",),

              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  "Browse".toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(
                      color: Colors.white70
                  ),
                ),
              ),

              // Here the icons used are "Rive asset" because it's "animated" asset
              ...sideMenuIconsList.map(
                      (menuObj) => SideMenuTile(  // we are passing each object inside the "List<RiveAsset> sideMenuIconsList" index-wise to every 'SideMenuTile()' that is being created by map funtion corresponding the respective object from the list to display its data
                        menuObj: menuObj,
                        riveOnInit: (Artboard artboard) {
                          /// It is an animated button, and we will apply the animation to it here through 'onInit'
                          StateMachineController controller = RiveUtils.getRiveController(artboard, stateMachineName: menuObj.stateMachineName);

                          menuObj.input = controller.findSMI("active") as SMIBool;
                        },
                        press: () {
                          menuObj.input!.change(true);  // on click the icons will start animating
                          Future.delayed(Duration(seconds: 1), () {
                            menuObj.input!.change(false);     // after a delay of one second the animation stops
                          });

                          //  This line "selectedMenu = menuObj;" updates the selectedMenu variable with the currently clicked menuObj.
                          //  This will trigger a rebuild of the widget, and the isActive property of the SideMenuTile will be affected by this change.
                          setState(() {
                            // here the item which will be selected next by user in the side menu will be added to "selectedMenu" and thus now the new selected item will be highlighted
                          selectedMenu = menuObj;
                          });

                        },
                        //  The "isActive" property determines whether the SideMenuTile is visually marked as active (e.g., highlighted) based on whether the current menuObj matches the selectedMenu.
                        //  If the selectedMenu is the same as the menuObj, the tile will be marked as active, indicating that it's the currently selected menu item and thus it will be highlighted/Colored
                        isActive: selectedMenu == menuObj,

                      ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  "History".toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(
                      color: Colors.white70
                  ),
                ),
              ),

              // Here the icons used are "Rive asset" because it's "animated" asset
              ...sideMenuIconsList2.map(
                    (menuObj) => SideMenuTile(  // we are passing each object inside the "List<RiveAsset> sideMenuIconsList2" index-wise to every 'SideMenuTile()' that is being created by map function corresponding the respective object from the list to display its data
                  menuObj: menuObj,
                  riveOnInit: (Artboard artboard) {
                    /// It is an animated button, and we will apply the animation to it here through 'onInit'
                    StateMachineController controller = RiveUtils.getRiveController(artboard, stateMachineName: menuObj.stateMachineName);

                    menuObj.input = controller.findSMI("active") as SMIBool;
                  },
                  press: () {
                    menuObj.input!.change(true);  // on click the icons will start animating
                    Future.delayed(Duration(seconds: 1), () {
                      menuObj.input!.change(false);     // after a delay of one second the animation stops
                    });

                    //  This line "selectedMenu = menuObj;" updates the selectedMenu variable with the currently clicked menuObj.
                    //  This will trigger a rebuild of the widget, and the isActive property of the SideMenuTile will be affected by this change.
                    setState(() {
                      // here the item which will be selected next by user in the side menu will be added to "selectedMenu" and thus now the new selected item will be highlighted
                      selectedMenu = menuObj;
                    });

                  },
                  //  The "isActive" property determines whether the SideMenuTile is visually marked as active (e.g., highlighted) based on whether the current menuObj matches the selectedMenu.
                  //  If the selectedMenu is the same as the menuObj, the tile will be marked as active, indicating that it's the currently selected menu item and thus it will be highlighted/Colored
                  isActive: selectedMenu == menuObj,

                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}




