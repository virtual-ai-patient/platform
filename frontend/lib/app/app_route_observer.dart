import 'package:flutter/material.dart';

/// Observes navigation so screens can refresh when they become visible again.
final RouteObserver<PageRoute<void>> appRouteObserver =
    RouteObserver<PageRoute<void>>();
