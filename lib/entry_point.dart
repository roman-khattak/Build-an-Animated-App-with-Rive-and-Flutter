
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/components/side_menu.dart';
import 'package:rive_animation/constants.dart';
import 'package:rive_animation/screens/home/home_screen.dart';
import 'package:rive_animation/utils/rive_utils.dart';

import 'components/animated_bar.dart';
import 'models/menu_btn.dart';
import 'models/rive_asset.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> with SingleTickerProviderStateMixin{

  RiveAsset selectedBottomNav = bottomNavs.first;   // byDefault we assign the first item among the bottomNavBar items to 'selectedBottomNav' so that we can use it to make the opacity of selected item more than the other items

  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;

  late SMIBool isSideBarClosed;    // this boolean variable is declared here so that we can check whether the sideBar needs to be opened or closed.

  bool isSideMenuClosed = true;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
      duration: const Duration(milliseconds: 200)
    )..addListener(() {
      setState(() {});
    });

    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn),
    );

    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn),
    );


    super.initState();
  }


  @override
  void dispose() {
    super.dispose();

    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      resizeToAvoidBottomInset: false,   // 'resizeToAvoidBottomInset' is set to 'false', indicating that the widget tree won't automatically resize to avoid the keyboard when it appears.
      extendBody: true,           // 'extendBody' is set to 'true', indicating that the body's content can extend under other components of the Scaffold.
      body: Stack(
        children: [

        AnimatedPositioned( // for this SideMenu to appear we must wrap the HomeScreen with "Transform" widget so that the Home screen can push a side for the SideMenu to appear which is underneath the HomeScreen
            duration: Duration(milliseconds: 200),   // Duration of the Animation
            curve: Curves.fastOutSlowIn,            // Type of the animation
            width: 288,  // The width we give the sideBar
            left: isSideMenuClosed ? -288 : 0,  // if the 'SideMenu' is closed then the Items in the SideMenu will disappear in to the left edge of the screen and reappear when the 'SideMenu' is opened.
              height: MediaQuery.of(context).size.height, // Full screen height
              child: SideMenu()
          ),

          Transform(
            alignment: Alignment.center,
            // we are rotating the HomeScreen by 30 degree  in 3D
            transform: Matrix4.identity()..setEntry(3, 2, 0.001)..rotateY(animation.value - 30 * animation.value * pi / 180),
            child: Transform.translate(   // The outer Transform.translate widget is used to apply a translation (movement) transformation to its child.
              // "dx" is set to "isSideMenuClosed ? 0 : 288", which is either "0 or 288" depending on the isSideMenuClosed condition.
              // "dy" is explicitly set to 0.
               /// offset: Offset(isSideMenuClosed ? 0 : 288 , 0),  // The offset property specifies how much the 'child' widget should be translated (moved) horizontally and vertically. In this case, it's Offset(288, 0), which means the child will be moved 288 pixels to the right (horizontally) and 0 pixels vertically. So, it will be shifted to the right by 288 pixels.
                offset: Offset(animation.value * 265 , 0),  // The offset property specifies how much the 'child' widget should be translated (moved) horizontally and vertically. In this case, it's Offset(288, 0), which means the child will be moved 288 pixels to the right (horizontally) and 0 pixels vertically. So, it will be shifted to the right by 288 pixels.
                child: Transform.scale(
                  // Scaling, in this context, refers to changing the size of the child widget, making it either larger or smaller.
                  // A "scale" value less than 1 makes the child widget smaller. For example, a  "scale" of 0.5 would reduce the size of the child widget to half of its original dimensions.
                  //
                  // A "scale" value greater than 1 makes the child widget larger. For example, a "scale" of 2 would double the size of the child widget.
                  //
                  // A "scale" value of 1 means no scaling; the child widget remains at its original size.
                  /// scale: isSideMenuClosed ? 1 : 0.8, // if 'SideMenuBar' is closed then its scaling will be 1 which menas no scale and if opened so scaling will be 0.8 means size reduces
                    scale: scaleAnimation.value, // if 'SideMenuBar' is closed then its scaling will be 1 which menas no scale and if opened so scaling will be 0.8 means size reduces
                    child: const ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                        child: HomeScreen()
                    )
                )
            ),
          ),

          AnimatedPositioned(
            duration: Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            left: isSideMenuClosed ? 0 : 220,   // moving Menu button to right on the opening of SideMenuBar
            top: 16,
            child: MenuBtn(
              riveOnInit: (Artboard artboard) {
                StateMachineController controller = RiveUtils.getRiveController(
                  artboard,
                  stateMachineName: "State Machine"
                );
                isSideBarClosed = controller.findSMI("isOpen") as SMIBool;
                isSideBarClosed.value = true;
              },

              press: () {
                // When the "MenuBtn" is tapped, this code snippet toggles the state of isSideBarClosed, effectively opening or closing the side menu, and then updates the isSideMenuClosed variable accordingly.
                // This update triggers a widget rebuild through setState, ensuring that the UI reflects the new state of the sidebar menu, allowing it to open or close as intended.
                isSideBarClosed.value = !isSideBarClosed.value;   // this line of code means, on tap of SideBarButton i.e; 'MenuBtn' if the sideMenu is open so close it and vice versa

                if (isSideMenuClosed) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }

                setState(() {
                  isSideMenuClosed = isSideBarClosed.value; // here we assign the updated value of 'isSideBarClosed' whether true or false and assign to 'isSideMenuClosed' so that we can further use 'isSideMenuClosed' to update the UI and open or close the 'SideBar'
                });
              },

            ),
          )
        ],
      ),

      bottomNavigationBar: Transform.translate(
        offset: Offset(0, 100 * animation.value),   // This will hide the BottomNavigationBar on the opening of SideMenuBar
        child: SafeArea(   // The icons used in this bottomNavigationBar are Rive Icons not normal icons which can be found in 'Rive community' in 'rive.app'
          child: Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: backgroundColor2.withOpacity(0.8),
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                // Spread Operator (...): The spread operator '...' is used before 'List.generate' to expand the list of generated 'GestureDetector' widgets directly into the parent widget, which is a Row in this case.
                //
                // In other words, the spread operator is used to avoid having to manually extract and add each generated GestureDetector widget to the children list of the Row.
                // Instead, it efficiently adds each generated widget directly as a child of the Row, making the code cleaner and more concise.

                ...List.generate(
                    bottomNavs.length,
                        (index) => GestureDetector(
                          onTap: () {
                           // this " searchTrigger.change(true);" become like below line after we have created the model class for all the rive icons
                           bottomNavs[index].input!.change(true);   // This line here will start the animation on the bottomNavBar items on click

                           // here we are making sure that if we click on any item from 'bottomNavBar' and it is not the First Item which we have already assigned to 'selectedBottomNav' by default
                           // ... then we will update the 'selectedBottomNav' with the current index that is clicked so that we can change its Opacity when any item is clicked from 'bottomNavs'
                           if (bottomNavs[index] != selectedBottomNav) {
                             setState(() {
                               selectedBottomNav = bottomNavs[index];
                             });
                           }

                           Future.delayed(const Duration(seconds: 1), () {
                             bottomNavs[index].input!.change(false);   // This line here will stop the animation on the bottomNavBar items after a delay of 1 second
                           });
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              AnimatedBar(
                                  isActive: bottomNavs[index] == selectedBottomNav  // 'isActive' will be true if the 'selectedBottomNav' is equal to the current index we are on
                              ),

                              SizedBox(
                                  height: 36,
                                  width: 36,
                                  // In this file all the animated Icons are available but we have to extract each from it using that icon's name
                                  child: Opacity(
                                    // bottomNavs[index]: This is referring to a specific item in the "bottomNavs" list, which seems to contain information about different navigation items, including their animation assets.
                                    //
                                    // selectedBottomNav: This is the currently selected navigation item, as tracked by the application's state.
                                    //
                                    // If the bottomNavs[index] (the current navigation item) is the same as the selectedBottomNav (the currently selected item), then set the opacity to 1 (fully visible).
                                    //
                                    // If the bottomNavs[index] is not the same as the selectedBottomNav, then set the opacity to 0.5 (half-visible, or somewhat faded).
                                    opacity: bottomNavs[index] == selectedBottomNav ? 1 : 0.5,
                                    child: RiveAnimation.asset(
                                      // 'src' the "source" and is same for all
                                      // The line bottomNavs.first.src is referring to the source path of the Rive animation asset for the first item in the bottomNavs list.
                                      bottomNavs.first.src,  // src: The source path of the Rive animation. It seems to be the same for all navigation items as it's taken from "bottomNavs.first.src"
                                      artboard: bottomNavs[index].artboard,     // This here will display the Icons index-wise    // artboard: This parameter specifies the artboard associated with the current navigation item. The artboard represents a specific piece of the animation, in this case, an animated icon. It's obtained from bottomNavs[index].artboard, where index is the index of the current navigation item.
                                      onInit: (artboard) {   // This callback is invoked when the Rive animation is initialized. Inside this callback, you're configuring the animation and its controller.
                                        StateMachineController controller = RiveUtils.getRiveController(
                                            artboard,
                                            stateMachineName: bottomNavs[index].stateMachineName    // This is the 'stateMachine Name' for the 'SEARCH' icon in Rive
                                        );

                                      // Previously " searchTrigger = controller.findSMI('active') as SMIBool;" now becomes like below line after we have created a model for the items
                                        bottomNavs[index].input = controller.findSMI('active') as SMIBool;  // This line sets the input property of the current navigation item (bottomNavs[index]) with the active state of the animation as a boolean state machine input (SMIBool). This effectively associates the animation's active state with this input property, allowing you to control the animation's state by changing the value of this input.

                                      },
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}



