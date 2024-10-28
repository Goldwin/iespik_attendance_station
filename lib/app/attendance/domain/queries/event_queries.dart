import '../entities/events/church_event.dart';

abstract class ChurchEventQueries {
  Future<ChurchEvent> getActiveEvent({String id, DateTime? date});
}

class StubChurchEventQueriesImpl implements ChurchEventQueries {
  @override
  Future<ChurchEvent> getActiveEvent({String? id, DateTime? date}) {
    throw UnimplementedError();
  }
}
