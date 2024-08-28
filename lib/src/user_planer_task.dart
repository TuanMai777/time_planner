import 'package:flutter/material.dart';
import 'package:time_planner/src/config/global_config.dart' as config;
import 'package:time_planner/src/user_planner_user_time.dart';

/// Widget that show on time planner as the tasks
class UserPlannerTask extends StatelessWidget {
  /// Minutes duration of task or object
  final int minutesDuration;

  /// Days duration of task or object, default is 1
  final int? daysDuration;

  /// When this task will be happen
  final UserPlannerUserTime dateTime;

  /// Background color of task
  final Color? color;

  /// This will be happen when user tap on task, for example show a dialog or navigate to other page
  final Function? onTap;

  /// Show this child on the task
  ///
  /// Typically an [Text].
  final Widget? child;

  /// parameter to set space from left, to set it: config.cellWidth! * dateTime.day.toDouble()
  final double? leftSpace;

  /// parameter to set width of task, to set it: (config.cellWidth!.toDouble() * (daysDuration ?? 1)) -config.horizontalTaskPadding!
  final double? widthTask;

  /// Widget that show on time planner as the tasks
  const UserPlannerTask(
      {Key? key,
        required this.minutesDuration,
        required this.dateTime,
        this.daysDuration,
        this.color,
        this.onTap,
        this.child,
        this.leftSpace,
        this.widthTask})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: (config.cellHeight! * (dateTime.index)).toDouble(),
      left: config.cellWidth! * dateTime.day.toDouble() + (leftSpace ?? 0.0),
      child: SizedBox(
        width: widthTask,
        child: Padding(
          padding:
          EdgeInsets.only(left: config.horizontalTaskPadding!.toDouble()),
          child: Material(
            elevation: 3,
            borderRadius: config.borderRadius,
            child: Stack(
              children: [
                InkWell(
                  onTap: onTap as void Function()? ?? () {},
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    height: ((minutesDuration.toDouble() * config.cellHeight!) /
                        60), //60 minutes
                    width: (config.cellWidth!.toDouble() * (daysDuration ?? 1)),
                    decoration: BoxDecoration(
                        borderRadius: config.borderRadius,
                        color: color ?? Theme.of(context).primaryColor),
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}