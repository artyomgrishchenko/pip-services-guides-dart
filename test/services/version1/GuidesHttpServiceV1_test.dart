import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services_guides_dart/pip_services_guides_dart.dart';

final GUIDE1 = GuideV1(
    id: '1',
    name: 'Name1',
    type: 'introduction',
    app: 'Test App 1',
    max_ver: null,
    min_ver: null,
    status: 'new'
);
final GUIDE2 = GuideV1(
    id: '2',
    name: 'Name2',
    tags: ['TAG 1'],
    all_tags: ['tag1'],
    type: 'new release',
    app: 'Test App 1',
    max_ver: 1,
    min_ver: 2,
    status: 'new'
);

var httpConfig = ConfigParams.fromTuples([
  'connection.protocol',
  'http',
  'connection.host',
  'localhost',
  'connection.port',
  3000
]);

void main() {
  group('GuidesHttpServiceV1', () {
    GuidesMemoryPersistence persistence;
    GuidesController controller;
    GuidesHttpServiceV1 service;
    http.Client rest;
    String url;

    setUp(() async {
      url = 'http://localhost:3000';
      rest = http.Client();

      persistence = GuidesMemoryPersistence();
      persistence.configure(ConfigParams());

      controller = GuidesController();
      controller.configure(ConfigParams());

      service = GuidesHttpServiceV1();
      service.configure(httpConfig);

      var references = References.fromTuples([
        Descriptor('pip-services-guides', 'persistence', 'memory', 'default', '1.0'),
        persistence,
        Descriptor('pip-services-guides', 'controller', 'default', 'default', '1.0'),
        controller,
        Descriptor('pip-services-guides', 'service', 'http', 'default', '1.0'),
        service
      ]);

      controller.setReferences(references);
      service.setReferences(references);

      await persistence.open(null);
      await service.open(null);
    });

    tearDown(() async {
      await service.close(null);
      await persistence.close(null);
    });

    test('CRUD Operations', () async {
      GuideV1 guide1;

      // Create the first guide
      var resp = await rest.post(url + '/v1/guides/create_guide',
          headers: {'Content-Type': 'guide/json'},
          body: json.encode({'guide': GUIDE1}));
      var guide = GuideV1();
      guide.fromJson(json.decode(resp.body));
      expect(guide, isNotNull);
      expect(guide.status, 'new');
      expect(guide.type, GUIDE1.type);

      // Create the second guide
      resp = await rest.post(url + '/v1/guides/create_guide',
          headers: {'Content-Type': 'guide/json'},
          body: json.encode({'guide': GUIDE2}));
      guide = GuideV1();
      guide.fromJson(json.decode(resp.body));
      expect(guide, isNotNull);
      expect(guide.status, 'new');
      expect(guide.type, GUIDE2.type);

      // Get all guides
      resp = await rest.post(url + '/v1/guides/get_guides',
          headers: {'Content-Type': 'guide/json'},
          body: json
              .encode({'filter': FilterParams(), 'paging': PagingParams()}));
      var page = DataPage<GuideV1>.fromJson(json.decode(resp.body), (item) {
        var guide = GuideV1();
        guide.fromJson(item);
        return guide;
      });
      expect(page, isNotNull);
      expect(page.data.length, 2);

      guide1 = page.data[0];

      // Update the guide
      guide1.app = 'New App 1';

      resp = await rest.post(url + '/v1/guides/update_guide',
          headers: {'Content-Type': 'guide/json'},
          body: json.encode({'guide': guide1}));
      guide = GuideV1();
      guide.fromJson(json.decode(resp.body));
      expect(guide, isNotNull);
      expect(guide.app, 'New App 1');
      expect(guide.type, guide1.type);

      // Delete the guide
      resp = await rest.post(url + '/v1/guides/delete_guide_by_id',
          headers: {'Content-Type': 'guide/json'},
          body: json.encode({'guide_id': guide1.id}));
      guide = GuideV1();
      guide.fromJson(json.decode(resp.body));
      expect(guide, isNotNull);
      expect(guide1.id, guide.id);

      // Try to get deleted guide
      resp = await rest.post(url + '/v1/guides/get_guide_by_id',
          headers: {'Content-Type': 'guide/json'},
          body: json.encode({'guide_id': guide1.id}));
      expect(resp.body, isEmpty);
    });
  });
}
