library flukit_navigation;

import 'package:flukit_core/flukit_core.dart';
import 'package:flukit_navigation/src/navigation.service.dart';
import 'package:flukit_navigation/src/observers.dart';
import 'package:go_router/go_router.dart';

export 'package:go_router/go_router.dart';

export './src/observers.dart';
export './src/page.dart';
export './src/transitions.dart';

/// Provide navigation utilities such as [GoRouter] and [FluNavObserver]
final NavigationService navigationService = NavigationService(Flu);
