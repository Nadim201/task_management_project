import 'package:flutter/material.dart';

class TaskSummaryCard extends StatelessWidget {
  const TaskSummaryCard({
    super.key,
    required this.title,
    required this.counter,
  });

  final String title;
  final int counter;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: SizedBox(
        width: 150,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$counter',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 2,),
              Text(
                title,style: TextStyle(color: Colors.grey,fontSize: 16)
              )
            ],
          ),
        ),
      ),
    );
  }
}