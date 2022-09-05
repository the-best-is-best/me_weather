abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppLoadAppDataState extends AppStates {}

class AppLoadDataState extends AppStates {}

class AppLoadedState extends AppStates {}

class AppNeededLocationState extends AppStates {}

class AppErrorState extends AppStates {
  final String error;

  AppErrorState(this.error);
}

class AppLoadedDataState extends AppStates {}

class AppChangeCountryState extends AppStates {}

class AppSearchCityState extends AppStates {}

class AppSearchedCityState extends AppStates {}

class ChangeToFahrenheitState extends AppStates {}
