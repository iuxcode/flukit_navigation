library flukit_navigation;

import 'package:flukit_core/flukit_core.dart';
import 'package:flukit_navigation/src/navigation.service.dart';
import 'package:flukit_navigation/src/observers.dart';
import 'package:go_router/go_router.dart';

export 'package:go_router/go_router.dart';

export './src/observers.dart';
export './src/page.dart';
export './src/transitions.dart';

final NavigationService _navigationService = NavigationService();

extension FlukitNavigation on Flukit {
  /// Provide navigation utilities such as [GoRouter] and [FluNavObserver]
  NavigationService get router => _navigationService;
}
