import 'package:flutter/widgets.dart';
import 'package:multi_split_view/multi_split_view.dart' show MultiSplitView;
import 'package:multi_split_view/src/multi_split_view.dart' show MultiSplitView;
import 'package:multi_split_view/src/theme_data.dart';

/// Applies a [MultiSplitView] theme to descendant widgets.
/// See also:
///
///  * [MultiSplitViewThemeData], which describes the actual configuration of a theme.
class MultiSplitViewTheme extends StatelessWidget {
  /// Applies the given theme [data] to [child].
  ///
  /// The [data] and [child] arguments must not be null.
  const MultiSplitViewTheme({
    required this.child, required this.data, Key? key,
  }) : super(key: key);

  /// Specifies the theme for descendant widgets.
  final MultiSplitViewThemeData data;

  /// The widget below this widget in the tree.
  final Widget child;

  static final MultiSplitViewThemeData _defaultTheme =
      MultiSplitViewThemeData();

  /// The data from the closest [MultiSplitViewTheme] instance that encloses the given
  /// context.
  static MultiSplitViewThemeData of(BuildContext context) {
    final _InheritedTheme? inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<_InheritedTheme>();
    final MultiSplitViewThemeData data =
        inheritedTheme?.theme.data ?? _defaultTheme;
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedTheme(theme: this, child: child);
  }
}

class _InheritedTheme extends InheritedWidget {
  const _InheritedTheme({
    required this.theme, required Widget child, Key? key,
  }) : super(key: key, child: child);

  final MultiSplitViewTheme theme;

  @override
  bool updateShouldNotify(_InheritedTheme old) => theme.data != old.theme.data;
}
