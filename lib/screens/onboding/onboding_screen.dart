import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/entry_point.dart';

import 'components/animated_btn.dart';
import 'components/custom_sign_in_dialog.dart';
import 'components/sign_in_form.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  bool isSignInDialogShown = false;  // this boolean is used for adding animation
  //  This variable is used to control a 'Rive animation' on 'Start the course' button here. It's declared with the late keyword, indicating that it will be assigned a value later, after its initialization in the initState() method.
  late RiveAnimationController _btnAnimationController;

  @override
  void initState() {
    //  In the initState method, the _btnAnimationController is initialized with a Rive animation named "active" using the OneShotAnimation constructor.
    //  This animation controller will be used to control the playback of the animation.
    // The OneShotAnimation constructor is part of the Rive animation framework, which is a tool used for creating and playing animations in Flutter applications
    // The "active" animation likely represents a specific state or action that you want to animate when it occurs
    _btnAnimationController = OneShotAnimation(
        "active",
      // autoplay: false    // if 'autoplay' is set to false then on restart of application the animation will not play by default
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Positioned(        // This is an image we have placed in the background
            //height: 100,

            // Here, the retrieved screen width is multiplied by '1.7'. This means the width of the image will be 1.7 times the width of the screen.
            // This creates an image that is wider than the screen itself.
            // By setting the width of the 'Positioned' widget to 1.7 times the screen width, the image will be stretched horizontally, creating a visual effect of the image extending beyond the edges of the screen.
              width: MediaQuery.of(context).size.width * 1.7,
              // The image is positioned at the bottom of the screen, with a left offset of 100 pixels.
              bottom: 100,
              left: 100,
              child: Image.asset("assets/Backgrounds/Spline.png")
          ),

          // This 'Positioned.fill' widget uses the entire available space in the Stack to place a 'BackdropFilter'.
          // The 'BackdropFilter' widget applies a blur effect to its child.
          // The 'filter' parameter specifies the blur intensity using 'ImageFilter.blur(sigmaX: 20, sigmaY: 10)'
          Positioned.fill(   // this will create a blur effect filter on top of the image in stack
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: const SizedBox(),  // The child of the BackdropFilter is an empty SizedBox, which doesn't render any visible content but fulfills the requirement of having a child for the BackdropFilter
              )
          ),

           const RiveAnimation.asset("assets/RiveAssets/shapes.riv"),  // adding a 'Rive' animation to screen background. This is the animation for the moving objects in the background

          Positioned.fill(   // this will create a blur effect filter on top of the image in stack
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: const SizedBox(),  // The child of the BackdropFilter is an empty SizedBox, which doesn't render any visible content but fulfills the requirement of having a child for the BackdropFilter
              )
          ),

                                      // until this point we have constructed the Background
          /// ....................................................................................... ///

          // Lets add text
          AnimatedPositioned(
            // when we click the 'AnimatedBtn' so before the SignInDialog appears the text on 'onboding_screen' goes up thus to stop that from happening we place this code here.
           top: isSignInDialogShown ? -50 : 0, //  with this the Screen will not go up by almost 50 pixels on click of the 'AnimatedBtn' instead it will stay at its place
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            duration: const Duration(milliseconds: 260),
            child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Spacer(),   // This 'spacer' will bring the big title ' Learn design & code ' down by some pixels

                      const SizedBox(
                        width: 260,
                        child: Column(
                          children: [
                            Text(
                              "Learn design & code",
                              style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Poppins",
                                height: 1.2,
                                // fontWeight: FontWeight is already defined in Pubdev file along with the fonts
                              ),
                            ),

                            SizedBox(height: 16,),

                            Text(
                                "Don’t skip design. Learn design and code, by building real apps with Flutter and Swift. Complete courses about the best tools."
                            ),
                          ],
                        ),
                      ),

                      const Spacer(flex: 2,),

                      // Now we will add the a button with animation
                      // for that we have declared a 'RiveAnimationController'
                      AnimatedBtn(
                          btnAnimationController: _btnAnimationController,
                        press: () {// on tap of this 'AnimatedBtn' the animation will be shown now
                          // the line of code "_btnAnimationController.isActive = true;" is used to start playing the animation associated with the animation controller "_btnAnimationController".
                          //The "isActive" property of the animation controller is a boolean value that indicates whether the animation is currently active (playing) or not (paused or stopped).
                          // When isActive is set to true, it signifies that the animation associated with the controller should start playing.
                          _btnAnimationController.isActive = true;

                          Future.delayed(   // this delay is brought before opening the 'customSigninDialog' so that we can see the animation on both the 'AnimatedBtn' and 'showGeneralDialog'
                              const Duration(milliseconds: 800),
                              () {
                                setState(() {
                                  // alse we need to make it false once dialogue is closed
                                  isSignInDialogShown = true;
                                });
                                // I want to show the slide animation when the dialog shows
                                // "onClosed" of the 'CustomSignInDialog' is added here  because it is placed as a required argument in "Future<Object?> customSigninDialog(BuildContext context, {required ValueChanged onClosed})"
                                // ... secondly, '.then(closed)' at the end of 'showGeneralDialog' calls for 'onClosed' after the dismissal of the CustomSignInDialog
                                customSigninDialog(context, onClosed: (_) {
                                  setState(() {
                                    isSignInDialogShown = false;
                                  });
                                });
                              }
                          );

                        },
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Text(
                            "Purchase includes access to 30+ courses, 240+ premium tutorials, 120+ hours of videos, source files and certificates."
                        ),
                      ),

                    ],
                  ),
                )
            ),
          )

        ],
      ),
    );
  }


}

