import 'dart:convert';

import 'package:http/http.dart';
import 'package:iespik_attendance_station/app/attendance/domain/commands/church_event_attendance.dart';
import 'package:iespik_attendance_station/app/attendance/domain/entities/attendance/church_event_attendance.dart';
import 'package:iespik_attendance_station/app/attendance/domain/entities/events/church_event.dart';
import 'package:iespik_attendance_station/app/attendance/domain/entities/events/church_event_schedule.dart';
import 'package:iespik_attendance_station/commons/auth.dart';
import 'package:iespik_attendance_station/commons/response.dart';

class AttendanceService {
  final String attendanceServiceUrl = 'https://api.brightfellow.net/attendance';

  Future<List<ChurchEventSchedule>> listSchedules(
      {int limit = 0, String lastId = ""}) async {
    final token = await getToken();
    final response = await get(
      Uri.parse('$attendanceServiceUrl/schedules?limit=$limit&lastId=$lastId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    Map<String, dynamic> x = jsonDecode(response.body) as Map<String, dynamic>;

    APIResponse<List<ChurchEventSchedule>> apiResponse =
        APIResponse<List<ChurchEventSchedule>>.fromJsonList(x,
            (List<Map<String, dynamic>> list) {
      return list.map(ChurchEventSchedule.fromJson).toList();
    });

    if (apiResponse.isError()) {
      throw apiResponse.error!;
    }

    if (apiResponse.data == null) {
      throw Exception('No data returned');
    }

    return apiResponse.data!;
  }

  Future<ChurchEvent> getEvent(
      {required String scheduleId, required String eventId}) async {
    final token = await getToken();
    final response = await get(
      Uri.parse('$attendanceServiceUrl/schedules/$scheduleId/events/$eventId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );

    Map<String, dynamic> x = jsonDecode(response.body) as Map<String, dynamic>;

    APIResponse<ChurchEvent> apiResponse =
        APIResponse<ChurchEvent>.fromJson(x, ChurchEvent.fromJson);
    if (apiResponse.isError()) {
      throw apiResponse.error!;
    }

    if (apiResponse.data == null) {
      throw Exception('No data returned');
    }

    return apiResponse.data!;
  }

  Future<List<ChurchEventAttendance>> checkin(
      {required String scheduleId,
      required String eventId,
      required List<AttendeeData> data,
      required String checkinBy}) async {
    final token = await getToken();
    final response = await post(
      Uri.parse('$attendanceServiceUrl/schedules/$scheduleId/events/$eventId'),
      body: {
        "eventId": eventId,
        "checkinBy": checkinBy,
        "attendeeData": jsonEncode(data),
      },
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );

    Map<String, dynamic> x = jsonDecode(response.body) as Map<String, dynamic>;

    APIResponse<List<ChurchEventAttendance>> apiResponse =
        APIResponse<List<ChurchEventAttendance>>.fromJsonList(x, (list) {
      return list
          .map((toElement) => ChurchEventAttendance.fromJson(toElement))
          .toList();
    });
    if (apiResponse.isError()) {
      throw apiResponse.error!;
    }

    if (apiResponse.data == null) {
      throw Exception('No data returned');
    }

    return apiResponse.data!;
  }
}
