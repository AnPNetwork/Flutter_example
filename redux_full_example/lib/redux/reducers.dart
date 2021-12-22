import 'package:flutter_redux_tutorial/redux/app_state.dart';
import './reducer_blocks/counter.dart';
import './reducer_blocks/text.dart';
import './reducer_blocks/num.dart';
import './reducer_blocks/widget.dart';
import 'package:redux/redux.dart';

import 'actions.dart';

AppState reducer(AppState state, dynamic action) => AppState(
    widget: imageReducer(state.widget, action),
    counter: counterReducer(state.counter, action),
    text: textReducer(state.text, action),
    num: numReducer(state.num, action)
);



// AppState reducer(AppState state, dynamic action) =>
//     AppState(counter: _counterReducer(state, action), text: _textReducer(state, action));
//
// int _counterReducer(AppState state, dynamic action) {
//   if (action is AddAction) {
//     return state.counter + 1;
//   } else if (action is RemoveAction) {
//     return state.counter - 1;
//   } else
//     return state.counter;
// }
//
// String _textReducer(AppState state, dynamic action) {
//   if (action is SetTextAction) {
//     return action.text;
//   } else if (action is ResetTextAction) {
//     return "";
//   } else {
//     return state.text;
//   }
// }