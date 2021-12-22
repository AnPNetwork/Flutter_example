import '../../actions.dart';
import '../../app_state.dart';
import 'package:redux/redux.dart';


// функция перехватчик
void colorMiddleware(
    Store<AppState> store, dynamic action, NextDispatcher nextDispatcher) {

  if (action is AddAction) {

    store.dispatch(AddNumAction());

  }
  nextDispatcher(action);
}
