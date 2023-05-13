
abstract class AddOrRemoveFavoritesCubitStates{}

class AddOrRemoveFavoritesInitialState extends AddOrRemoveFavoritesCubitStates{}

class AddOrRemoveFavoritesLoadingState extends AddOrRemoveFavoritesCubitStates{}
class AddOrRemoveFavoritesSuccessState extends AddOrRemoveFavoritesCubitStates{}
class AddOrRemoveFavoritesFailedState extends AddOrRemoveFavoritesCubitStates{
  final String message ;
  AddOrRemoveFavoritesFailedState({required this.message});
}