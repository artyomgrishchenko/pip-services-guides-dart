import 'package:pip_services_guides_dart/src/data/version1/GuideStatusV1.dart';
import 'package:test/test.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';

import 'package:pip_services_guides_dart/pip_services_guides_dart.dart';

final GUIDE1 = GuideV1(
    id: '1',
    name: 'Name1',
    type: 'introduction',
    app: 'Test App 1',
    max_ver: null,
    min_ver: null,
    status: GuideStatusV1.New
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
    status: GuideStatusV1.New
);
final GUIDE3 = GuideV1(
    id: '3',
    name: 'Name3',
    tags: ['Tag 1', 'tag 2'],
    all_tags: ['tag1', 'tag2'],
    type: 'new release',
    app: 'Test App 2',
    max_ver: 1,
    min_ver: 3,
    status: GuideStatusV1.Translating
);

class GuidesPersistenceFixture {
  IGuidesPersistence _persistence;

  GuidesPersistenceFixture(IGuidesPersistence persistence) {
    expect(persistence, isNotNull);
    _persistence = persistence;
  }

  void _testCreateGuides() async {
    // Create the first guide
    var guide = await _persistence.create(null, GUIDE1);

    expect(guide, isNotNull);
    expect(guide.status, 'new');
    expect(guide.type, GUIDE1.type);
    // Create the second guide
    guide = await _persistence.create(null, GUIDE2);
    expect(guide, isNotNull);
    expect(guide.status, 'new');
    expect(guide.type, GUIDE2.type);

    // Create the third guide
    guide = await _persistence.create(null, GUIDE3);
    expect(guide, isNotNull);
    expect(guide.status, GUIDE3.status);
    expect(guide.type, GUIDE3.type);
  }

void testCrudOperations() async {
    GuideV1 guide1;

    // Create items
    await _testCreateGuides();

    // Get all guides
    var page = await _persistence.getPageByFilter(
        null, FilterParams(), PagingParams());
    expect(page, isNotNull);
    expect(page.data.length, 3);

    guide1 = page.data[0];

    // Update the guide
    guide1.app = 'New App 1';

    var guide = await _persistence.update(null, guide1);
    expect(guide, isNotNull);
    expect(guide1.id, guide.id);
    expect(guide.app, 'New App 1');
    expect(guide.type, guide1.type);

    // Delete the guide
    guide = await _persistence.deleteById(null, guide1.id);
    expect(guide, isNotNull);
    expect(guide1.id, guide.id);

    // Try to get deleted guide
    guide = await _persistence.getOneById(null, guide1.id);
    expect(guide, isNull);
  }

  void testGetWithFilters() async {
    // Create items
    await _testCreateGuides();

    // Filter by product
    var page = await _persistence.getPageByFilter(
        null, FilterParams.fromValue({'product': 'Product 1'}), PagingParams());
    expect(page.data.length, 2);

    // Filter by search
    page = await _persistence.getPageByFilter(
        null, FilterParams.fromValue({'search': '1'}), PagingParams());
    expect(page.data.length, 2);
  }    

}