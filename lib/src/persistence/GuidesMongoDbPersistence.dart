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

    var id = filter.getAsNullableString('id');
    if (id != null) {
      criteria.add({'_id': id});
    }

    var type = filter.getAsNullableString('type');
    if (type != null) {
      criteria.add({'type': type});
    }

    var app = filter.getAsNullableString('app');
    if (app != null) {
      criteria.add({ 'app': app });
    }

    var name = filter.getAsNullableString('name');
    if (name != null) {
      criteria.add({ 'name': name });
    }

    var status = filter.getAsNullableString('status');
    if (status != null) {
      criteria.add({ 'status': status });
    }

    // Search by tags
    var tags = filter.getAsObject('tags');
    if (tags) {
      var searchTags = TagsProcessor.compressTags([tags]);
      criteria.add({ 'all_tags': { r'$in': searchTags } });
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
