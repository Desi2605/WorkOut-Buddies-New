import 'package:flutter/material.dart';

class WorkoutType extends StatelessWidget {
  final String workoutType;
  final bool isSelected;
  // final VoidCallback onTap;

  WorkoutType({
    required this.workoutType,
    required this.isSelected,
    //required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: Text(
          workoutType,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.orange : Colors.white,
          ),
        ),
      ),
    );
  }
}
