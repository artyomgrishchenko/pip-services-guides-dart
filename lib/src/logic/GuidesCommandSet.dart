import 'package:pip_services3_commons/pip_services3_commons.dart';

import '../../src/data/version1/GuideV1Schema.dart';
import '../../src/logic/IGuidesController.dart';
import '../../src/data/version1/GuideV1.dart';

class GuidesCommandSet extends CommandSet {
  IGuidesController _controller;

  GuidesCommandSet(IGuidesController controller) : super() {
    _controller = controller;

    addCommand(_makeGetGuidesCommand());
    addCommand(_makeGetRandomGuideCommand());
    addCommand(_makeGetGuideByIdCommand());
    addCommand(_makeCreateGuideCommand());
    addCommand(_makeUpdateGuideCommand());
    addCommand(_makeDeleteGuideByIdCommand());
  }

  ICommand _makeGetGuidesCommand() {
    return Command(
        'get_guides',
        ObjectSchema(true)
            .withOptionalProperty('filter', FilterParamsSchema())
            .withOptionalProperty('paging', PagingParamsSchema()),
        (String correlationId, Parameters args) {
      var filter = FilterParams.fromValue(args.get('filter'));
      var paging = PagingParams.fromValue(args.get('paging'));
      return _controller.getGuides(correlationId, filter, paging);
    });
  }

  ICommand _makeGetRandomGuideCommand() {
    return Command(
        'get_guides',
        ObjectSchema(true)
            .withOptionalProperty('filter', FilterParamsSchema()),
            (String correlationId, Parameters args) {
          var filter = FilterParams.fromValue(args.get('filter'));
          return _controller.getRandomGuide(correlationId, filter);
        });
  }

  ICommand _makeGetGuideByIdCommand() {
    return Command('get_guide_by_id',
        ObjectSchema(true).withRequiredProperty('guide_id', TypeCode.String),
        (String correlationId, Parameters args) {
      var guideId = args.getAsString('guide_id');
      return _controller.getGuideById(correlationId, guideId);
    });
  }

  ICommand _makeCreateGuideCommand() {
    return Command('create_guide',
        ObjectSchema(true).withRequiredProperty('guide', GuideV1Schema()),
        (String correlationId, Parameters args) {
      var guide = GuideV1();
      guide.fromJson(args.get('guide'));
      return _controller.createGuide(correlationId, guide);
    });
  }

  ICommand _makeUpdateGuideCommand() {
    return Command('update_guide',
        ObjectSchema(true).withRequiredProperty('guide', GuideV1Schema()),
        (String correlationId, Parameters args) {
      var guide = GuideV1();
      guide.fromJson(args.get('guide'));
      return _controller.updateGuide(correlationId, guide);
    });
  }

  ICommand _makeDeleteGuideByIdCommand() {
    return Command('delete_guide_by_id',
        ObjectSchema(true).withRequiredProperty('guide_id', TypeCode.String),
        (String correlationId, Parameters args) {
      var guideId = args.getAsString('guide_id');
      return _controller.deleteGuideById(correlationId, guideId);
    });
  }
}
