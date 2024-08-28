import 'package:flutter/material.dart';
import 'package:time_planner/src/config/global_config.dart' as config;

class UserPlannerUser extends StatelessWidget {
  /// Text it will be show as hour
  final String user;

  /// Show the hour for each row of time planner
  const UserPlannerUser({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: config.cellHeight!.toDouble() - 1,
      width: 60,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
        child: Center(child: Text(user)),
      ),
    );
  }
}