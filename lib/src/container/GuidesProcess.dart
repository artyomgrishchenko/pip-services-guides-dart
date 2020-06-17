import 'package:pip_services3_container/pip_services3_container.dart';
import 'package:pip_services3_rpc/pip_services3_rpc.dart';

import '../build/GuidesServiceFactory.dart';

class GuidesProcess extends ProcessContainer {
  GuidesProcess() : super('guides', 'Guides microservice') {
    factories.add(GuidesServiceFactory());
    factories.add(DefaultRpcFactory());
  }
}
