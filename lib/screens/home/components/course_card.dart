import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../models/course.dart';
import '../home_screen.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.course,
  });

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      height: 280,
      width: 260,
      decoration: BoxDecoration(
        color: course.bgColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded( // this expanded widget will make sure for the Column to take up all the available space inside the row and its content can adjust if screen size reduce or increase
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 8),
                    child: Text(
                      course.description,
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),

                  const Text(
                    "61 Sections - 11 HOURS",
                    style: TextStyle(color: Colors.white54),
                  ),

                  Spacer(),

                  // 'List.generate': This generates a list containing three items (specified by the count '3'). Each item is generated using the provided generator function.
                  //
                  // 'Generator Function (Transform.translate)': For each index from 0 to 2 (as specified by the count in 'List.generate'), a 'Transform.translate' widget is created.
                  //
                  // offset: The offset parameter of Transform.translate defines a horizontal translation for the child widget. In this case, the X-coordinate of the translation (offset.dx) is '-10 * index'.

                  ///" Offset((-10 * index).toDouble(), 0) "... ... ... constructs an Offset object for the translation. Let's break down what's happening inside:
                  //
                  /// "-10 * index": This calculates the horizontal translation amount based on the index of the item.
                  /// For the first item "(index 0)", this results in "0". For the second item (index 1), it's "-10". For the third item "(index 2)", it's "-20".
                  //
                  /// ".toDouble()": This converts the calculated translation to a double value, as the Offset constructor expects double values.
                  //
                  /// "0:" This represents the vertical translation, which is 0 in this case, meaning there is no vertical movement.

                  //
                  // This means that the first avatar will have no translation, the second will be moved left by 10 pixels, and the third will be moved left by 20 pixels.
                  //
                  // 'child: CircleAvatar': The child of the 'Transform.translate' is a 'CircleAvatar' widget, representing an avatar image.
                  //
                  // The 'backgroundImage' property is set to an 'AssetImage' representing the avatar image for each index.
                  //
                  // The 'index + 1' is used to construct the correct asset path based on the index (e.g., "Avatar 1.jpg", "Avatar 2.jpg", and so on).
                  Row(
                      children: List.generate(
                          3,
                              (index) => Transform.translate(
                            offset: Offset((-10 * index).toDouble(), 0),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage("assets/avaters/Avatar ${index + 1}.jpg"),
                            ),
                          )
                      )
                  )

                ],
              )
          ),

          SvgPicture.asset(course.iconSrc),

        ],
      ),
    );
  }
}