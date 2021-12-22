import '../../actions.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';


// асинхронная функция, вызов напрямую , передав store , без импорта
ThunkAction AddAsynFunc = (Store store) async {
  store.dispatch(AddNumAction());

};
