library flukit_navigation;

import 'package:flukit_core/flukit_core.dart';
import 'package:flukit_navigation/src/navigation.service.dart';

export 'package:go_router/go_router.dart';

export './src/page.dart';
export './src/observers.dart';
export './src/transitions.dart';

final NavigationService navigationService = NavigationService(Flu());
