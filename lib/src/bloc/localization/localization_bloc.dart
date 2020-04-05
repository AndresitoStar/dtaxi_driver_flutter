
import 'package:bloc/bloc.dart';

import 'localization_events.dart';

enum  LocalizationState {
  INIT, //State where location service is activated but not broadcasting yet
  BROADCASTING, // State trigged every time location is send
  STOPPED // State where location service is stopped
}


class LocalizationBloc
    extends Bloc<LocalizationEvent, LocalizationState> {

  static final LocalizationBloc _localizationBlocSingleton =
  new LocalizationBloc._internal();

  factory LocalizationBloc() {
    return _localizationBlocSingleton;
  }

  LocalizationBloc._internal();

  @override
  LocalizationState get initialState => LocalizationState.STOPPED;

  @override
  Stream<LocalizationState> mapEventToState(LocalizationEvent event) async* {
    try {
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      yield state;
    }
  }

  @override
  Future<Function> close() {
    _localizationBlocSingleton.close();
    return super.close();
  }

}