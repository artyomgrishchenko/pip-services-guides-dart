import 'package:pip_services3_commons/pip_services3_commons.dart';

class GuidePageV1Schema extends ObjectSchema {
  GuidePageV1Schema() : super() {
    withRequiredProperty('title', TypeCode.Map);
    withOptionalProperty('content', TypeCode.Map);
    withOptionalProperty('more_url', TypeCode.String);
    withOptionalProperty('color', TypeCode.String);
    withOptionalProperty('pic_id', TypeCode.String);
    withOptionalProperty('pic_uri', TypeCode.String);
  }
}