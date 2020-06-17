import 'dart:async';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import '../../src/data/version1/GuideV1.dart';

abstract class IGuidesController {
  Future<DataPage<GuideV1>> getGuides(
      String correlationId, FilterParams filter, PagingParams paging);

  Future<GuideV1> getRandomGuide(String correlationId, FilterParams filter);

  Future<GuideV1> getGuideById(String correlationId, String guideId);

  Future<GuideV1> createGuide(String correlationId, GuideV1 guide);

  Future<GuideV1> updateGuide(String correlationId, GuideV1 guide);

  Future<GuideV1> deleteGuideById(String correlationId, String guideId);
}