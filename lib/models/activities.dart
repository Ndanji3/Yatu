import 'package:cloud_firestore/cloud_firestore.dart';

class Activities
{
  String? activityID;
  String? activityInfo;
  String? activityTitle;
  Timestamp? publishedDate;
  String? bizUID;
  String? status;
  String? thumbnailUrl;

  Activities({
    this.activityID,
    this.activityInfo,
    this.activityTitle,
    this.publishedDate,
    this.bizUID,
    this.status,
    this.thumbnailUrl,
  });

  Activities.fromJson(Map<String, dynamic> json)
  {
    activityID = json["activityID"];
    activityInfo = json["activityInfo"];
    activityTitle = json["activityTitle"];
    publishedDate = json["publishedDate"];
    bizUID = json["bizUID"];
    status = json["status"];
    thumbnailUrl = json["thumbnailUrl"];
  }
}