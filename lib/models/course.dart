import 'package:flutter/material.dart';

class Course {
  final String title, descripton, iconSrc;
  final Color bgColor;

  Course({
    required this.title,
    this.descripton = "Build and animate Ios app from scratch",
    this.iconSrc = 'assets/icons/ios.svg',
    this.bgColor = const Color(0xFF7553F6),
  });
}

List<Course> courses = [
  Course(title: 'Animation in SwiftUi'),
  Course(
      title: "Animation in Flutter",
      iconSrc: 'assets/icons/code.svg',
      bgColor: Color(0xFF80A4FF)),
  Course(
      title: "Animation in Dart",
      iconSrc: 'assets/icons/code.svg',
      bgColor: Color.fromARGB(255, 16, 28, 59))
];

List<Course> recentCourses = [
  Course(title: 'State Machine'),
  Course(
    title: 'Animated Menu',
    bgColor: Color(0xFF9CC5FF),
    iconSrc: 'assets/icons/code.svg',
  ),
  Course(title: 'Flutter with Rive'),
  Course(
    title: 'Animated Menu',
    bgColor: Color(0xFF9CC5FF),
    iconSrc: 'assets/icons/code.svg',
  ),
];
