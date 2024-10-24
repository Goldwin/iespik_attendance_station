import 'package:iespik_attendance_station/app/attendance/domain/attendance_component.dart';
import 'package:iespik_attendance_station/app/attendance/domain/queries/event_queries.dart';
import 'package:iespik_attendance_station/app/attendance/domain/queries/household_queries.dart';
import 'package:iespik_attendance_station/app/attendance/domain/queries/label_queries.dart';
import 'package:iespik_attendance_station/infra/api/people/people_client.dart';

import 'household_queries.dart';

class AttendanceComponentImpl extends AttendanceComponent {
  final PeopleService peopleService = PeopleService();

  late final HouseholdQueries householdQueries;

  AttendanceComponentImpl() {
    householdQueries = HouseholdQueriesImpl(peopleService);
  }

  @override
  ChurchEventQueries getChurchEventQueries() {
    return StubChurchEventQueriesImpl();
  }

  @override
  HouseholdQueries getHouseholdQueries() {
    return householdQueries;
  }

  @override
  LabelQueries labelQueries() {
    // TODO: implement labelQueries
    throw UnimplementedError();
  }
}
