import 'dart:core';

import 'package:pip_services3_commons/pip_services3_commons.dart';

class GuidePageV1 {

  MultiString title;
  MultiString content;
  String more_url;
  String color;
  String pic_id;
  String pic_uri;

  GuidePageV1({
    MultiString title,
    MultiString content,
    String more_url,
    String color,
    String pic_id,
    String pic_uri,
  })
      :
        title = title,
        content = content,
        more_url = more_url,
        color = color,
        pic_id = pic_id,
        pic_uri = pic_uri
  ;

  void fromJson(Map<String, dynamic> json) {
    title = MultiString.fromJson(json['title']);
    content = MultiString.fromJson(json['content']);
    more_url = json['more_url'];
    color = json['color'];
    pic_id = json['pic_id'];
    pic_uri = json['pic_uri'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'content': content,
      'more_url': more_url,
      'color': color,
      'pic_id': pic_id,
      'pic_uri': pic_uri
    };
  }
}