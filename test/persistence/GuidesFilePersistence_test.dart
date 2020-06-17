import 'package:test/test.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';

import 'package:pip_services_guides_dart/pip_services_guides_dart.dart';
import './GuidesPersistenceFixture.dart';

void main() {
  group('GuidesFilePersistence', () {
    GuidesFilePersistence persistence;
    GuidesPersistenceFixture fixture;

    setUp(() async {
      persistence = GuidesFilePersistence('data/guides.test.json');
      persistence.configure(ConfigParams());

      fixture = GuidesPersistenceFixture(persistence);

      await persistence.open(null);
      await persistence.clear(null);
    });

    tearDown(() async {
      await persistence.close(null);
    });

    test('CRUD Operations', () async {
      await fixture.testCrudOperations();
    });

    test('Get with Filters', () async {
      await fixture.testGetWithFilters();
    });
  });
}
