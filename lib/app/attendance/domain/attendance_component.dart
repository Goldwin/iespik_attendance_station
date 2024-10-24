import 'queries/event_queries.dart';
import 'queries/household_queries.dart';
import 'queries/label_queries.dart';

abstract class AttendanceComponent {
  ChurchEventQueries getChurchEventQueries();

  HouseholdQueries getHouseholdQueries();

  LabelQueries labelQueries();
}
