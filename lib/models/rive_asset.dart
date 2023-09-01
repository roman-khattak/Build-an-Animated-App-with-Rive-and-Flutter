import 'package:rive/rive.dart';


/// on the basis of this model we extract and display the "bottom Navigation Bar's items"


class RiveAsset {   // Creating a Model class where we will extract all the Icons from "assets/RiveAssets/icons.riv", and then from this class we can get every icon individually

  final String artboard, stateMachineName, title, src;
  late SMIBool? input;

  RiveAsset(
      this.src,  // This is the source file of icons
          {
        required this.artboard,
        required this.stateMachineName,
        required this.title,
        this.input
      });

  // The SMIBool is a component of the Rive animation framework that represents a boolean state within a state machine.
  // It can have values of "true", "false", or "null".
  set setInput(SMIBool status) {  // A nullable SMIBool (State Machine Input Boolean) instance. This seems to be related to handling interaction states in the animation, specifically using a State Machine Input of type SMIBool (State Machine Input Boolean)..
    input = status;
  }

}

// The bottomNavs list is defined and contains instances of the RiveAsset class. Each instance represents a specific icon animation configuration.
List<RiveAsset> bottomNavs = [
  RiveAsset(
      "assets/RiveAssets/icons.riv",   //  The path to the Rive animation asset file.
      artboard: "CHAT",   // The name of the artboard within the Rive animation asset.
      stateMachineName: "CHAT_Interactivity",  // this is the name of 'stateMachine' in 'Rive.app' tool for 'CHAT' icon
      title: "Chat"
  ),
  RiveAsset(
      "assets/RiveAssets/icons.riv",
      artboard: "SEARCH",   //The name of the artboard within the Rive animation asset.
      stateMachineName: "SEARCH_Interactivity", // this is the name of 'stateMachine' in 'Rive.app' tool for 'SEARCH' icon
      title: "Search"
  ),
  RiveAsset(
      "assets/RiveAssets/icons.riv",
      artboard: "TIMER",
      stateMachineName: "TIMER_Interactivity", // this is the name of 'stateMachine' in 'Rive.app' tool for 'TIMER' icon
      title: "Timer"
  ),
  RiveAsset(
      "assets/RiveAssets/icons.riv",
      artboard: "BELL",
      stateMachineName: "BELL_Interactivity",
      title: "Notification"
  ),
  RiveAsset(
      "assets/RiveAssets/icons.riv",
      artboard: "USER",
      stateMachineName: "USER_Interactivity",
      title: "Profile"
  ),

];

// If there is a spell mistake in the name of 'stateMachine' the controller will throw a null error
List<RiveAsset> sideMenuIconsList = [
  RiveAsset(
      "assets/RiveAssets/icons.riv",
      artboard: "HOME",
      stateMachineName: "HOME_interactivity",
      title: "Home"
  ),

  RiveAsset(
      "assets/RiveAssets/icons.riv",
      artboard: "SEARCH",
      stateMachineName: "SEARCH_Interactivity",
      title: "Search"
  ),

  RiveAsset(
      "assets/RiveAssets/icons.riv",
      artboard: "LIKE/STAR",
      stateMachineName: "STAR_Interactivity",
      title: "Favourite"
  ),

  RiveAsset(
      "assets/RiveAssets/icons.riv",
      artboard: "CHAT",
      stateMachineName: "CHAT_Interactivity",
      title: "Help"
  )

];


List<RiveAsset> sideMenuIconsList2 = [
  RiveAsset(
      "assets/RiveAssets/icons.riv",
      artboard: "TIMER",
      stateMachineName: "TIMER_Interactivity",
      title: "History"
  ),

  RiveAsset(
      "assets/RiveAssets/icons.riv",
      artboard: "BELL",
      stateMachineName: "BELL_Interactivity",
      title: "Notification"
  )
];