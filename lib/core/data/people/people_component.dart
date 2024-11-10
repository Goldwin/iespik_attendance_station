import 'package:iespik_attendance_station/core/domains/people/commands/household_commands.dart';
import 'package:iespik_attendance_station/core/domains/people/commands/person_commands.dart';
import 'package:iespik_attendance_station/core/domains/people/queries/household_queries.dart';

import '../../domains/people/people_component.dart';
import '../../infra/api/people/people_client.dart';
import 'queries/household_queries.dart';

class APIPeopleComponentImpl extends PeopleComponent {
  final PeopleService _peopleService = PeopleService();
  late final HouseholdQueries _householdQueries;

  APIPeopleComponentImpl() {
    _householdQueries = HouseholdQueriesImpl(_peopleService);
  }

  @override
  HouseholdQueries getHouseholdQueries() {
    return _householdQueries;
  }

  @override
  HouseholdCommands getHouseholdCommands() {
    // TODO: implement getHouseholdCommands
    throw UnimplementedError();
  }

  @override
  PersonCommands getPersonCommands() {
    // TODO: implement getPersonCommands
    throw UnimplementedError();
  }
}
