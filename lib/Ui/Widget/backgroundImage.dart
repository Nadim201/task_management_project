import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_management_project/Ui/Utils/assets_path.dart';

class Backgroundimage extends StatefulWidget {
  final Widget child;

  const Backgroundimage({super.key, required this.child});

  @override
  State<Backgroundimage> createState() => _BackgroundImageState();
}

class _BackgroundImageState extends State<Backgroundimage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: SvgPicture.asset(
            imagePath.backgroundImage,
            fit: BoxFit.cover, // Cover entire screen
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(child: widget.child),
        )
      ],
    );
  }
}
