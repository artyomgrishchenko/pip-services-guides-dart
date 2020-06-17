import 'package:pip_services3_rpc/pip_services3_rpc.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';

class GuidesHttpServiceV1 extends CommandableHttpService {
  GuidesHttpServiceV1() : super('v1/guides') {
    dependencyResolver.put(
        'controller', Descriptor('pip-services-guides', 'controller', '*', '*', '1.0'));
  }
}
