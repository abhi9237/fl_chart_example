// To parse this JSON data, do
//
//     final addPainTrackerModal = addPainTrackerModalFromMap(jsonString);

import 'dart:convert';
import '../../common/pain_tracker_model.dart';

AddPainTrackerModal addPainTrackerModalFromMap(String str) =>
    AddPainTrackerModal.fromMap(json.decode(str));

String addPainTrackerModalToMap(AddPainTrackerModal data) =>
    json.encode(data.toMap());

class AddPainTrackerModal {
  String? message;
  int? status;
  bool? success;
  Datum? data;

  AddPainTrackerModal({
    this.message,
    this.status,
    this.success,
    this.data,
  });

  AddPainTrackerModal copyWith({
    String? message,
    int? status,
    bool? success,
    Datum? data,
  }) =>
      AddPainTrackerModal(
        message: message ?? this.message,
        status: status ?? this.status,
        success: success ?? this.success,
        data: data ?? this.data,
      );

  factory AddPainTrackerModal.fromMap(Map<String, dynamic> json) =>
      AddPainTrackerModal(
        message: json["message"],
        status: json["status"],
        success: json["success"],
        data: json["data"] == null ? null : Datum.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "status": status,
        "success": success,
        "data": data?.toMap(),
      };
}

// class Data {
//   int? userId;
//   int? pain;
//   int? activity;
//   DateTime? datetime;
//   int? energy;
//   int? mood;
//   int? sleep;
//   int? id;
//
//   Data({
//     this.userId,
//     this.pain,
//     this.activity,
//     this.datetime,
//     this.energy,
//     this.mood,
//     this.sleep,
//     this.id,
//   });
//
//   Data copyWith({
//     int? userId,
//     int? pain,
//     int? activity,
//     DateTime? datetime,
//     int? energy,
//     int? mood,
//     int? sleep,
//     int? id,
//   }) =>
//       Data(
//         userId: userId ?? this.userId,
//         pain: pain ?? this.pain,
//         activity: activity ?? this.activity,
//         datetime: datetime ?? this.datetime,
//         energy: energy ?? this.energy,
//         mood: mood ?? this.mood,
//         sleep: sleep ?? this.sleep,
//         id: id ?? this.id,
//       );
//
//   factory Data.fromMap(Map<String, dynamic> json) => Data(
//         userId: json["user_id"],
//         pain: json["pain"],
//         activity: json["activity"],
//         datetime:
//             json["datetime"] == null ? null : DateTime.parse(json["datetime"]),
//         energy: json["energy"],
//         mood: json["mood"],
//         sleep: json["sleep"],
//         id: json["id"],
//       );
//
//   Map<String, dynamic> toMap() => {
//         "user_id": userId,
//         "pain": pain,
//         "activity": activity,
//         "datetime":
//             "${datetime!.year.toString().padLeft(4, '0')}-${datetime!.month.toString().padLeft(2, '0')}-${datetime!.day.toString().padLeft(2, '0')}",
//         "energy": energy,
//         "mood": mood,
//         "sleep": sleep,
//         "id": id,
//       };
// }
