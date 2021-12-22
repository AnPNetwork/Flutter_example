import 'package:redux/redux.dart';
import '../actions.dart';
import 'package:flutter/material.dart';

Reducer<int> numReducer = combineReducers([
  TypedReducer<int, AddNumAction>(addNumCounterReducer)
]);

int addNumCounterReducer(int count, AddNumAction action) => count += 5;


