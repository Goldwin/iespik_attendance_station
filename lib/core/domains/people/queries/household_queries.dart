import '../../attendance/entities/people/household.dart';

abstract class HouseholdQueries {
  Future<List<Household>> listHouseholds({String name = "", int limit = 10});
}
