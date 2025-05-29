// To parse this JSON data, do
//
//     final getPainTrackerModal = getPainTrackerModalFromMap(jsonString);

import 'dart:convert';
import '../../common/pain_tracker_model.dart';

GetPainTrackerModal getPainTrackerModalFromMap(String str) =>
    GetPainTrackerModal.fromMap(json.decode(str));

String getPainTrackerModalToMap(GetPainTrackerModal data) =>
    json.encode(data.toMap());

class GetPainTrackerModal {
  String? message;
  int? status;
  bool? success;
  List<Datum>? data;

  GetPainTrackerModal({
    this.message,
    this.status,
    this.success,
    this.data,
  });

  GetPainTrackerModal copyWith({
    String? message,
    int? status,
    bool? success,
    List<Datum>? data,
  }) =>
      GetPainTrackerModal(
        message: message ?? this.message,
        status: status ?? this.status,
        success: success ?? this.success,
        data: data ?? this.data,
      );

  factory GetPainTrackerModal.fromMap(Map<String, dynamic> json) =>
      GetPainTrackerModal(
        message: json["message"],
        status: json["status"],
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "status": status,
        "success": success,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}


