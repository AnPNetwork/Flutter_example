import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import '../actions.dart';

Reducer<Widget> imageReducer = combineReducers(
    [TypedReducer(getImageReducer), TypedReducer(loadedImageReducer)]);

Widget getImageReducer(Widget widget, GetImageAction action) =>
    Center(child: CircularProgressIndicator());

Widget loadedImageReducer(Widget widget, LoadedImageAction action) =>
    action.widget;
