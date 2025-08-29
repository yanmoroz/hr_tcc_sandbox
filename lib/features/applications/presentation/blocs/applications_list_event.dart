import 'package:flutter/material.dart';

enum ApplicationsFilter { all, inProgress, done }

abstract class ApplicationsListEvent {}

class ApplicationsListStarted extends ApplicationsListEvent {}

class ApplicationsListFilterChanged extends ApplicationsListEvent {
  final ApplicationsFilter filter;
  ApplicationsListFilterChanged(this.filter);
}

class ApplicationsListSearchChanged extends ApplicationsListEvent {
  final String query;
  ApplicationsListSearchChanged(this.query);
}
