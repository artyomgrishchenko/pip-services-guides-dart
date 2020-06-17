import 'package:pip_services3_components/pip_services3_components.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';

import '../persistence/GuidesMemoryPersistence.dart';
import '../persistence/GuidesFilePersistence.dart';
import '../persistence/GuidesMongoDbPersistence.dart';
import '../logic/GuidesController.dart';
import '../services/version1/GuidesHttpServiceV1.dart';

class GuidesServiceFactory extends Factory {
  static final MemoryPersistenceDescriptor = Descriptor(
      'pip-services-guides', 'persistence', 'memory', '*', '1.0');
  static final FilePersistenceDescriptor = Descriptor(
      'pip-services-guides', 'persistence', 'file', '*', '1.0');
  static final MongoDbPersistenceDescriptor = Descriptor(
      'pip-services-guides', 'persistence', 'mongodb', '*', '1.0');
  static final ControllerDescriptor = Descriptor(
      'pip-services-guides', 'controller', 'default', '*', '1.0');
  static final HttpServiceDescriptor = Descriptor(
      'pip-services-guides', 'service', 'http', '*', '1.0');

  GuidesServiceFactory() : super() {
    registerAsType(GuidesServiceFactory.MemoryPersistenceDescriptor,
        GuidesMemoryPersistence);
    registerAsType(GuidesServiceFactory.FilePersistenceDescriptor,
        GuidesFilePersistence);
    registerAsType(GuidesServiceFactory.MongoDbPersistenceDescriptor,
        GuidesMongoDbPersistence);
    registerAsType(
        GuidesServiceFactory.ControllerDescriptor, GuidesController);
    registerAsType(GuidesServiceFactory.HttpServiceDescriptor,
        GuidesHttpServiceV1);
  }
}
