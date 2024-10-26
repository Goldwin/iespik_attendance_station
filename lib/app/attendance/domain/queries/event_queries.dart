import '../entities/events/church_event.dart';
import '../entities/events/church_event_activity.dart';

abstract class ChurchEventQueries {
  Future<List<ChurchEvent>> listActiveEvents();
}

class StubChurchEventQueriesImpl implements ChurchEventQueries {
  @override
  Future<List<ChurchEvent>> listActiveEvents() async {
    return [
      ChurchEvent(
          id: "1",
          name: "Sunday Service",
          eventScheduleId: "1",
          startDate: DateTime.now(),
          endDate: DateTime.now().add(Duration(hours: 3)),
          activities: [
            ChurchEventActivity(
                id: "1", name: "Adult Service", time: DateTime.now()),
            ChurchEventActivity(
                id: "2", name: "Sunday School", time: DateTime.now()),
          ]),
      ChurchEvent(
          id: "2",
          name: "VBX",
          eventScheduleId: "1",
          startDate: DateTime.now(),
          endDate: DateTime.now().add(Duration(hours: 3)),
          activities: [
            ChurchEventActivity(
                id: "1", name: "Bible Lesson", time: DateTime.now())
          ])
    ];
  }
}
