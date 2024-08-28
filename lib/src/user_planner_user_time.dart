class UserPlannerUserTime {
  /// Day index from 0, this index dependence on your time planner header
  int day;

  /// Task will be begin at this hour
  int index;

  UserPlannerUserTime({
    required this.day,
    required this.index,
  });
}