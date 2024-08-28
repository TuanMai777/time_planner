import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:time_planner/time_planner.dart';

void main() {
  runApp(const MyApp());
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time planner Demo',
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage2(title: 'Time planner'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<TimePlannerTask> tasks = [
    TimePlannerTask(
      color: Colors.purple,
      dateTime: TimePlannerDateTime(
        day: 0,
        hour: 8,
        minutes: 60,
      ),
      minutesDuration:60,
      daysDuration: 1,
      onTap: () {},
      child: Text(
        'this is a demo 1',
        style: TextStyle(color: Colors.grey[350], fontSize: 12),
      ),
    ),
    TimePlannerTask(
      color: Colors.blue,
      dateTime: TimePlannerDateTime(
        day: 2,
        hour: 9,
        minutes: 60,
      ),
      minutesDuration: 60,
      daysDuration: 2,
      onTap: () {},
      child: Text(
        'this is a demo 2',
        style: TextStyle(color: Colors.grey[350], fontSize: 12),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: TimePlanner(
          startHour: 6,
          endHour: 23,
          use24HourFormat: false,
          setTimeOnAxis: false,
          style: TimePlannerStyle(
            // cellHeight: 60,
            // cellWidth: 60,
            showScrollBar: true,
            interstitialEvenColor: Colors.grey[50],
            interstitialOddColor: Colors.grey[200],
          ),
          headers: const [
            TimePlannerTitle(
              date: "3/01/2021",
              title: "thursday",
            ),
            TimePlannerTitle(
              date: "3/02/2021",
              title: "friday",
            ),
            TimePlannerTitle(
              date: "3/03/2021",
              title: "saturday",
            ),
            TimePlannerTitle(
              date: "3/04/2021",
              title: "monday",
            ),
            TimePlannerTitle(
              date: "3/05/2021",
              title: "tuesday",
            ),
            TimePlannerTitle(
              date: "3/06/2021",
              title: "wednesday",
            ),
            TimePlannerTitle(
              date: "3/07/2021",
              title: "thursday",
            ),
            TimePlannerTitle(
              date: "3/08/2021",
              title: "friday",
            ),
            TimePlannerTitle(
              date: "3/09/2021",
              title: "saturday",
            ),
            TimePlannerTitle(
              date: "3/10/2021",
              title: "sunday",
            ),
            TimePlannerTitle(
              date: "3/11/2021",
              title: "monday",
            ),
            TimePlannerTitle(
              date: "3/12/2021",
              title: "tuesday",
            ),
            TimePlannerTitle(
              date: "3/13/2021",
              title: "wednesday",
            ),
            TimePlannerTitle(
              date: "3/14/2021",
              title: "thursday",
            ),
            TimePlannerTitle(
              date: "3/15/2021",
              title: "friday",
            ),
            TimePlannerTitle(
              date: "3/16/2021",
              title: "saturday",
            ),
            TimePlannerTitle(
              date: "3/17/2021",
              title: "sunday",
            ),
            TimePlannerTitle(
              date: "3/18/2021",
              title: "monday",
            ),
            TimePlannerTitle(
              date: "3/19/2021",
              title: "tuesday",
            ),
            TimePlannerTitle(
              date: "3/20/2021",
              title: "wednesday",
            ),
            TimePlannerTitle(
              date: "3/21/2021",
              title: "thursday",
            ),
            TimePlannerTitle(
              date: "3/22/2021",
              title: "friday",
            ),
            TimePlannerTitle(
              date: "3/23/2021",
              title: "saturday",
            ),
            TimePlannerTitle(
              date: "3/24/2021",
              title: "tuesday",
            ),
            TimePlannerTitle(
              date: "3/25/2021",
              title: "wednesday",
            ),
            TimePlannerTitle(
              date: "3/26/2021",
              title: "thursday",
            ),
            TimePlannerTitle(
              date: "3/27/2021",
              title: "friday",
            ),
            TimePlannerTitle(
              date: "3/28/2021",
              title: "saturday",
            ),
            TimePlannerTitle(
              date: "3/29/2021",
              title: "friday",
            ),
            TimePlannerTitle(
              date: "3/30/2021",
              title: "saturday",
            ),
            TimePlannerTitle(
              date: "3/31/2021",
              title: "sunday",
            ),
          ],
          tasks: tasks,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add random task',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MyHomePage2 extends StatefulWidget {
  final String title;
  const MyHomePage2({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage2> createState() => _MyHomePage2State();
}

class _MyHomePage2State extends State<MyHomePage2> {
  List<UserPlannerTask> tasks = [
    UserPlannerTask(
      color: const Color(0xFF83A3F8).withOpacity(0.75),
      dateTime: UserPlannerUserTime(
        day: 3,
        index: 0,
      ),
      minutesDuration:60,
      daysDuration: 3,
      onTap: () {},
      child: const Text(
        'this is a demo 1',
        style: TextStyle(color: Color(0xFF535354), fontSize: 12),
      ),
    ),
    UserPlannerTask(
      color: const Color(0xFF83A3F8).withOpacity(0.75),
      dateTime: UserPlannerUserTime(
        day: 0,
        index: 0,
      ),
      minutesDuration:60,
      daysDuration: 1,
      onTap: () {},
      child: const Text(
        'this is a demo 1',
        style: TextStyle(color: Color(0xFF535354), fontSize: 12),
      ),
    ),
    UserPlannerTask(
      color: const Color(0xFF83A3F8).withOpacity(0.75),
      dateTime: UserPlannerUserTime(
        day: 2,
        index: 1,
      ),
      minutesDuration: 60,
      daysDuration: 2,
      onTap: () {},
      child: const Text(
        'this is a demo 2',
        style: TextStyle(color: Color(0xFF535354), fontSize: 12),
      ),
    ),
  ];

  List<DateTime> dateTime = [];

  @override
  void initState() {
    final now = DateTime.now();
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    final lastDayOfMonthBefore = DateTime(now.year, now.month, 0);
    for(int i = 0; i < lastDayOfMonth.day; i++){
      dateTime.add(lastDayOfMonthBefore.add(Duration(days: i + 1)));
    }
    super.initState();
  }


  String getDayOfWeek(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return "Mon";
      case DateTime.tuesday:
        return "Tue";
      case DateTime.wednesday:
        return "Wed";
      case DateTime.thursday:
        return "Thu";
      case DateTime.friday:
        return "Fri";
      case DateTime.saturday:
        return "Sat";
      case DateTime.sunday:
        return "Sun";
      default:
        return "Unknown";
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: UserPlanner(
            totalCell: 10,
            use24HourFormat: false,
            setTimeOnAxis: false,
            style: TimePlannerStyle(
              cellHeight: 60,
              cellWidth: 80,
              showScrollBar: true,
              interstitialEvenColor: Colors.grey[50],
              interstitialOddColor: Colors.grey[200],
            ),
            headers:  [

              ...List.generate(dateTime.length, (index){
                return TimePlannerTitle(
                  date: dateTime[index].day.toString(),
                  title: getDayOfWeek(dateTime[index].weekday),
                  titleStyle: const TextStyle(color: Color(0xFF3B71CA), fontSize: 12, fontWeight: FontWeight.w500),
                  dateStyle: const TextStyle(color: Color(0xFF3B71CA), fontSize: 12, fontWeight: FontWeight.w300),
                );
              }),
            ],
            tasks: tasks,
          ),
        ),
      ),
    );
  }
}

