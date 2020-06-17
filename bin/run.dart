import 'package:pip_services_guides_dart/pip_services_guides_dart.dart';

void main(List<String> argument) {
  try {
    var proc = GuidesProcess();
    proc.configPath = './config/config.yml';
    proc.run(argument);
  } catch (ex) {
    print(ex);
  }
}
