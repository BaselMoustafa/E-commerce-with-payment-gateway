
abstract class InitializeFavoritesCubitStates{}

class InitializeFavoritesInitialState extends InitializeFavoritesCubitStates{}

class InitializeFavoritesLoadingState extends InitializeFavoritesCubitStates{}
class InitializeFavoritesSuccessState extends InitializeFavoritesCubitStates{}
class InitializeFavoritesFailedState extends InitializeFavoritesCubitStates{
  final String message ;
  InitializeFavoritesFailedState({required this.message});
}