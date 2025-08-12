import 'package:cloud_firestore/cloud_firestore.dart';

class Items
{
  String? activityID;
  String? itemID;
  String? itemInfo;
  String? itemTitle;
  String? longDescription;
  String? price;
  Timestamp? publishedDate;
  String? name;
  String? bizUID;
  String? status;
  String? thumbnailUrl;

  Items({
    this.activityID,
    this.itemID,
    this.itemInfo,
    this.itemTitle,
    this.longDescription,
    this.price,
    this.publishedDate,
    this.name,
    this.bizUID,
    this.status,
    this.thumbnailUrl,
  });

  Items.fromJson(Map<String, dynamic> json)
  {
    activityID = json["activityID"];
    itemID = json["itemID"];
    itemInfo = json["itemInfo"];
    itemTitle = json["itemTitle"];
    longDescription = json["longDescription"];
    price = json["price"];
    publishedDate = json["publishedDate"];
    name = json["name"];
    bizUID = json["bizUID"];
    status = json["status"];
    thumbnailUrl = json["thumbnailUrl"];
  }
}