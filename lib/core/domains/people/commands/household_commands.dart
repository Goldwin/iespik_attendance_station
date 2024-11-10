import '../../attendance/entities/people/household.dart';

abstract class HouseholdCommands {
  Future<Household> createHousehold(String name);
}
