abstract class UpdateUserCubitStates{}
class UpdateUserInitialState extends UpdateUserCubitStates{}
class UpdateUserLoadingState extends UpdateUserCubitStates{}
class UpdateUserSuccessState extends UpdateUserCubitStates{}
class UpdateUserFailedState extends UpdateUserCubitStates{
  final String message ;
  UpdateUserFailedState({required this.message});
}