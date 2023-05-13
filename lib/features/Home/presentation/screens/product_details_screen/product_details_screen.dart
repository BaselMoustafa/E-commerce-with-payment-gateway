import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app_with_payment_gateway/core/style/color_manager.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/model/product_model/product_model.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/screens/product_details_screen/buy_button.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/screens/product_details_screen/cart_button.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/widgets/back_ground_clipper.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/widgets/custom_pop_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({super.key,required this.productModel});
  final double _radiusOfCurvetureOfPath=30;
  final double _buttonHeight=50;
  final PageController _pageController=PageController();
  final ProductModel productModel;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: _getAppBarWidget(context),
      body: _getBody(context),
    );
  }

  NestedScrollView _getBody(BuildContext context) {
    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
         return [
          _getSliverAppBar(context),
        ];
      },
      body: _descriptionAndButtons(context),
    );
  }

  Padding _descriptionAndButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
      child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: _buttonHeight),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Text(AppLocalizations.of(context)!.details,style: Theme.of(context).textTheme.displayLarge,),
                  const SizedBox(height: 10,),
                  Text(
                    productModel.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  AddToCartButton(buttonHeight: _buttonHeight,productModel: productModel,),
                  const SizedBox(width: 10,),
                  BuyButton(buttonHeight: _buttonHeight, productModel: productModel),
                ],
              ),
            ),
          ],
        ),
    );
  }

  AppBar _getAppBarWidget(context){
    return AppBar(
      automaticallyImplyLeading: false,
      title:Text(AppLocalizations.of(context)!.productDetails),
      leading:const CustomPopButton(),
    );
  }

  SliverAppBar _getSliverAppBar(context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      floating: true,
      backgroundColor: ColorManager.white,
      expandedHeight: 400,
      flexibleSpace: FlexibleSpaceBar(
        background: _productImagesWidget(context),
      ),
    );
  }
  

  void _onGoForwardTapped(){
    int cuurentPage=_pageController.page!.round();
    if(cuurentPage<productModel.image.length-1){
      _pageController.animateToPage(++cuurentPage, duration:const Duration(milliseconds: 800), curve: Curves.fastOutSlowIn);
    }else{
      _pageController.jumpToPage(0);
    }
  }
  void _onGoBackTapped(){
    int cuurentPage=_pageController.page!.round();
    if(cuurentPage>0){
      _pageController.animateToPage(--cuurentPage, duration:const Duration(milliseconds: 800), curve: Curves.fastOutSlowIn);
    }else{
      _pageController.jumpToPage(productModel.images.length-1);
    }
  }

  InkWell _getIcon(Color color, IconData iconData,VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(radius: 25,backgroundColor: ColorManager.primaryColor,child: Icon(iconData,size: 30,color: ColorManager.white,),),
    );
  }


  Widget _productImagesWidget(context) {
    return ClipPath(
      clipper: BackGroundClipper(radiusOfCurvetureOfPath: _radiusOfCurvetureOfPath),
      child: Container(
        decoration:const BoxDecoration(
          color: ColorManager.scaffoldBackgroundColor,
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 15,right: 15,top: 10,bottom:15+_radiusOfCurvetureOfPath),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    _getIcon(ColorManager.primaryColor, Icons.arrow_back_rounded,_onGoBackTapped),
                    Expanded(
                      child: Padding(
                        padding:const EdgeInsets.only(top: 30,bottom: 20,left: 10,right: 10),
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: productModel.images.length,
                          physics:const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return CachedNetworkImage(
                              imageUrl: productModel.images[index],
                              fit: BoxFit.fill,
                            );
                          },
                        ),
                      ),
                    ),
                    _getIcon(
                      ColorManager.primaryColor, Icons.arrow_forward_rounded,
                      _onGoForwardTapped,
                      ),
                  ],
                ),
              ),
              Text(
                productModel.name,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                ),
              const SizedBox(height: 8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(productModel.discount!=0)
                  Text("${productModel.oldPrice.round()}",style:const TextStyle(color: ColorManager.grey,fontWeight: FontWeight.w900,decoration: TextDecoration.lineThrough),),
                  const SizedBox(width: 3,),
                  Text(
                    "${productModel.price} ${AppLocalizations.of(context)!.egp}",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}




