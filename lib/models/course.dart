import 'package:flutter/material.dart';


//  Here 'Course' is a class.
// The 'Course' class is used as a blueprint to create instances (objects) that represent individual courses. Each instance of the Course class encapsulates information about a specific course, including its title, description, icon source, and background color. The provided code demonstrates how to create instances of the Course class and customize their properties using constructor arguments.
//
// For example, in the line Course(title: "Animations in SwiftUI"), you are creating an instance of the Course class with the title "Animations in SwiftUI" while using default values for the other properties.
//
// So, to clarify:
//
// 'Course' is a class definition.
// Instances created from the 'Course' class are 'objects' that represent individual courses.


// Let's create a model for courses
class Course {
  final String title, description, iconSrc;
  final Color bgColor;

  Course(
      { required this.title,
        this.description = "Build and animate an IOS app from Scratch",
        this.iconSrc = "assets/icons/ios.svg",
        this.bgColor = const Color(0xFF7553F6),   // if you don't place 'const' keyword then this Color will give error
      });
}

///"List of Courses" i.e, 'List<Course> courses':
// ............................................
//The 'courses' list is a list of 'Course' objects. It contains two instances of the 'Course' class:

//The first course has the title "Animations in SwiftUI". The 'description', 'iconSrc', and 'bgColor' properties will take their default values.

//The second course has the title "Animations in Flutter". It specifies values for the 'iconSrc' and 'bgColor' properties. The 'description' property will take its default value.
List<Course> courses = [

  Course(title: "Animations in SwiftUI"),  // This 'Course' is an object / instance of 'Course' class

  Course(                                // This 'Course' is an object / instance of 'Course' class
    title: "Animations in Flutter",
    iconSrc: "assets/icons/code.svg",
    bgColor: const Color(0xFF80A4FF),
  )

];


List<Course> recentCourses = [

  Course(title: "State Machine"),

  Course(
      title: "Animated Menu",
      bgColor: const Color(0xFF9CC5FF),
      iconSrc: "assets/icons/code.svg"
  ),

  Course(title: "State Machine"),

  Course(
      title: "Animated Menu",
      bgColor: const Color(0xFF9CC5FF),
      iconSrc: "assets/icons/code.svg"
  ),

];