import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_split_view/src/area.dart';

void main() {
  group('Area', () {
    group('copyWith', () {
      test('flex and size', () {
        final Area area = Area(size: 2);
        expect(() {
          area.copyWith(size: () => 1, flex: () => 2);
        },
            throwsA(isA<ArgumentError>().having((e) => e.message, '',
                'Cannot provide both a size and a flex.',),),);
      });
      test('negative size', () {
        final Area area = Area(size: 2);
        expect(() {
          area.copyWith(size: () => -1);
        }, throwsA(isA<ArgumentError>().having((e) => e.name, '', 'size')),);
      });
      test('negative flex', () {
        final Area area = Area(flex: 2);
        expect(() {
          area.copyWith(flex: () => -1);
        }, throwsA(isA<ArgumentError>().having((e) => e.name, '', 'flex')),);
      });
      test('negative min', () {
        final Area area = Area();
        expect(() {
          area.copyWith(min: () => -1);
        }, throwsA(isA<ArgumentError>().having((e) => e.name, '', 'min')),);
      });
      test('negative max', () {
        final Area area = Area();
        expect(() {
          area.copyWith(max: () => -1);
        }, throwsA(isA<ArgumentError>().having((e) => e.name, '', 'max')),);
      });
      test('flex', () {
        Area area = Area();
        area = area.copyWith(flex: () => 2);
        expect(area.size, null);
        expect(area.flex, 2);
        expect(area.max, null);
        expect(area.min, null);
        expect(area.data, null);
      });
      test('size', () {
        Area area = Area(size: 2);
        area = area.copyWith(size: () => 3);
        expect(area.size, 3);
        expect(area.flex, null);
        expect(area.max, null);
        expect(area.min, null);
        expect(area.data, null);
      });
      test('flex - min', () {
        Area area = Area(flex: 3, min: 3);
        expect(area.flex, 3);
        expect(area.min, 3);

        area = area.copyWith(min: () => 1);
        expect(area.size, null);
        expect(area.flex, 3);
        expect(area.max, null);
        expect(area.min, 1);
        expect(area.data, null);
      });
      test('flex - max', () {
        Area area = Area(flex: 2, max: 2);
        expect(area.flex, 2);
        expect(area.max, 2);

        area = area.copyWith(max: () => 10);
        expect(area.size, null);
        expect(area.flex, 2);
        expect(area.max, 10);
        expect(area.min, null);
        expect(area.data, null);
      });
      test('size - min', () {
        Area area = Area(size: 3, min: 3);
        expect(area.size, 3);
        expect(area.min, 3);

        area = area.copyWith(min: () => 3);
        expect(area.size, 3);
        expect(area.flex, null);
        expect(area.max, null);
        expect(area.min, 3);
        expect(area.data, null);
      });
      test('size - max', () {
        Area area = Area(size: 2, max: 2);
        expect(area.size, 2);
        expect(area.max, 2);

        area = area.copyWith(max: () => 10);
        expect(area.size, 2);
        expect(area.flex, null);
        expect(area.max, 10);
        expect(area.min, null);
        expect(area.data, null);
      });
      test('flex to size', () {
        final Area area1 = Area(flex: 2);
        final Area area2 = area1.copyWith(flex: () => null, size: () => 10);
        expect(area1.size, null);
        expect(area1.flex, 2);
        expect(area1.max, null);
        expect(area1.min, null);
        expect(area1.data, null);
        expect(area2.size, 10);
        expect(area2.flex, null);
        expect(area2.max, null);
        expect(area2.min, null);
        expect(area2.data, null);
      });
      test('size to flex', () {
        final Area area1 = Area(size: 10);
        final Area area2 = area1.copyWith(flex: () => 2, size: () => null);
        expect(area1.size, 10);
        expect(area1.flex, null);
        expect(area1.max, null);
        expect(area1.min, null);
        expect(area1.data, null);
        expect(area2.size, null);
        expect(area2.flex, 2);
        expect(area2.max, null);
        expect(area2.min, null);
        expect(area2.data, null);
      });
      test('same id', () {
        final Area area1 = Area(id: 'id');
        final Area area2 = area1.copyWith(flex: () => 2);
        expect(area1.id, isNotNull);
        expect(area2.id, isNotNull);
        expect(area1.id, 'id');
        expect(area2.id, 'id');
        expect(area1.id == area2.id, true);
      });
      test('change id', () {
        final Area area1 = Area();
        final Area area2 = area1.copyWith(id: () => 'id');
        expect(area1.id, isNotNull);
        expect(area2.id, isNotNull);
        expect(area2.id, 'id');
        expect(area1.id == area2.id, false);
      });
      test('nullifying id', () {
        final Area area1 = Area(id: 'id');
        final Area area2 = area1.copyWith(id: () => null);
        expect(area1.id, isNotNull);
        expect(area1.id, 'id');
        // auto generated id
        expect(area2.id, isNotNull);
        expect(false, area1.id == area2.id);
      });
      test('nullifying flex', () {
        final Area area1 = Area(flex: 2);
        final Area area2 = area1.copyWith(flex: () => null);
        expect(area1.flex, 2);
        // default value
        expect(area2.flex, 1);
      });
      test('nullifying size', () {
        final Area area1 = Area(size: 2);
        final Area area2 = area1.copyWith(size: () => null);
        expect(area1.size, 2);
        expect(area1.flex, null);
        expect(area2.size, null);
        // default value
        expect(area2.flex, 1);
      });
      test('nullifying min', () {
        final Area area1 = Area(min: 1);
        final Area area2 = area1.copyWith(min: () => null);
        expect(area1.min, 1);
        expect(area2.min, null);
      });
      test('nullifying max', () {
        final Area area1 = Area(max: 1);
        final Area area2 = area1.copyWith(max: () => null);
        expect(area1.max, 1);
        expect(area2.max, null);
      });
      test('nullifying data', () {
        final Area area1 = Area(data: 'data');
        final Area area2 = area1.copyWith(data: () => null);
        expect(area1.data, 'data');
        expect(area2.data, null);
      });
      test('nullifying builder', () {
        Widget builder(BuildContext c, Area a) => Container();
        final Area area1 = Area(builder: builder);
        final Area area2 = area1.copyWith(builder: () => null);
        expect(area1.builder, builder);
        expect(area2.builder, null);
      });
    });
  });
}
