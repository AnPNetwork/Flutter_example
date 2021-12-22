import 'package:redux/redux.dart';
import '../actions.dart';

Reducer<String> textReducer = combineReducers([
  TypedReducer<String, SetTextAction>(setTextReducer),
  TypedReducer<String, ResetTextAction>(resetTextReducer),
]);


String setTextReducer(String text, SetTextAction action) => action.text;

String resetTextReducer(String text, ResetTextAction action) => "";