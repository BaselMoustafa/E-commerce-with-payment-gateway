import 'package:e_commerce_app_with_payment_gateway/core/style/color_manager.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String? Function (String? value)validator;
  final void Function(String)?onChanged;
  final void Function(String)?onFieldSubmitted;
  final hintText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool autofocus;
  final bool autoValidation;
  final GlobalKey<FormState> formKey;
  Widget? suffixIcon;
  Widget? prefixIcon;
  final labelText;
  bool isPassword;
  CustomTextFormField({
    required this.formKey,
    this.autoValidation=true,
    required this.validator,
    this.hintText,
    required this.controller,
    this.onChanged,
    this.onFieldSubmitted,
    this.textInputType=TextInputType.name,
    this.autofocus=false,
    this.suffixIcon,
    this.prefixIcon,
    this.isPassword=false,
    this.labelText,
    });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isFirstDisplayOnScreen=true;
  bool _isVaild=true;
  bool _contentIsNotVisibleVisible=true;
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: TextFormField(
        controller: widget.controller,
        validator:widget.validator,
        autofocus: widget.autofocus,
        obscureText:!widget.isPassword?false:_contentIsNotVisibleVisible,
        onChanged: !widget.autoValidation? widget.onChanged:(value){
          widget.onChanged?.call(value);
          if(!_isFirstDisplayOnScreen){
            _isVaild= widget.formKey.currentState!.validate();
            setState(() {});
          }else{
            if(widget.controller.text.isNotEmpty){
              _isVaild=widget.formKey.currentState!.validate();
            }
            _isFirstDisplayOnScreen=false;
          } 
        },
        onFieldSubmitted: widget.onFieldSubmitted,
        cursorColor: ColorManager.primaryColor,
        style:const TextStyle(fontSize: 16,color: ColorManager.black),
        keyboardType: widget.textInputType,
        decoration:  InputDecoration(
          
          suffixIcon:!widget.isPassword?widget.suffixIcon:InkWell(
            onTap: (){
              _contentIsNotVisibleVisible=!_contentIsNotVisibleVisible;
              setState(() {});
            },
            child: _contentIsNotVisibleVisible?const Icon(Icons.visibility,color: ColorManager.primaryColor,):const Icon(Icons.visibility_off,color: ColorManager.primaryColor,),
          ),
          prefixIcon: widget.prefixIcon,
          hintText: widget.hintText,
          labelText: widget.labelText,
          labelStyle: const TextStyle(color: ColorManager.primaryColor),
          hintStyle:TextStyle(
            fontSize: 14,
            color:_isVaild?ColorManager.grey:ColorManager.red,
            ),
          contentPadding:const EdgeInsets.all (20),
          focusedBorder:const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: ColorManager.primaryColor,width: 1.5),
          ),
          enabledBorder:const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: ColorManager.primaryColor,width: 1.5)
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: ColorManager.red,width: 1.5),
          ),
          focusedErrorBorder:const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: ColorManager.red,width: 1.5),
          ),
          errorStyle:const TextStyle(fontSize: 10),
      
        ),
      ),
      
    );
  }

}