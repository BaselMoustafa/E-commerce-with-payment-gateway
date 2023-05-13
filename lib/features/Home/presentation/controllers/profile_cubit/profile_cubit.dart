import 'package:e_commerce_app_with_payment_gateway/features/Home/domain/usecases/signout_usecase.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/profile_cubit/profile_cubit_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileCubitStates>{
  final SignOutUseCase signOutUseCase;
  ProfileCubit({required this.signOutUseCase}):super(ProfileCubitInitialState());

  static ProfileCubit get(context)=>BlocProvider.of(context);

  Future<void> signOut(String token)async{
    await signOutUseCase.excute(token);
  }

}