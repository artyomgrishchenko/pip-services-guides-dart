import 'dart:async';

import 'package:pip_services3_commons/pip_services3_commons.dart';

import '../../src/data/version1/GuideV1.dart';
import '../../src/persistence/IGuidesPersistence.dart';
import './IGuidesController.dart';
import './GuidesCommandSet.dart';

class GuidesController
    implements IGuidesController, IConfigurable, IReferenceable, ICommandable {
  static final ConfigParams _defaultConfig = ConfigParams.fromTuples(
      ['dependencies.persistence', 'pip-services-guides:persistence:*:*:1.0']
  );
  IGuidesPersistence persistence;
  GuidesCommandSet commandSet;
  DependencyResolver dependencyResolver = DependencyResolver(
      GuidesController._defaultConfig);

  @override
  void configure(ConfigParams config) {
    dependencyResolver.configure(config);
  }

  @override
  void setReferences(IReferences references) {
    dependencyResolver.setReferences(references);
    persistence =
        dependencyResolver.getOneRequired<IGuidesPersistence>('persistence');
  }

  @override
  CommandSet getCommandSet() {
    commandSet ??= GuidesCommandSet(this);
    return commandSet;
  }

  @override
  Future<DataPage<GuideV1>> getGuides(String correlationId, FilterParams filter,
      PagingParams paging) =>
      persistence.getPageByFilter(correlationId, filter, paging);

  @override
  Future<GuideV1> getGuideById(String correlationId, String guideId) =>
      persistence.getOneById(correlationId, guideId);

  @override
  Future<GuideV1> createGuide(String correlationId, GuideV1 guide) {
    guide.id = guide.id ?? IdGenerator.nextLong();
    return persistence.create(correlationId, guide);
  }

  @override
  Future<GuideV1> updateGuide(String correlationId, GuideV1 guide) =>
      persistence.update(correlationId, guide);

  @override
  Future<GuideV1> deleteGuideById(String correlationId, String guideId) =>
      persistence.deleteById(correlationId, guideId);

  @override
  Future<GuideV1> getRandomGuide(String correlationId, FilterParams filter) =>
      persistence.getRandom(correlationId, filter);
}
