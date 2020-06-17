import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'GuidePageV1Schema.dart';

class GuideV1Schema extends ObjectSchema {
  GuideV1Schema() : super() {
    /* Identification */
    withOptionalProperty('id', TypeCode.String);
    withRequiredProperty('type', TypeCode.String);
    withOptionalProperty('app', TypeCode.String);
    withOptionalProperty('name', TypeCode.String);
    withOptionalProperty('min_ver', TypeCode.Integer);
    withOptionalProperty('max_ver', TypeCode.Integer);

    /* Generic request properties */
    withOptionalProperty('create_time', null); //TypeCode.DateTime);

    /* Content */
    withOptionalProperty('pages', ArraySchema(GuidePageV1Schema()));

    /* Search */
    withOptionalProperty('tags', ArraySchema(TypeCode.String));
    withOptionalProperty('all_tags', ArraySchema(TypeCode.String));

    /* Status */
    withOptionalProperty('status', TypeCode.String);

    /* Custom fields */
    withOptionalProperty('custom_hdr', null);
    withOptionalProperty('custom_dat', null);
  }
}