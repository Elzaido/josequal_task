abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

// Get photos states:

class LoadingGetPhotosState extends HomeStates {}

class SuccessGetPhotosState extends HomeStates {}

class ErrorGetPhotosState extends HomeStates {}

// Get search data states:

class LoadingGetSearchedPhotosState extends HomeStates {}

class SuccessGetSearchedPhotosState extends HomeStates {}

class ErrorGetSearchedPhotosState extends HomeStates {}

// change index states:

class GoToSearchPage extends HomeStates {}

class ChangeNavState extends HomeStates {}

// URL launching states:

class SuccessDownloadImageState extends HomeStates {}

class ErrorDownloadImageState extends HomeStates {}

// Sqflite states:

class SuccessCreateDBState extends HomeStates {}

class SuccessInsertToDBState extends HomeStates {}

class ErrorInsertToDBState extends HomeStates {}

class LoadingGetFromDBState extends HomeStates {}

class SuccessGetFromDBState extends HomeStates {}

class ErrorGetFromDBState extends HomeStates {}

class SuccessDeleteFromDBState extends HomeStates {}
