import 'dart:async';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import '../data/version1/GuideV1.dart';

abstract class IGuidesPersistence {
  Future<DataPage<GuideV1>> getPageByFilter(String correlationId,
      FilterParams filter, PagingParams paging);

  Future<GuideV1> getOneById(String correlationId, String id);

  Future<GuideV1> getRandom(String correlationId, FilterParams filter);

  Future<GuideV1> create(String correlationId, GuideV1 item);

  Future<GuideV1> update(String correlationId, GuideV1 item);

  Future<GuideV1> deleteById(String correlationId, String id);
}