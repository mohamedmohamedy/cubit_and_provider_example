abstract class UserStates {}

class UserScreenInitialState extends UserStates {}
class UsersDatabaseInitialized extends UserStates {}
class InsertDataToUserDatabaseState extends  UserStates {}
class FetchDataState extends UserStates {}
class SelectUserState extends UserStates {}