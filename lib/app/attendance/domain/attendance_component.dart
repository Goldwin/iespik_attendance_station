import 'package:iespik_attendance_station/app/attendance/domain/queries/event_schedule_queries.dart';

import 'queries/event_queries.dart';
import 'queries/household_queries.dart';
import 'queries/label_queries.dart';

abstract class AttendanceComponent {
  ChurchEventScheduleQueries getChurchEventScheduleQueries();

  ChurchEventQueries getChurchEventQueries();

  HouseholdQueries getHouseholdQueries();

  LabelQueries labelQueries();
}
