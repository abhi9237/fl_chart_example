// // To parse this JSON data, do
// //
// //     final getPainTrackerModal = getPainTrackerModalFromMap(jsonString);
//
// import 'dart:convert';
//
// import 'package:soma_app/features/playlist/modal/get_category_modal.dart';
//
// GetPainTrackerModal getPainTrackerModalFromMap(String str) =>
//     GetPainTrackerModal.fromMap(json.decode(str));
//
// String getPainTrackerModalToMap(GetPainTrackerModal data) =>
//     json.encode(data.toMap());
//
// class GetPainTrackerModal {
//   bool? success;
//   String? message;
//   List<PainTrackerData>? data;
//   List<PainVideo>? vadios;
//   int? status;
//
//   GetPainTrackerModal({
//     this.success,
//     this.message,
//     this.data,
//     this.vadios,
//     this.status,
//   });
//
//   GetPainTrackerModal copyWith({
//     bool? success,
//     String? message,
//     List<PainTrackerData>? data,
//     List<PainVideo>? vadios,
//     int? status,
//   }) =>
//       GetPainTrackerModal(
//         success: success ?? this.success,
//         message: message ?? this.message,
//         data: data ?? this.data,
//         vadios: vadios ?? this.vadios,
//         status: status ?? this.status,
//       );
//
//   factory GetPainTrackerModal.fromMap(Map<String, dynamic> json) =>
//       GetPainTrackerModal(
//         success: json["success"],
//         message: json["message"],
//         data: json["data"] == null
//             ? []
//             : List<PainTrackerData>.from(
//                 json["data"]!.map((x) => PainTrackerData.fromMap(x))),
//         vadios: json["vadios"] == null
//             ? []
//             : List<PainVideo>.from(
//                 json["vadios"]!.map((x) => PainVideo.fromMap(x))),
//         status: json["status"],
//       );
//
//   Map<String, dynamic> toMap() => {
//         "success": success,
//         "message": message,
//         "data":
//             data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
//         "vadios": vadios == null
//             ? []
//             : List<dynamic>.from(vadios!.map((x) => x.toMap())),
//         "status": status,
//       };
// }
//
// class PainVideo {
//   int? id;
//   int? categoryId;
//   String? title;
//   String? fileName;
//   String? thumbnail;
//   String? planType;
//   String? duration;
//   String? status;
//   dynamic deletedAt;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String? fileType;
//   bool? isFavorite;
//   int? favoriteCount;
//   PainVideo? category;
//
//   PainVideo({
//     this.id,
//     this.categoryId,
//     this.title,
//     this.fileName,
//     this.thumbnail,
//     this.planType,
//     this.duration,
//     this.status,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//     this.fileType,
//     this.isFavorite,
//     this.favoriteCount,
//     this.category,
//   });
//
//   PainVideo copyWith({
//     int? id,
//     int? categoryId,
//     String? title,
//     String? fileName,
//     String? thumbnail,
//     String? planType,
//     String? duration,
//     String? status,
//     dynamic deletedAt,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//     String? fileType,
//     bool? isFavorite,
//     int? favoriteCount,
//     PainVideo? category,
//   }) =>
//       PainVideo(
//         id: id ?? this.id,
//         categoryId: categoryId ?? this.categoryId,
//         title: title ?? this.title,
//         fileName: fileName ?? this.fileName,
//         thumbnail: thumbnail ?? this.thumbnail,
//         planType: planType ?? this.planType,
//         duration: duration ?? this.duration,
//         status: status ?? this.status,
//         deletedAt: deletedAt ?? this.deletedAt,
//         createdAt: createdAt ?? this.createdAt,
//         updatedAt: updatedAt ?? this.updatedAt,
//         fileType: fileType ?? this.fileType,
//         isFavorite: isFavorite ?? this.isFavorite,
//         favoriteCount: favoriteCount ?? this.favoriteCount,
//         category: category ?? this.category,
//       );
//
//   factory PainVideo.fromMap(Map<String, dynamic> json) => PainVideo(
//         id: json["id"],
//         categoryId: json["category_id"],
//         title: json["title"],
//         fileName: json["file_name"],
//         thumbnail: json["thumbnail"],
//         planType: json["plan_type"],
//         duration: json["duration"],
//         status: json["status"],
//         deletedAt: json["deleted_at"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         fileType: json["file_type"],
//         isFavorite: json["is_favorite"],
//         favoriteCount: json["favorite_count"],
//         category: json["category"] == null
//             ? null
//             : PainVideo.fromMap(json["category"]),
//       );
//
//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "category_id": categoryId,
//         "title": title,
//         "file_name": fileName,
//         "thumbnail": thumbnail,
//         "plan_type": planType,
//         "duration": duration,
//         "status": status,
//         "deleted_at": deletedAt,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "file_type": fileType,
//         "is_favorite": isFavorite,
//         "favorite_count": favoriteCount,
//         "category": category?.toMap(),
//       };
// }
//
// class PainTrackerData {
//   int? id;
//   String? title;
//   String? status;
//   dynamic userId;
//   String? totalDuration;
//   bool? isLike;
//   int? likeCount;
//   dynamic images;
//   List<Video>? videos;
//
//   PainTrackerData({
//     this.id,
//     this.title,
//     this.status,
//     this.userId,
//     this.totalDuration,
//     this.isLike,
//     this.likeCount,
//     this.images,
//     this.videos,
//   });
//
//   PainTrackerData copyWith({
//     int? id,
//     String? title,
//     String? status,
//     dynamic userId,
//     String? totalDuration,
//     bool? isLike,
//     int? likeCount,
//     dynamic images,
//     List<Video>? videos,
//   }) =>
//       PainTrackerData(
//         id: id ?? this.id,
//         title: title ?? this.title,
//         status: status ?? this.status,
//         userId: userId ?? this.userId,
//         totalDuration: totalDuration ?? this.totalDuration,
//         isLike: isLike ?? this.isLike,
//         likeCount: likeCount ?? this.likeCount,
//         images: images ?? this.images,
//         videos: videos ?? this.videos,
//       );
//
//   factory PainTrackerData.fromMap(Map<String, dynamic> json) => PainTrackerData(
//         id: json["id"],
//         title: json["title"],
//         status: json["status"],
//         userId: json["user_id"],
//         totalDuration: json["total_duration"],
//         isLike: json["is_like"],
//         likeCount: json["like_count"],
//         images: json["images"],
//         videos: json["videos"] == null
//             ? []
//             : List<Video>.from(json["videos"]!.map((x) => Video.fromMap(x))),
//       );
//
//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "title": title,
//         "status": status,
//         "user_id": userId,
//         "total_duration": totalDuration,
//         "is_like": isLike,
//         "like_count": likeCount,
//         "images": images,
//         "videos": videos == null
//             ? []
//             : List<dynamic>.from(videos!.map((x) => x.toMap())),
//       };
// }
