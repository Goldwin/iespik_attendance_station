import 'package:iespik_attendance_station/app/attendance/domain/attendance_component.dart';
import 'package:iespik_attendance_station/app/attendance/domain/queries/event_queries.dart';
import 'package:iespik_attendance_station/app/attendance/domain/queries/event_schedule_queries.dart';
import 'package:iespik_attendance_station/app/attendance/domain/queries/household_queries.dart';
import 'package:iespik_attendance_station/app/attendance/domain/queries/label_queries.dart';
import 'package:iespik_attendance_station/data/attendance/api/church_event_queries.dart';
import 'package:iespik_attendance_station/data/attendance/api/church_event_schedule_queries.dart';
import 'package:iespik_attendance_station/infra/api/attendance/attendance_client.dart';
import 'package:iespik_attendance_station/infra/api/people/people_client.dart';

import 'household_queries.dart';

class AttendanceComponentImpl extends AttendanceComponent {
  final PeopleService peopleService = PeopleService();
  final AttendanceService attendanceService = AttendanceService();

  late final HouseholdQueries _householdQueries;
  late final ChurchEventQueries _churchEventQueries;
  late final ChurchEventScheduleQueries _churchEventScheduleQueries;

  AttendanceComponentImpl() {
    _householdQueries = HouseholdQueriesImpl(peopleService);

    _churchEventQueries = APIChurchEventQueriesImpl(attendanceService);
    _churchEventScheduleQueries =
        APIChurchEventScheduleQueriesImpl(attendanceService);
  }

  @override
  ChurchEventQueries getChurchEventQueries() {
    return _churchEventQueries;
  }

  @override
  HouseholdQueries getHouseholdQueries() {
    return _householdQueries;
  }

  @override
  LabelQueries labelQueries() {
    // TODO: implement labelQueries
    throw UnimplementedError();
  }

  @override
  ChurchEventScheduleQueries getChurchEventScheduleQueries() {
    return _churchEventScheduleQueries;
  }
}
