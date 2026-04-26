import 'package:flutter_test/flutter_test.dart';
import 'package:multi_split_view/src/area.dart';
import 'package:multi_split_view/src/controller.dart';
import 'package:multi_split_view/src/internal/layout_constraints.dart';
import 'package:multi_split_view/src/policies.dart';

import 'test_helper.dart';

void main() {
  group('LayoutConstraints', () {
    group('Adjust areas', () {
      test('flex sum 0', () {
        MultiSplitViewController controller =
            MultiSplitViewController(areas: [Area(flex: 0, max: 2)]);
        expect(controller.areasCount, 1);
        LayoutConstraints layoutConstraints = LayoutConstraints(
            controller: controller,
            containerSize: 100,
            dividerThickness: 5,
            dividerHandleBuffer: 0,);
        layoutConstraints.adjustAreas(
            controllerHelper: ControllerHelper(controller),
            sizeOverflowPolicy: SizeOverflowPolicy.shrinkFirst,
            sizeUnderflowPolicy: SizeUnderflowPolicy.stretchLast,
            minSizeRecoveryPolicy: MinSizeRecoveryPolicy.firstToLast,);
        TestHelper.testArea(controller.getArea(0),
            data: null, flex: 1, size: null, min: null, max: null,);

        controller = MultiSplitViewController(
            areas: [Area(flex: 0, max: 2), Area(flex: 0)],);
        expect(controller.areasCount, 2);
        layoutConstraints = LayoutConstraints(
            controller: controller,
            containerSize: 100,
            dividerThickness: 5,
            dividerHandleBuffer: 0,);
        layoutConstraints.adjustAreas(
            controllerHelper: ControllerHelper(controller),
            sizeOverflowPolicy: SizeOverflowPolicy.shrinkFirst,
            sizeUnderflowPolicy: SizeUnderflowPolicy.stretchLast,
            minSizeRecoveryPolicy: MinSizeRecoveryPolicy.firstToLast,);
        TestHelper.testArea(controller.getArea(0),
            data: null, flex: 1, size: null, min: null, max: null,);
        TestHelper.testArea(controller.getArea(1),
            data: null, flex: 1, size: null, min: null, max: null,);

        controller = MultiSplitViewController(areas: [
          Area(size: 100, min: 50),
          Area(flex: 0, min: 0),
          Area(flex: 0, max: 2),
        ],);
        expect(controller.areasCount, 3);
        layoutConstraints = LayoutConstraints(
            controller: controller,
            containerSize: 100,
            dividerThickness: 0,
            dividerHandleBuffer: 0,);
        layoutConstraints.adjustAreas(
            controllerHelper: ControllerHelper(controller),
            sizeOverflowPolicy: SizeOverflowPolicy.shrinkFirst,
            sizeUnderflowPolicy: SizeUnderflowPolicy.stretchLast,
            minSizeRecoveryPolicy: MinSizeRecoveryPolicy.firstToLast,);
        TestHelper.testArea(controller.getArea(0),
            data: null, flex: null, size: 100, min: 50, max: null,);
        TestHelper.testArea(controller.getArea(1),
            data: null, flex: 1, size: null, min: null, max: null,);
        TestHelper.testArea(controller.getArea(2),
            data: null, flex: 1, size: null, min: null, max: null,);
      });
      test('empty', () {
        final MultiSplitViewController controller =
            MultiSplitViewController(areas: []);
        final LayoutConstraints layoutConstraints = LayoutConstraints(
            controller: controller,
            containerSize: 155,
            dividerThickness: 5,
            dividerHandleBuffer: 0,);
        layoutConstraints.adjustAreas(
            controllerHelper: ControllerHelper(controller),
            sizeOverflowPolicy: SizeOverflowPolicy.shrinkFirst,
            sizeUnderflowPolicy: SizeUnderflowPolicy.stretchLast,
            minSizeRecoveryPolicy: MinSizeRecoveryPolicy.firstToLast,);
        expect(controller.areas.length, 0);
        expect(layoutConstraints.flexCount, 0);
        expect(layoutConstraints.flexSum, 0);
      });
      test('same areas hash', () {
        final MultiSplitViewController controller = MultiSplitViewController(
            areas: [Area(data: 'a', size: 100), Area(data: 'b', size: 100)],);
        final ControllerHelper controllerHelper = ControllerHelper(controller);
        final Object oldAreasHash = controllerHelper.areasHash;
        final LayoutConstraints layoutConstraints = LayoutConstraints(
            controller: controller,
            containerSize: 205,
            dividerThickness: 5,
            dividerHandleBuffer: 0,);
        layoutConstraints.adjustAreas(
            controllerHelper: controllerHelper,
            sizeOverflowPolicy: SizeOverflowPolicy.shrinkFirst,
            sizeUnderflowPolicy: SizeUnderflowPolicy.stretchLast,
            minSizeRecoveryPolicy: MinSizeRecoveryPolicy.firstToLast,);
        expect(controller.areas.length, 2);
        TestHelper.testArea(controller.areas[0],
            data: 'a', min: null, max: null, flex: null, size: 100,);
        TestHelper.testArea(controller.areas[1],
            data: 'b', min: null, max: null, flex: null, size: 100,);
        expect(layoutConstraints.flexCount, 0);
        expect(layoutConstraints.flexSum, 0);
        expect(oldAreasHash, controllerHelper.areasHash);
      });
      test('containerSize - decimal value', () {
        final MultiSplitViewController controller = MultiSplitViewController(
            areas: [Area(data: 'a', size: 100), Area(data: 'b', size: 100)],);
        final ControllerHelper controllerHelper = ControllerHelper(controller);
        final Object oldAreasHash = controllerHelper.areasHash;
        final LayoutConstraints layoutConstraints = LayoutConstraints(
            controller: controller,
            containerSize: 204.999999999,
            dividerThickness: 5,
            dividerHandleBuffer: 0,);
        layoutConstraints.adjustAreas(
            controllerHelper: controllerHelper,
            sizeOverflowPolicy: SizeOverflowPolicy.shrinkFirst,
            sizeUnderflowPolicy: SizeUnderflowPolicy.stretchLast,
            minSizeRecoveryPolicy: MinSizeRecoveryPolicy.firstToLast,);
        expect(controller.areas.length, 2);
        TestHelper.testArea(controller.areas[0],
            data: 'a', min: null, max: null, flex: null, size: 100,);
        TestHelper.testArea(controller.areas[1],
            data: 'b', min: null, max: null, flex: null, size: 100,);
        expect(layoutConstraints.flexCount, 0);
        expect(layoutConstraints.flexSum, 0);
        expect(oldAreasHash, controllerHelper.areasHash);
      });
      test('containerSize - decimal value - 2', () {
        final MultiSplitViewController controller = MultiSplitViewController(
            areas: [Area(data: 'a', size: 100), Area(data: 'b', size: 100)],);
        final ControllerHelper controllerHelper = ControllerHelper(controller);
        final Object oldAreasHash = controllerHelper.areasHash;
        final LayoutConstraints layoutConstraints = LayoutConstraints(
            controller: controller,
            containerSize: 204.5,
            dividerThickness: 5,
            dividerHandleBuffer: 0,);
        layoutConstraints.adjustAreas(
            controllerHelper: controllerHelper,
            sizeOverflowPolicy: SizeOverflowPolicy.shrinkFirst,
            sizeUnderflowPolicy: SizeUnderflowPolicy.stretchLast,
            minSizeRecoveryPolicy: MinSizeRecoveryPolicy.firstToLast,);
        expect(controller.areas.length, 2);
        TestHelper.testArea(controller.areas[0],
            data: 'a', min: null, max: null, flex: null, size: 99.5,);
        TestHelper.testArea(controller.areas[1],
            data: 'b', min: null, max: null, flex: null, size: 100,);
        expect(layoutConstraints.flexCount, 0);
        expect(layoutConstraints.flexSum, 0);
        expect(oldAreasHash, isNot(equals(controllerHelper.areasHash)));
      });
      test('containerSize - decimal value - 3', () {
        final MultiSplitViewController controller = MultiSplitViewController(
            areas: [Area(data: 'a', size: 100), Area(data: 'b', size: 100)],);
        final ControllerHelper controllerHelper = ControllerHelper(controller);
        final Object oldAreasHash = controllerHelper.areasHash;
        final LayoutConstraints layoutConstraints = LayoutConstraints(
            controller: controller,
            containerSize: 205.000000001,
            dividerThickness: 5,
            dividerHandleBuffer: 0,);
        layoutConstraints.adjustAreas(
            controllerHelper: controllerHelper,
            sizeOverflowPolicy: SizeOverflowPolicy.shrinkFirst,
            sizeUnderflowPolicy: SizeUnderflowPolicy.stretchLast,
            minSizeRecoveryPolicy: MinSizeRecoveryPolicy.firstToLast,);
        expect(controller.areas.length, 2);
        TestHelper.testArea(controller.areas[0],
            data: 'a', min: null, max: null, flex: null, size: 100,);
        TestHelper.testArea(controller.areas[1],
            data: 'b', min: null, max: null, flex: null, size: 100,);
        expect(layoutConstraints.flexCount, 0);
        expect(layoutConstraints.flexSum, 0);
        expect(oldAreasHash, controllerHelper.areasHash);
      });
      test('containerSize - decimal value - 4', () {
        final MultiSplitViewController controller = MultiSplitViewController(
            areas: [Area(data: 'a', size: 100), Area(data: 'b', size: 100)],);
        final ControllerHelper controllerHelper = ControllerHelper(controller);
        final Object oldAreasHash = controllerHelper.areasHash;
        final LayoutConstraints layoutConstraints = LayoutConstraints(
            controller: controller,
            containerSize: 205.5,
            dividerThickness: 5,
            dividerHandleBuffer: 0,);
        layoutConstraints.adjustAreas(
            controllerHelper: controllerHelper,
            sizeOverflowPolicy: SizeOverflowPolicy.shrinkFirst,
            sizeUnderflowPolicy: SizeUnderflowPolicy.stretchLast,
            minSizeRecoveryPolicy: MinSizeRecoveryPolicy.firstToLast,);
        expect(controller.areas.length, 2);
        TestHelper.testArea(controller.areas[0],
            data: 'a', min: null, max: null, flex: null, size: 100,);
        TestHelper.testArea(controller.areas[1],
            data: 'b', min: null, max: null, flex: null, size: 100.5,);
        expect(layoutConstraints.flexCount, 0);
        expect(layoutConstraints.flexSum, 0);
        expect(oldAreasHash, isNot(equals(controllerHelper.areasHash)));
      });
      test('sizeOverflowPolicy - shrinkFirst', () {
        final MultiSplitViewController controller = MultiSplitViewController(
            areas: [Area(data: 'a', size: 100), Area(data: 'b', size: 100)],);
        final LayoutConstraints layoutConstraints = LayoutConstraints(
            controller: controller,
            containerSize: 155,
            dividerThickness: 5,
            dividerHandleBuffer: 0,);
        layoutConstraints.adjustAreas(
            controllerHelper: ControllerHelper(controller),
            sizeOverflowPolicy: SizeOverflowPolicy.shrinkFirst,
            sizeUnderflowPolicy: SizeUnderflowPolicy.stretchLast,
            minSizeRecoveryPolicy: MinSizeRecoveryPolicy.firstToLast,);
        expect(controller.areas.length, 2);
        TestHelper.testArea(controller.areas[0],
            data: 'a', min: null, max: null, flex: null, size: 50,);
        TestHelper.testArea(controller.areas[1],
            data: 'b', min: null, max: null, flex: null, size: 100,);
        expect(layoutConstraints.flexCount, 0);
        expect(layoutConstraints.flexSum, 0);
      });
      test('sizeOverflowPolicy - shrinkLast', () {
        final MultiSplitViewController controller = MultiSplitViewController(
            areas: [Area(data: 'a', size: 100), Area(data: 'b', size: 100)],);
        final LayoutConstraints layoutConstraints = LayoutConstraints(
            controller: controller,
            containerSize: 155,
            dividerThickness: 5,
            dividerHandleBuffer: 0,);
        layoutConstraints.adjustAreas(
            controllerHelper: ControllerHelper(controller),
            sizeOverflowPolicy: SizeOverflowPolicy.shrinkLast,
            sizeUnderflowPolicy: SizeUnderflowPolicy.stretchLast,
            minSizeRecoveryPolicy: MinSizeRecoveryPolicy.firstToLast,);
        expect(controller.areas.length, 2);
        TestHelper.testArea(controller.areas[0],
            data: 'a', min: null, max: null, flex: null, size: 100,);
        TestHelper.testArea(controller.areas[1],
            data: 'b', min: null, max: null, flex: null, size: 50,);
        expect(layoutConstraints.flexCount, 0);
        expect(layoutConstraints.flexSum, 0);
      });
      test('sizeOverflowPolicy - shrinkLast - min', () {
        final MultiSplitViewController controller = MultiSplitViewController(areas: [
          Area(data: 'a', size: 100),
          Area(data: 'b', size: 100, min: 90),
        ],);
        final LayoutConstraints layoutConstraints = LayoutConstraints(
            controller: controller,
            containerSize: 155,
            dividerThickness: 5,
            dividerHandleBuffer: 0,);
        layoutConstraints.adjustAreas(
            controllerHelper: ControllerHelper(controller),
            sizeOverflowPolicy: SizeOverflowPolicy.shrinkLast,
            sizeUnderflowPolicy: SizeUnderflowPolicy.stretchLast,
            minSizeRecoveryPolicy: MinSizeRecoveryPolicy.firstToLast,);
        expect(controller.areas.length, 2);
        TestHelper.testArea(controller.areas[0],
            data: 'a', min: null, max: null, flex: null, size: 100,);
        TestHelper.testArea(controller.areas[1],
            data: 'b', min: 90, max: null, flex: null, size: 50,);
        expect(layoutConstraints.flexCount, 0);
        expect(layoutConstraints.flexSum, 0);
      });
      test('sizeUnderflowPolicy - stretchFirst', () {
        final MultiSplitViewController controller = MultiSplitViewController(
            areas: [Area(data: 'a', size: 100), Area(data: 'b', size: 100)],);
        final LayoutConstraints layoutConstraints = LayoutConstraints(
            controller: controller,
            containerSize: 255,
            dividerThickness: 5,
            dividerHandleBuffer: 0,);
        layoutConstraints.adjustAreas(
            controllerHelper: ControllerHelper(controller),
            sizeOverflowPolicy: SizeOverflowPolicy.shrinkLast,
            sizeUnderflowPolicy: SizeUnderflowPolicy.stretchFirst,
            minSizeRecoveryPolicy: MinSizeRecoveryPolicy.firstToLast,);
        expect(controller.areas.length, 2);
        TestHelper.testArea(controller.areas[0],
            data: 'a', min: null, max: null, flex: null, size: 150,);
        TestHelper.testArea(controller.areas[1],
            data: 'b', min: null, max: null, flex: null, size: 100,);
        expect(layoutConstraints.flexCount, 0);
        expect(layoutConstraints.flexSum, 0);
      });
      test('sizeUnderflowPolicy - stretchLast', () {
        final MultiSplitViewController controller = MultiSplitViewController(
            areas: [Area(data: 'a', size: 100), Area(data: 'b', size: 100)],);
        final LayoutConstraints layoutConstraints = LayoutConstraints(
            controller: controller,
            containerSize: 255,
            dividerThickness: 5,
            dividerHandleBuffer: 0,);
        layoutConstraints.adjustAreas(
            controllerHelper: ControllerHelper(controller),
            sizeOverflowPolicy: SizeOverflowPolicy.shrinkLast,
            sizeUnderflowPolicy: SizeUnderflowPolicy.stretchLast,
            minSizeRecoveryPolicy: MinSizeRecoveryPolicy.firstToLast,);
        expect(controller.areas.length, 2);
        TestHelper.testArea(controller.areas[0],
            data: 'a', min: null, max: null, flex: null, size: 100,);
        TestHelper.testArea(controller.areas[1],
            data: 'b', min: null, max: null, flex: null, size: 150,);
        expect(layoutConstraints.flexCount, 0);
        expect(layoutConstraints.flexSum, 0);
      });
      test('sizeUnderflowPolicy - stretchLast - max', () {
        final MultiSplitViewController controller = MultiSplitViewController(areas: [
          Area(data: 'a', size: 100),
          Area(data: 'b', size: 100, max: 110),
        ],);
        final LayoutConstraints layoutConstraints = LayoutConstraints(
            controller: controller,
            containerSize: 255,
            dividerThickness: 5,
            dividerHandleBuffer: 0,);
        layoutConstraints.adjustAreas(
            controllerHelper: ControllerHelper(controller),
            sizeOverflowPolicy: SizeOverflowPolicy.shrinkLast,
            sizeUnderflowPolicy: SizeUnderflowPolicy.stretchLast,
            minSizeRecoveryPolicy: MinSizeRecoveryPolicy.firstToLast,);
        expect(controller.areas.length, 2);
        TestHelper.testArea(controller.areas[0],
            data: 'a', min: null, max: null, flex: null, size: 100,);
        TestHelper.testArea(controller.areas[1],
            data: 'b', min: null, max: 110, flex: null, size: 150,);
        expect(layoutConstraints.flexCount, 0);
        expect(layoutConstraints.flexSum, 0);
      });
      test('sizeUnderflowPolicy - stretchAll', () {
        final MultiSplitViewController controller = MultiSplitViewController(
            areas: [Area(data: 'a', size: 50), Area(data: 'b', size: 100)],);
        final LayoutConstraints layoutConstraints = LayoutConstraints(
            controller: controller,
            containerSize: 205,
            dividerThickness: 5,
            dividerHandleBuffer: 0,);
        layoutConstraints.adjustAreas(
            controllerHelper: ControllerHelper(controller),
            sizeOverflowPolicy: SizeOverflowPolicy.shrinkLast,
            sizeUnderflowPolicy: SizeUnderflowPolicy.stretchAll,
            minSizeRecoveryPolicy: MinSizeRecoveryPolicy.firstToLast,);
        expect(controller.areas.length, 2);
        TestHelper.testArea(controller.areas[0],
            data: 'a', min: null, max: null, flex: null, size: 75,);
        TestHelper.testArea(controller.areas[1],
            data: 'b', min: null, max: null, flex: null, size: 125,);
        expect(layoutConstraints.flexCount, 0);
        expect(layoutConstraints.flexSum, 0);
      });
      test('minSizeRecoveryPolicy - firstToLast', () {
        final MultiSplitViewController controller = MultiSplitViewController(areas: [
          Area(data: 'a', size: 100),
          Area(data: 'b', size: 100, min: 100),
        ],);
        LayoutConstraints layoutConstraints = LayoutConstraints(
            controller: controller,
            containerSize: 150,
            dividerThickness: 0,
            dividerHandleBuffer: 0,);
        layoutConstraints.adjustAreas(
            controllerHelper: ControllerHelper(controller),
            sizeOverflowPolicy: SizeOverflowPolicy.shrinkLast,
            sizeUnderflowPolicy: SizeUnderflowPolicy.stretchAll,
            minSizeRecoveryPolicy: MinSizeRecoveryPolicy.firstToLast,);
        expect(controller.areas.length, 2);
        TestHelper.testArea(controller.areas[0],
            data: 'a', min: null, max: null, flex: null, size: 100,);
        TestHelper.testArea(controller.areas[1],
            data: 'b', min: 100, max: null, flex: null, size: 50,);
        expect(layoutConstraints.flexCount, 0);
        expect(layoutConstraints.flexSum, 0);

        layoutConstraints = LayoutConstraints(
            controller: controller,
            containerSize: 200,
            dividerThickness: 0,
            dividerHandleBuffer: 0,);
        layoutConstraints.adjustAreas(
            controllerHelper: ControllerHelper(controller),
            sizeOverflowPolicy: SizeOverflowPolicy.shrinkLast,
            sizeUnderflowPolicy: SizeUnderflowPolicy.stretchAll,
            minSizeRecoveryPolicy: MinSizeRecoveryPolicy.firstToLast,);
        expect(controller.areas.length, 2);
        TestHelper.testArea(controller.areas[0],
            data: 'a', min: null, max: null, flex: null, size: 100,);
        TestHelper.testArea(controller.areas[1],
            data: 'b', min: 100, max: null, flex: null, size: 100,);
        expect(layoutConstraints.flexCount, 0);
        expect(layoutConstraints.flexSum, 0);
      });
    });
  });
}
