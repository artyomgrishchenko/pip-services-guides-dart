import 'package:pip_services3_data/pip_services3_data.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import '../data/version1/GuideV1.dart';
import './GuidesMemoryPersistence.dart';

class GuidesFilePersistence extends GuidesMemoryPersistence {
  JsonFilePersister<GuideV1> persister;

  GuidesFilePersistence([String path]) : super() {
    persister = JsonFilePersister<GuideV1>(path);
    loader = persister;
    saver = persister;
  }
  @override
  void configure(ConfigParams config) {
    super.configure(config);
    persister.configure(config);
  }
}
