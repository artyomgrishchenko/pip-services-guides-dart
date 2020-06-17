import 'dart:async';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_data/pip_services3_data.dart';
import '../data/version1/GuideV1.dart';
import './IGuidesPersistence.dart';

class GuidesMemoryPersistence
    extends IdentifiableMemoryPersistence<GuideV1, String>
    implements IGuidesPersistence {
  GuidesMemoryPersistence() : super() {
    maxPageSize = 1000;
  }

  bool contains(List<String> array1, List<String> array2) {
    if (array1 == null || array2 == null) return false;

    for (var i1 = 0; i1 < array1.length; i1++) {
      for (var i2 = 0; i2 < array2.length; i2++) {
        if (array1[i1] == array2[i2]) {
          return true;
        }
      }
    }

    return false;
  }

  Function composeFilter(FilterParams filter) {
    filter = filter ?? FilterParams();

    var id = filter.getAsNullableString('id');
    var type = filter.getAsNullableString('type');
    var app = filter.getAsNullableString('app');
    var name = filter.getAsNullableString('name');
    var status = filter.getAsNullableString('status');
    var tagsString = filter.get('tags');
    var tags = tagsString != null
        ? TagsProcessor.compressTags([tagsString])
        : null;


    return (item) {
      if (id != null && id != item.id) {
        return false;
      }
      if (type != null && type != item.type) {
        return false;
      }
      if (app != null && app != item.app) {
        return false;
      }
      if (name != null && name != item.name) {
        return false;
      }
      if (status != null && status != item.status) {
        return false;
      }
      if (tags != null && !contains(item.all_tags, tags)) {
        return false;
      }
      return true;
    };
  }

  @override
  Future<DataPage<GuideV1>> getPageByFilter(String correlationId,
      FilterParams filter, PagingParams paging) async =>
      super
          .getPageByFilterEx(correlationId, composeFilter(filter), paging, null);

  @override
  Future<GuideV1> getRandom(String correlationId, FilterParams filter) async =>
      super.getOneRandom(correlationId, composeFilter(filter));
}
