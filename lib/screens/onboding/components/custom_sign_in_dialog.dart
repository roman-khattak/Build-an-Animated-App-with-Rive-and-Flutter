import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive_animation/screens/onboding/components/sign_in_form.dart';

Future<Object?> customSigninDialog(BuildContext context, {required ValueChanged onClosed}) {
  return showGeneralDialog(
    barrierDismissible: true,  // barrier can be dissmissed by clicking anywhere on the screen
    barrierLabel: "Sign In",
    barrierColor: Colors.black.withOpacity(0.5),
    context: context,
    transitionDuration: Duration(milliseconds: 400),  //The duration of the transition animation when the dialog is displayed or dismissed. In this case, it's set to 400 milliseconds.
    // this transitionBuilder I have added here to bring the slide animation to the 'showGeneralDialog'
    //  transitionBuilder: (context, animation, secondaryAnimation, child) is now modified below
    transitionBuilder: (_, animation, __, child) {   // This parameter is responsible for customizing the animation that occurs when the dialog is shown or dismissed. It takes a function that returns a widget (the dialog content) wrapped in a transition widget.
      Tween<Offset> tween;  // A Tween is defined to specify the range of animation values. In this case, it's an Offset tween that defines the animation range for the dialog's position.
      tween = Tween(begin: const Offset(0,-1), end: Offset.zero);  //The animation starts the dialog from above (0,-1, off the screen) and moves it to the final position (0,0, fully visible).
      // Offset(-1,0) will bring the showGeneralDialog from left to right and (0,-1) will bring it from top to bottom
      return SlideTransition( // This is a built-in widget that animates the position of its child using a specified animation. In this case, the SlideTransition is used to slide the dialog into view based on the animation values.
        position: tween.animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut)
        ),
        child: child,   // this child represents the content of the dialog that is being animated.
      );
    },

    // pageBuilder: (context, animation, secondaryAnimation) => Container(); we ignore some arguments
    pageBuilder: (context, _, __) => Center( // This center widget will bring the Popup to the center
      child: Container(   // This will build a new Page for us as a dialogue
        height: 620,
        margin: EdgeInsets.symmetric(horizontal: 16),
        padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.all(Radius.circular(40)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(0, 30),
              blurRadius: 60,
            ),
            const BoxShadow(
              color: Colors.black45,
              offset: Offset(0, 30),
              blurRadius: 60,
            ),
          ],
        ),

        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              // The Stack widget is used to layer its children on top of each other, and by default, it clips its children to its bounds to prevent overflow.
              // This means that if any child of the Stack exceeds the bounds of the Stack, it will be clipped and won't be visible.
              // Now the Position of the circle avatar at the bottom is set to -48 which means it exceeds the bounds of Stack and until we make the clipBehaviour to Clip.none it will not show the circle avatar.
              clipBehavior: Clip.none,
              children: [
                Column(
                  children: [
                    const Text("Sign In", style: TextStyle(
                        fontSize: 34,
                        fontFamily: "Poppins",
                      fontWeight: FontWeight.w600
                    ),
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16,),
                      child: Text(
                        "Access to 240+ hours of content. Learn design and code, by building real apps with Flutter and Swift.",
                        textAlign: TextAlign.center,
                      ),
                    ),

                    // In this SignInForm we will create the textform fiels to receive the username and password
                    SignInForm(),

                    const Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            "OR",
                            style: TextStyle(
                                color: Colors.black26,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        Expanded(child: Divider())
                      ],
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.0),
                      child: Text("Sign up with Email, Apple or Google",style: TextStyle(color: Colors.black54),),
                    ),

                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            icon: SvgPicture.asset("assets/icons/email_box.svg", height: 64, width: 64,),
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            icon: SvgPicture.asset("assets/icons/apple_box.svg", height: 64, width: 64,),
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            icon: SvgPicture.asset("assets/icons/google_box.svg", height: 64, width: 64,),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),

                const Positioned(
                  left: 0,
                  right: 0,   // for this to work and cross to show  we naeed to make the ClipBehaviour of Stack to none
                  bottom: -48,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                )

              ],
            )
        ),
      ),
    ),
  ).then(onClosed);  // we have also added "{ValueChanged onClosed}" into " Future<Object?> customSigninDialog(BuildContext context) {}" for the "then" to work properly

}