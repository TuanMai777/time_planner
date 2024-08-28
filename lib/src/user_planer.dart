import 'package:flutter/material.dart';
import 'package:time_planner/src/config/global_config.dart' as config;
import 'package:time_planner/src/time_planner_style.dart';
import 'package:time_planner/src/time_planner_title.dart';
import 'package:time_planner/src/user_planer_task.dart';

/// Time planner widget
class UserPlanner extends StatefulWidget {
  /// Time start from this, it will start from 0
  final int totalCell;

  /// Create days from here, each day is a TimePlannerTitle.
  ///
  /// you should create at least one day
  final List<TimePlannerTitle> headers;

  /// List of widgets on time planner
  final List<UserPlannerTask>? tasks;

  /// Style of time planner
  final TimePlannerStyle? style;

  /// When widget loaded scroll to current time with an animation. Default is true
  final bool? currentTimeAnimation;

  /// Whether time is displayed in 24 hour format or am/pm format in the time column on the left.
  final bool use24HourFormat;

  //Whether the time is displayed on the axis of the tim or on the center of the timeblock. Default is false.
  final bool setTimeOnAxis;

  /// Time planner widget
  const UserPlanner({
    Key? key,
    required this.totalCell,
    required this.headers,
    this.tasks,
    this.style,
    this.use24HourFormat = false,
    this.setTimeOnAxis = false,
    this.currentTimeAnimation,
  }) : super(key: key);

  @override
  _UserPlannerState createState() => _UserPlannerState();
}

class _UserPlannerState extends State<UserPlanner> {
  ScrollController mainHorizontalController = ScrollController();
  ScrollController mainVerticalController = ScrollController();
  ScrollController dayHorizontalController = ScrollController();
  ScrollController timeVerticalController = ScrollController();
  TimePlannerStyle style = TimePlannerStyle();
  List<UserPlannerTask> tasks = [];
  bool? isAnimated = true;

  /// check input value rules
  void _checkInputValue() {
    if (widget.headers.isEmpty) {
      throw FlutterError("header can't be empty");
    }
  }

  /// create local style
  void _convertToLocalStyle() {
    style.backgroundColor = widget.style?.backgroundColor;
    style.cellHeight = widget.style?.cellHeight ?? 80;
    style.cellWidth = widget.style?.cellWidth ?? 90;
    style.horizontalTaskPadding = widget.style?.horizontalTaskPadding ?? 0;
    style.borderRadius = widget.style?.borderRadius ??
        const BorderRadius.all(Radius.circular(8.0));
    style.dividerColor = widget.style?.dividerColor;
    style.showScrollBar = widget.style?.showScrollBar ?? false;
    style.interstitialOddColor = widget.style?.interstitialOddColor;
    style.interstitialEvenColor = widget.style?.interstitialEvenColor;
  }

  /// store input data to static values
  void _initData() {
    _checkInputValue();
    _convertToLocalStyle();
    config.horizontalTaskPadding = style.horizontalTaskPadding;
    config.cellHeight = style.cellHeight;
    config.cellWidth = style.cellWidth;
    config.totalHours = (widget.totalCell).toDouble();
    config.totalDays = widget.headers.length;
    config.startHour = 0;
    config.use24HourFormat = widget.use24HourFormat;
    config.setTimeOnAxis = widget.setTimeOnAxis;
    config.borderRadius = style.borderRadius;
    isAnimated = widget.currentTimeAnimation;
    tasks = widget.tasks ?? [];
  }

  @override
  void initState() {
    _initData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // we need to update the tasks list in case the tasks have changed
    tasks = widget.tasks ?? [];
    mainHorizontalController.addListener(() {
      dayHorizontalController.jumpTo(mainHorizontalController.offset);
    });
    mainVerticalController.addListener(() {
      timeVerticalController.jumpTo(mainVerticalController.offset);
    });
    return GestureDetector(
      child: Container(
        color: style.backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SingleChildScrollView(
              controller: dayHorizontalController,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(width: 0),
                  for (int i = 0; i < config.totalDays; i++) widget.headers[i],
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: timeVerticalController,
                    ),
                  ),
                  Expanded(
                    child: buildMainBody(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMainBody() {
    if (style.showScrollBar!) {
      return Scrollbar(
        controller: mainVerticalController,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: mainVerticalController,
          child: Scrollbar(
            controller: mainHorizontalController,
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: mainHorizontalController,
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: (config.totalHours * config.cellHeight!) + 80,
                        width:
                            (config.totalDays * config.cellWidth!).toDouble() + 1,
                        child: Stack(
                          children: <Widget>[
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                for (var i = 0; i < config.totalHours; i++)
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        color: Colors.white,
                                        height:
                                            (config.cellHeight! - 1).toDouble(),
                                      ),
                                      // The horizontal lines tat divides the rows
                                      //TODO: Make a configurable color for this (maybe a size too)
                                      const Divider(
                                        height: 1,
                                      ),
                                    ],
                                  )
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                for (var i = 0; i < config.totalDays; i++)
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      if (i == 0)
                                        Container(
                                          width: 1,
                                          height: (config.totalHours *
                                                  config.cellHeight!) +
                                              config.cellHeight!,
                                          color: Colors.black12,
                                        ),
                                      SizedBox(
                                        width:
                                            (config.cellWidth! - 1).toDouble(),
                                      ),
                                      // The vertical lines that divides the columns
                                      //TODO: Make a configurable color for this (maybe a size too)
                                      Container(
                                        width: 1,
                                        height: (config.totalHours *
                                                config.cellHeight!) +
                                            config.cellHeight!,
                                        color: Colors.black12,
                                      )
                                    ],
                                  )
                              ],
                            ),
                            for (int i = 0; i < tasks.length; i++) tasks[i],
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return SingleChildScrollView(
      controller: mainVerticalController,
      child: SingleChildScrollView(
        controller: mainHorizontalController,
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: (config.totalHours * config.cellHeight!) + 80,
                  width: (config.totalDays * config.cellWidth!).toDouble(),
                  child: Stack(
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          for (var i = 0; i < config.totalHours; i++)
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(
                                  height: (config.cellHeight! - 1).toDouble(),
                                ),
                                const Divider(
                                  height: 1,
                                ),
                              ],
                            )
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          for (var i = 0; i < config.totalDays; i++)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(
                                  width: (config.cellWidth! - 1).toDouble(),
                                ),
                                Container(
                                  width: 1,
                                  height:
                                      (config.totalHours * config.cellHeight!) +
                                          config.cellHeight!,
                                  color: Colors.black12,
                                )
                              ],
                            )
                        ],
                      ),
                      for (int i = 0; i < tasks.length; i++) tasks[i],
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
