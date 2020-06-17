import 'dart:async';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_mongodb/pip_services3_mongodb.dart';

import '../data/version1/GuideV1.dart';
import './IGuidesPersistence.dart';

class GuidesMongoDbPersistence
    extends IdentifiableMongoDbPersistence<GuideV1, String>
    implements IGuidesPersistence {
  GuidesMongoDbPersistence() : super('guides') {
    maxPageSize = 1000;
  }

  dynamic composeFilter(FilterParams filter) {
    filter = filter ?? FilterParams();

    var criteria = [];

    var search = filter.getAsNullableString('search');
    if (search != null) {
      var searchRegex = RegExp(search, caseSensitive: false);
      var searchCriteria = [];
      searchCriteria.add({ 'id': { r'$regex': searchRegex.pattern } });
      searchCriteria.add({ 'product': { r'$regex': searchRegex.pattern } });
      searchCriteria.add({ 'copyrights': { r'$regex': searchRegex.pattern } });
      criteria.add({ r'$or': searchCriteria });
    }

    var id = filter.getAsNullableString('id');
    if (id != null) {
      criteria.add({'_id': id});
    }

    var product = filter.getAsNullableString('product');
    if (product != null) {
      criteria.add({'product': product});
    }

    var group = filter.getAsNullableString('group');
    if (group != null) {
      criteria.add({'group': group});
    }

    return criteria.isNotEmpty ? {r'$and': criteria} : null;
  }

  @override
  Future<DataPage<GuideV1>> getPageByFilter(
      String correlationId, FilterParams filter, PagingParams paging) async => super
        .getPageByFilterEx(correlationId, composeFilter(filter), paging, null);

  @override
  Future<GuideV1> getRandom(String correlationId, FilterParams filter) async => super
        .getOneRandom(correlationId, filter);
}
