import 'package:e_commerce_app_with_payment_gateway/core/style/color_manager.dart';
import 'package:e_commerce_app_with_payment_gateway/core/widets/customButton.dart';
import 'package:e_commerce_app_with_payment_gateway/core/widets/custom_text_form_field.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/domain/model/my_user/my_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/update_user_cubit/update_user_cubit.dart';
import '../controllers/update_user_cubit/update_user_cubit_states.dart';

class UpdateUserBottomSheet extends StatelessWidget {
  UpdateUserBottomSheet({required this.myUser,super.key});

  final _labelText= const["User name","E-mail"];
  final _textContrllers=[TextEditingController(),TextEditingController()];
  final _formKeys=[GlobalKey<FormState>(),GlobalKey<FormState>()];
  final MyUser myUser;

  @override
  Widget build(BuildContext context) {
    _textContrllers[0].text=myUser.name;
    _textContrllers[1].text=myUser.email;

    return Container(
      height: 260,
      decoration: BoxDecoration(
        color: ColorManager.white,
        border: Border.all(width: 2,color: ColorManager.primaryColor),
        borderRadius: BorderRadius.circular(20)
      ),
      child: _sheetDesign(),
    );
  }

  Padding _sheetDesign() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          for(int i=0;i<_formKeys.length;i++)
          _getOneTextFormField(i),
          const SizedBox(height: 7,),
          _getUpdateButton(),
          
        ],
      ),
    );
  }

  BlocBuilder<UpdateUserCubit, UpdateUserCubitStates> _getUpdateButton() {
    return BlocBuilder<UpdateUserCubit,UpdateUserCubitStates>(
      builder: (context, state) {
        if(state is UpdateUserLoadingState){
          return const CustomButton(onTap: null, content: null);
        }else{
          return CustomButton(
            onTap: ()async{
              await UpdateUserCubit.get(context).updateUser(myUser.token, _textContrllers[0].text, _textContrllers[1].text);
            }, 
            content: "Update",
          );
        }
      },
    );
  }

  Container _getOneTextFormField(int i) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: CustomTextFormField(
        formKey: _formKeys[i], 
        validator: (value){
          if(value==null||value.trim().length==0){
            return "This Field has not to be empty";
          }
        }, 
        labelText: _labelText[i], 
        controller: _textContrllers[i],
        ),
    );
  }
}