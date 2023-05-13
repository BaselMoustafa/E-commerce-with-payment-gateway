import 'package:e_commerce_app_with_payment_gateway/core/resources/assets_manager.dart';
import 'package:e_commerce_app_with_payment_gateway/core/resources/navigator_manager.dart';
import 'package:e_commerce_app_with_payment_gateway/core/widets/custom_cached_network_image.dart';
import 'package:e_commerce_app_with_payment_gateway/core/widets/exception_widet.dart';
import 'package:e_commerce_app_with_payment_gateway/core/widets/flutter_toast.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/domain/model/my_user/my_user.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/search_products_cubit/search_products_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/search_products_cubit/search_products_cubit_states.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/widgets/custom_pop_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/style/color_manager.dart';
import '../../../../../core/widets/colored_svg_widget.dart';
import '../../../../../core/widets/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key,required this.myUser});
  final MyUser myUser;
  final TextEditingController _searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchProductsCubit,SearchProductsCubitStates>(
      listener: (context,state) {
        if(state is SearchProductsFailedState){
          showMyToast(message: state.message);
        }
      },
      child:Scaffold(
        appBar: _getAppBar(context),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: _getTextFormField(context),
            ),
            const SizedBox(height: 20,),
            _getSearchList(context),
          ],
        ),
      ),
      
    );
  }

  Expanded _getSearchList(context) {
    return Expanded(
      child: BlocBuilder<SearchProductsCubit,SearchProductsCubitStates>(
        builder: (context, state) {
          if(state is SearchProductsInitialState){
            return _initialStateDesign(context);
          }
          if(state is SearchProductsSuccessState){
            if(state.products.isEmpty){
              return  SingleChildScrollView(child: ExceptionWidget(text: AppLocalizations.of(context)!.notFoundForSearch,),); 
            }
            return _getProductsList(state);
          }
          return const SizedBox();
        },
      ),
    );
  }

  SingleChildScrollView _initialStateDesign(context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.search,size: 100,color: ColorManager.grey,),
            const SizedBox(height: 20,),
            Text(AppLocalizations.of(context)!.searchAndExplore,textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }

  AppBar _getAppBar(BuildContext context) {
    return AppBar(
        title: Text(AppLocalizations.of(context)!.search),
        leading:const CustomPopButton(),
      );
  }

  ListView _getProductsList(SearchProductsSuccessState state) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: 1+ state.products.length,
      separatorBuilder: (context, index) => Container(margin: const EdgeInsetsDirectional.only(start: 25),height: 1,color: ColorManager.grey,),
      itemBuilder:(context,index)=>index<state.products.length? _itemBuilder(state, index, context):const SizedBox(height: 20,), 
    );
  }

  Container _itemBuilder(SearchProductsSuccessState state, int index, BuildContext context) {
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      child:SizedBox(
        height: 90,
        child: Row(
          children: [
            _getProductImage(state, index),
            const SizedBox(width: 15,),
            _getProductInfo(state, index, context),
          ],
        ),
      ),
    );
  }

  Expanded _getProductInfo(SearchProductsSuccessState state, int index, BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(state.products[index].name,maxLines: 2,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge,),
            const Spacer(),
            _getPrice(state, index, context),
          ],
        ),
      ),
    );
  }

  Row _getPrice(SearchProductsSuccessState state, int index, BuildContext context) {
    return Row(
      children: [
        if(state.products[index].discount!=0)
        Text("${state.products[index].oldPrice.round()} ",style:const TextStyle(color: ColorManager.grey,fontWeight: FontWeight.w900,decoration: TextDecoration.lineThrough),),
        Text("${state.products[index].price} ${AppLocalizations.of(context)!.egp}",style: Theme.of(context).textTheme.headlineLarge,),
      ],
    );
  }

  SizedBox _getProductImage(SearchProductsSuccessState state, int index) {
    return SizedBox(
      width: 90,
      child: CustomCachedNetworkImage(imageUrl: state.products[index].image,boxFit: BoxFit.fill,width: double.infinity,height: double.infinity,),
    );
  }

  CustomTextFormField _getTextFormField(BuildContext context) {
    return CustomTextFormField(
      formKey: GlobalKey(), 
      controller: _searchController,
      autofocus: true,
      hintText: AppLocalizations.of(context)!.searchNow,
      validator: (_){return null;}, 
      onChanged: (value)async{
        await SearchProductsCubit.get(context).searchProducts(_searchController.text, myUser.token);
      },
      prefixIcon: Padding(
        padding: const EdgeInsets.all(20),
        child: ColoredSvgPicture(color: ColorManager.grey, path: AssetsManager.searchIcon),
      ),
      );
  }
}