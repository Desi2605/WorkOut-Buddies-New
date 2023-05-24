import 'package:flutter/material.dart';

class WorkoutTile extends StatelessWidget {
  final String workoutImagePath;
  final String workoutName;
  final String workoutDescrip;
  final String workoutDescrip1;

  WorkoutTile({
    required this.workoutImagePath,
    required this.workoutName,
    required this.workoutDescrip,
    required this.workoutDescrip1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, bottom: 25),
      child: Container(
        padding: EdgeInsets.all(15),
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.black54,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(workoutImagePath),
            ),

            //Name
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
              child: Column(
                children: [
                  Text(
                    workoutName,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    '2-4 Players',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  Text(
                    workoutDescrip1,
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                ],
              ),
            ),

            // Description
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(workoutDescrip),
                Icon(Icons.stadium),
              ],
            )
          ],
        ),
      ),
    );
  }
}
