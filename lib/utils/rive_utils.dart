import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveUtils {

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

  static StateMachineController getRiveController(Artboard artboard, {stateMachineName = "State Machine 1"}) {  // we place the 'stateMachineName' for the overall icons list statically here and pass it as argument down to controller
    // When you click the "Preview in Rive" button on the RiveAnimation in RiveWebsite so you will be redirected to 'editor.rive.app'.
    // ... There on the 'BottomLeft' corner you will see StateMachine's name, here in our project the name of 'stateMachine is 'State Machine 1'
    StateMachineController? controller = StateMachineController.fromArtboard(artboard , stateMachineName);   // here the stateMachine name of individual icon will be passed which is different from "State Machine 1"

    // Error: If there is even a small spell mistake in the name of 'stateMachine' this controller will be null and you will get a null error
     artboard.addController(controller!);

    return controller;

  }

}