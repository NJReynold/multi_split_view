import 'dart:ui';

/// Signature for when a divider tap has occurred.
typedef DividerTapCallback = void Function(int dividerIndex);

/// Signature for when a divider double tap has occurred.
typedef DividerDoubleTapCallback = void Function(int dividerIndex);

/// Data class containing information about a divider drag event.
class DividerDragEvent {
  /// Creates a [DividerDragEvent].
  DividerDragEvent({
    required this.dividerIndex,
    required this.startSize,
    required this.leftWidgetSize,
    required this.delta,
    required this.totalSize,
    required this.globalPosition,
    required this.localPosition,
    required this.timestamp,
    required this.isDragging,
    this.rightWidgetSize,
  });

  /// The index of the divider being dragged.
  final int dividerIndex;

  /// The size of the area before the divider at the start of the drag.
  final double startSize;

  /// The current size of the area before the divider.
  final double leftWidgetSize;

  /// The size of the area after the divider.
  final double? rightWidgetSize;

  /// The change in size since the start of the drag.
  final double delta;

  /// The total size of all areas.
  final double totalSize;

  /// The global position of the drag.
  final Offset globalPosition;

  /// The local position of the drag within the widget.
  final Offset localPosition;

  /// The timestamp when the event occurred.
  final DateTime timestamp;

  /// Indicates whether the drag is currently in progress.
  final bool isDragging;
}

/// Signature for when a divider drag event occurs.
typedef OnDividerDragEvent = void Function(DividerDragEvent event);
