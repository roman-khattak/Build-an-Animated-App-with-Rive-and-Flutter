import 'package:flutter/material.dart';

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    // Adding animation to the container below
    return AnimatedContainer( // This container will create the 'bar' over the 'bottomNavBar Items'
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 2),
      height: 4,
      width: isActive ? 20 : 0,  // this will make sure that the 'bar' only appears over the top of that 'BottomNavBar Item' which is clicked and not over any other items
      decoration: BoxDecoration(
          color: Color(0xFF81B4FF),
          borderRadius: BorderRadius.all(Radius.circular(12))
      ),
    );
  }
}