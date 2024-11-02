import 'commands/church_event_attendance.dart';
import 'queries/event_queries.dart';
import 'queries/event_schedule_queries.dart';
import 'queries/label_queries.dart';

abstract class AttendanceComponent {
  ChurchEventAttendanceCommands getChurchEventAttendanceCommands();

  ChurchEventScheduleQueries getChurchEventScheduleQueries();

  ChurchEventQueries getChurchEventQueries();

  LabelQueries labelQueries();
}
