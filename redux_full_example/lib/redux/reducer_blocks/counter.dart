import 'package:redux/redux.dart';
import '../actions.dart';


Reducer<int> counterReducer = combineReducers([
  TypedReducer<int, AddAction>(addCounterReducer),
  TypedReducer<int, RemoveAction>(removeCounterReducer),
]);

int addCounterReducer(int count, AddAction action) => count + action.count;

int removeCounterReducer(int count, RemoveAction action) => count - 1;







