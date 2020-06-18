import 'dart:core';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'GuidePageV1.dart';

class GuideV1 implements IStringIdentifiable {
  /* Identification */
  @override
  String id;
  String name;
  String type;
  String app;
  int min_ver;
  int max_ver;

  /* Automatically managed fields */
  DateTime create_time;

  /* Content */
  List<GuidePageV1> pages;

  /* Search */
  List<String> tags;
  List<String> all_tags;

  /* Status */
  String status;

  /* Custom fields */
  dynamic custom_hdr;
  dynamic custom_dat;

  GuideV1({String id,
    String name,
    String type,
    String app,
    int min_ver,
    int max_ver,
    DateTime create_time,
    List<GuidePageV1> pages,
    List<String> tags,
    List<String> all_tags,
    String status,
    dynamic custom_hdr,
    dynamic custom_dat
  })
      :
        id = id,
        name = name,
        type = type,
        app = app,
        min_ver = min_ver,
        max_ver = max_ver,
        create_time = create_time,
        pages = pages,
        tags = tags,
        all_tags = all_tags,
        status = status,
        custom_hdr = custom_hdr,
        custom_dat = custom_dat;

  void fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    app = json['app'];
    min_ver = json['min_ver'];
    max_ver = json['max_ver'];
    create_time = json['create_time']==null? null: DateTime.tryParse(json['create_time']);
    pages = json['pages'];
    tags = json['tags']?.cast<String>();
    all_tags = json['all_tags']?.cast<String>();
    status = json['status'];
    custom_hdr = json['custom_hdr'];
    custom_dat = json['custom_dat'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': type,
      'app': app,
      'min_ver': min_ver,
      'max_ver': max_ver,
      'create_time': create_time?.toIso8601String(),
      'pages': pages,
      'tags': tags,
      'all_tags': all_tags,
      'status': status,
      'custom_hdr': custom_hdr,
      'custom_dat': custom_dat
    };
  }
}