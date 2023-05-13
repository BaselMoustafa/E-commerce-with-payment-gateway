import 'package:e_commerce_app_with_payment_gateway/core/style/color_manager.dart';
import 'package:e_commerce_app_with_payment_gateway/core/widets/customButton.dart';
import 'package:e_commerce_app_with_payment_gateway/core/widets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthanticationWidget extends StatelessWidget {
  AuthanticationWidget({
    required this.button,
    required this.screenName,
    required this.dialog,
    required this.qustion,
    required this.formFieldData,
    required this.anotherScreenName,
    required this.onTapNaviagtion,
  });
  final Widget button;
  final String screenName;
  final String dialog;
  final String qustion;
  final VoidCallback onTapNaviagtion;
  final String anotherScreenName;
  List<FormFieldData>formFieldData=[];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                _getTopView(),
                _getAllTextFormFields(),
                const SizedBox(height: 20,),
                button,
                const SizedBox(height: 30,),
                _getAskWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _getAskWidget(){
    return Row(
      children: [
        const Spacer(),
        Text(qustion),
        InkWell(
          onTap: onTapNaviagtion,
          child:Text(anotherScreenName,style:const TextStyle(fontWeight: FontWeight.w700,fontSize: 14,color: ColorManager.primaryColor,decoration: TextDecoration.underline),),
        ),
        const Spacer(),
      ],
    );
  }


  Column _getTopView(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(screenName,style:const TextStyle(color: ColorManager.primaryColor,fontWeight: FontWeight.w900,fontSize: 30),),
        const SizedBox(height: 10,),
        Text(dialog,style:const TextStyle(fontWeight: FontWeight.w400,color: ColorManager.black),),
        const SizedBox(height: 32,),
      ],
    );
  }

  Column _getAllTextFormFields(){
    
    return Column(  
      children: [
        for(int i=0;i<formFieldData.length;i++)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(formFieldData[i].name,style:const TextStyle(fontWeight: FontWeight.w700),),
              const SizedBox(height: 8,),
              CustomTextFormField(
                hintText: formFieldData[i].hintText, 
                controller: formFieldData[i].textController,
                formKey: formFieldData[i].formKey, 
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(13),
                  child: formFieldData[i].prefixIcon,
                ),
                validator: (value){
                  if(value==null||value.trim().length==0){
                    return "This field has not to be empty";
                  }
                }, 
                isPassword:formFieldData[i].isPassword?true:false,
              ),
              const SizedBox(height: 16,)
            ],
          ),
      ],
    );

  }
  
}

class FormFieldData{
    final String name;
    final String hintText;
    final SvgPicture prefixIcon;
    final Widget? suffixIcon;
    final TextEditingController textController;
    final GlobalKey<FormState> formKey;
    bool isPassword;
    FormFieldData({
      this.isPassword=false,
      required  this.name,
      required this.hintText,
      required this.prefixIcon,
      this.suffixIcon,
      required this.textController,
      required this.formKey,
    });

  }