import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/entry_point.dart';
import 'package:rive_animation/utils/rive_utils.dart';

/// for implementing the successful loading/failure Icon or animation, we have to first check for the validation of textFormField

class SignInForm extends StatefulWidget {
  const SignInForm({
    super.key,
  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();  // initializing the GlobalKey to use for validation in Form

  bool isShowLoading = false;
  // "SMITrigger" is another custom type provided by the Rive animation library. In Rive, "SMITrigger" likely represents a type of control mechanism that you can use within the animation's state machine.
  // Unlike "SMIBool", which represents boolean values, "SMITrigger" is probably used to trigger specific actions or transitions within the animation based on certain conditions.
  // In this code, we are using "SMITrigger" for the 'check', 'error', and 'reset' variables. These variables are used to control different trigger-based actions within the animation.
  // Triggers can be used to initiate state transitions or animations when certain conditions are met.
  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;

  late SMITrigger confetti; // this 'confetti' animation I want to show after the user successfully loggedIn
  bool isShowConfetti = false;   // this boolean helps us show and hide the confetti animation

  /// This method, getRiveController, retrieves a StateMachineController for controlling the animation's state machine
  /// Let's break down the code step by step:

  // The method takes an "Artboard" named "artboard" as a parameter. An "Artboard" is a part of a Rive animation containing graphical elements and animations.

  // The method then attempts to create a "StateMachineController" named "controller" using the "fromArtboard" method provided by the Rive library.

  // The "fromArtboard" method requires two parameters:

  // 1) The "artboard instance": This is the "Artboard" you want to control.
  // 2) A string representing the name of the "StateMachine" you want to control within the "artboard" like here we have the name of  'StateMachine' as 'State Machine 1' .

  // The return type of "StateMachineController.fromArtboard" is "StateMachineController?", meaning it might return "null" if the controller couldn't be created successfully.

  // The line "artboard.addController(controller!);" is adding the controller obtained from the "StateMachineController.fromArtboard" method to the given "artboard".
  // This step is crucial for connecting the animation's "state machine controller" to the animation's "artboard', allowing you to control the animation's behavior through the defined states and transitions.

  // The method concludes by returning the obtained controller instance. The non-null assertion operator (!) is used to indicate that you are confident that the controller will not be null at this point. However, it's important to handle potential null values in a real-world application to prevent crashes.
  //
  // In summary, the "getRiveController" method retrieves a "StateMachineController" instance that allows you to control and manage the state machine within a given "Artboard" of a Rive animation. This controller can then be used to control the animation's states, transitions, and other aspects specified within the animation itself.

  // I have commented out the RiveController here because I have already created it in the 'rive_utils' file to be used throughout the app
  //   ..............................................          ....................................     .......................
  // StateMachineController getRiveController(Artboard artboard) {
  //   // When you click the "Preview in Rive" button on the RiveAnimation in RiveWebsite so you will be redirected to 'editor.rive.app'.
  //   // ... There on the 'BottomLeft' corner you will see StateMachine's name, here in our project the name of 'stateMachine is 'State Machine 1'
  //   StateMachineController? controller = StateMachineController.fromArtboard(artboard, "State Machine 1");
  //   artboard.addController(controller!);
  //
  //  return controller;
  // }

  void signIn(BuildContext context) {
    setState(() {
      isShowLoading = true;
      isShowConfetti = true;
    });

    Future.delayed(
        Duration(seconds: 1),
            () {
          // Here I am using Rive animation named 'Check/Error' from "rive.app"
          // When user taps the SignIn button he will be first shown a Loading Indicator
          if(_formKey.currentState!.validate()) {
            // If everything looks good then here we will be shown the success animation
            //If _formKey.currentState!.validate() returns true, it means the form validation is successful.
            // In this case, the "check" trigger's "fire" method is called to trigger the success animation.
            // After a delay of 2 seconds, the "isShowLoading" state is set to false, indicating that the loading animation should be hidden.
            check.fire();
            Future.delayed(
                Duration(seconds: 2),
                    (){
                  setState(() {
                    isShowLoading = false;
                  });

                  confetti.fire();
                  // After successfully logging In we will navigate to the Home Screen of the app which is named as 'EntryPoint' here with a delay of 1 second so that the 'confetti' animation can complety show itself
                  Future.delayed(
                      Duration(seconds: 1),
                      () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EntryPoint(),
                            )
                        );
                      }
                  );

                }
            );

          }else {
            // If things go wrong or error occur, then here we will be shown the failure animation
            // If validation fails, the "error" trigger's "fire" method is called to trigger the error animation.
            // The behavior is similar to the success case, where after a delay of 2 seconds, isShowLoading is set to false.
            error.fire();
            Future.delayed(
                Duration(seconds: 2),
                    () {
                  setState(() {
                    isShowLoading = false;
                  });
                }
            );
          }
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text("Email", style: TextStyle(color: Colors.black54),),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 16),
                  child: TextFormField(
                    validator: (value) {
                      if(value!.isEmpty) {
                        return "";
                      }
                      return null;
                    },
                    onSaved: (email) {},
                    decoration: InputDecoration(
                        prefix: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: SvgPicture.asset("assets/icons/email.svg"),
                        ),
                      //contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),

                Text("Password", style: TextStyle(color: Colors.black54),),
                Padding(
                  padding: const EdgeInsets.only(top: 1, bottom: 16),
                  child: TextFormField(
                    validator: (value) {
                      if(value!.isEmpty) {
                        return "";
                      }
                      return null;
                    },
                    onSaved: (password) {},
                    obscureText: true,   // this will hide the password
                    decoration: InputDecoration(
                        prefix: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: SvgPicture.asset("assets/icons/password.svg"),
                        ),
                     // contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),

               Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 24),
                  child: ElevatedButton.icon(
                      onPressed: () {
                        signIn(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF77DBE),
                          // minimumSize: Size(width, height)
                          minimumSize: const Size(double.infinity, 56),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
                                  bottomLeft: Radius.circular(25)
                              )
                          )
                      ),
                      icon: const Icon(CupertinoIcons.arrow_right, color: Color(0xFFFE0037),),
                      label: Text("Sign In")
                  ),
                ),

              ],
            )
        ),

        // We have 3 triggers to show 3 different animations from within the Rive Animation that we have added to assets
        // ... thus to get these three different animations from within the Rive Animation we declare the
        // 'Positioned.fill': This widget is used to position its child widget within its parent widget so that it occupies the entire available space. In this case, it seems like the animation will be displayed to fill the available space within the parent widget.
        //
        // 'RiveAnimation.asset': This widget is used to load and display a Rive animation from an asset file. The asset file path "assets/RiveAssets/check.riv" points to the location of the Rive animation asset.
        //
        // 'onInit Callback': This is a callback function that is called when the Rive animation's 'artboard' is initialized. It receives an artboard parameter, which represents the loaded animation's artboard.
        //
        // 'StateMachineController Initialization': Inside the 'onInit' callback, the provided 'getRiveController' function is used to obtain a 'StateMachineController' that is responsible for controlling the animation's state machine.
        //
        // 'Triggers Initialization': The 'controller.findSMI("Check")' is used to find a specific SMITrigger named "Check" within the animation's state machine. Similarly, "Error" and "Reset" triggers are found using the findSMI method. These triggers are then assigned to the check, error, and reset variables respectively.
        //
        // Overall, this code snippet is loading a Rive animation from an asset file and initializing triggers ("Check," "Error," and "Reset") based on the animation's state machine. These triggers are assigned to corresponding variables and can be later used to control the animation's behavior dynamically.

        isShowLoading ?
            CustomPositioned(
                child: RiveAnimation.asset(
                  "assets/RiveAssets/check.riv",
                  onInit: (artboard) {
                    StateMachineController controller = RiveUtils.getRiveController(artboard);
                    check = controller.findSMI("Check") as SMITrigger;    // "controller.findSMI("Check")" is used to find a specific 'SMITrigger' named "Check" within the animation's state machine.
                    error = controller.findSMI("Error") as SMITrigger;    // "controller.findSMI("Error")" is used to find a specific 'SMITrigger' named "Error" within the animation's state machine.
                    reset = controller.findSMI("Reset") as SMITrigger;
                  },
                ),
            )
            : const SizedBox(),


        // This is a celebratory explosion type animation which usually appears after success.
       isShowConfetti
           ? CustomPositioned(
          //The Transform.scale widget is being used to adjust the scale (size) of its child which is Rive Animation (Confetti) in this case which is an explosion type animation.
          // The 'scale' parameter is set to 7, which means the child (the confetti animation) will be scaled up by a factor of 7.
            child: Transform.scale(
              scale: 7,
              child: RiveAnimation.asset(
                "assets/RiveAssets/confetti.riv",
                onInit: (artboard) {
                  StateMachineController controller = RiveUtils.getRiveController(artboard);
                  // "controller.findSMI("Trigger explosion")" is used to find a specific 'SMITrigger' named "Trigger explosion" within the animation's state machine.
                  confetti = controller.findSMI("Trigger explosion") as SMITrigger;
                },
              ),
            )
        )
           : SizedBox(),

      ],
    );
  }
}

class CustomPositioned extends StatelessWidget {
  const CustomPositioned({super.key, required this.child, this.size = 100});

  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) {
    return  Positioned.fill(
      child: Column(
        children: [
          // The "Spacer" Widgets at top and bottom of the SizedBox here is helping to adjust the Progress animation in the middle of the 'SignInForm' between the two 'TextFormFields'
          Spacer(),
          SizedBox(
            height: size,   // the value of 'size' is custom given as the parameter in constructor of this class
            width: size,
            child: child
          ),
          Spacer(flex: 2,)
        ],
      ),
    );
  }
}
