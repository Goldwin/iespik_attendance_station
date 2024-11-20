import 'package:iespik_attendance_station/core/data/people/commands/person_commands.dart';
import 'package:iespik_attendance_station/core/domains/people/commands/person_commands.dart';
import 'package:iespik_attendance_station/core/domains/people/queries/household_queries.dart';

import '../../domains/people/people_component.dart';
import '../../infra/api/people/people_client.dart';
import 'queries/household_queries.dart';

class APIPeopleComponentImpl extends PeopleComponent {
  final PeopleService _peopleService = PeopleService();
  late final HouseholdQueries _householdQueries;
  late final PersonCommands _personCommands;

  APIPeopleComponentImpl() {
    _householdQueries = APIHouseholdQueriesImpl(_peopleService);
    _personCommands = APIPersonCommandsImpl(_peopleService);
  }

  @override
  HouseholdQueries getHouseholdQueries() {
    return _householdQueries;
  }

  @override
  PersonCommands getPersonCommands() {
    // TODO: implement getPersonCommands
    return _personCommands;
  }
}
