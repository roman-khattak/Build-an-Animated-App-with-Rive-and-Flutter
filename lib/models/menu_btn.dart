
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class MenuBtn extends StatelessWidget {
  const MenuBtn({
    super.key,
    required this.press,
    required this.riveOnInit,
  });

  final VoidCallback press;
  final ValueChanged<Artboard> riveOnInit;   // this variable is declared to store the 'onInit' function from RiveAnimation on it

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: press,
        child: Container(
          margin: EdgeInsets.only(left: 16),
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              //The offset property determines the relative position of the shadow in relation to the widget to which it is applied.

              //  In this case, the shadow is offset by 0 pixels horizontally (no horizontal shift) and 3 pixels vertically (shifted 3 pixels downward).

              // offset: Offset(0, 3), means that the shadow applied to the widget will appear directly beneath it (horizontal offset of 0) and 3 pixels below the widget (vertical offset of 3),
              // ... giving the visual impression that the widget is slightly raised above the background with a shadow falling below it.
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 3),
                  blurRadius: 8
              )
            ],
          ),
          child: RiveAnimation.asset(
              "assets/RiveAssets/menu_button.riv",
              onInit: riveOnInit
          ),
        ),
      ),
    );
  }
}