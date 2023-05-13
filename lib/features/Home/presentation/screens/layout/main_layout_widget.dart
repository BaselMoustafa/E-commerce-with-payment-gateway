import 'package:e_commerce_app_with_payment_gateway/core/resources/assets_manager.dart';
import 'package:e_commerce_app_with_payment_gateway/core/resources/navigator_manager.dart';
import 'package:e_commerce_app_with_payment_gateway/core/style/color_manager.dart';
import 'package:e_commerce_app_with_payment_gateway/core/widets/colored_svg_widget.dart';
import 'package:e_commerce_app_with_payment_gateway/core/widets/flutter_toast.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/domain/model/my_user/my_user.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/add_remove_favorites_cubit/add_remove_favorites_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/add_remove_favorites_cubit/add_remove_favorites_cubit_states.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/get_favorites_cubit/get_favorites_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/get_home_data_cubit/get_home_data_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/get_user_cubit/get_user_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/initialize_favorites_cubit/initialize_favorites_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/search_products_cubit/search_products_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/screens/card_screen/card_screen.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/screens/favorite_screen/favorites_screen.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/screens/home_screen/home_screen.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/screens/profile_screen/profile_screen.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/screens/search_screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controllers/initialize_favorites_cubit/initialize_favorites_cubit_states.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainLayoutWidget extends StatefulWidget {
  const MainLayoutWidget({required this.contextOfMaterialApp,required this.myUser,super.key});
  final MyUser myUser;
  final BuildContext contextOfMaterialApp;
  @override
  State<MainLayoutWidget> createState() => _MainLayoutWidgetState();
}

class _MainLayoutWidgetState extends State<MainLayoutWidget> {
  late BuildContext _context;
  int _activeIndex=0;
  final List<String>_pathOfSvgAtAssets=[AssetsManager.homeIcon,AssetsManager.favIcon,AssetsManager.cartIcon,AssetsManager.profileIcon];
  List<String>_screensName=[];
  final scaffoldKey=GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    _screensName=[AppLocalizations.of(context)!.home,AppLocalizations.of(context)!.favorite,AppLocalizations.of(context)!.cart,AppLocalizations.of(context)!.profile];
    _context=context;
    return MultiBlocListener(
      listeners: [
        BlocListener<AddOrRemoveFavoritesCubit,AddOrRemoveFavoritesCubitStates>(
          listener: (context,state){
            if(state is AddOrRemoveFavoritesFailedState){
              showMyToast(message: state.message);
            }
          },
        ),
        BlocListener<InitializeFavoritesCubit,InitializeFavoritesCubitStates>(
          listener: (context,state){
            if(state is InitializeFavoritesFailedState){
              showMyToast(message: state.message);
            }
          },
        ),
      ],
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          title:Text(_screensName[_activeIndex<2?_activeIndex:_activeIndex-1]),
        ),
        body:Padding(
          padding:const EdgeInsets.symmetric(horizontal: 10),
          child: _getBody(context),
        ),
        bottomNavigationBar:_getBottomNavigationBar(),
      ),
    );
  }

  Widget _getBody(BuildContext context){
    if(_activeIndex==0){
      return HomeScreen(myUser: widget.myUser,);
    }else if(_activeIndex==1){
      return  FavoritesScreen(myUser: widget.myUser,);
    }else if(_activeIndex==3){
      return const CardScreen();
    }
    GetUserCubit.get(context).getUser();
    return ProfileScreen(contextOfMaterialApp: widget.contextOfMaterialApp,);   
  }

  Stack _getBottomNavigationBar(){
    double bottomNavHeight= MediaQuery.of(_context).size.height*0.1;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(height: bottomNavHeight,color: ColorManager.white,),
        _smallIconsDesign(bottomNavHeight),
        _searchIcon(bottomNavHeight)
      ],
    );
  }

  Container _smallIconsDesign(double bottomNavHeight) {
    return Container(
      height: bottomNavHeight,  
      decoration:const BoxDecoration(
        color: ColorManager.scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for(int i=0;i<5;i++)
            _getOneSmallIcon(i),
        ],
      ),
    );
  }

  Widget _getOneSmallIcon(int index){
    return index==2? SizedBox(width: MediaQuery.of(_context).size.width*0.15,)
      :InkWell(
      onTap: ()async{
        _activeIndex=index;
        await onOneIconTap.call();
      },
      child: Container(
        padding:const EdgeInsets.all(17),
        height: MediaQuery.of(_context).size.height*0.1,
        width: MediaQuery.of(_context).size.width*0.15,
        child:ColoredSvgPicture(
          color:index==_activeIndex?ColorManager.primaryColor:ColorManager.grey,
          path:index<2? _pathOfSvgAtAssets[index]:_pathOfSvgAtAssets[index-1],
        ),     
      ),
    );
    
  }
 
  Widget _searchIcon(double bottomNavHeight) {
    return Positioned(
      left: (MediaQuery.of(_context).size.width-bottomNavHeight)/2,
      bottom: bottomNavHeight*0.5,
      child: InkWell(
        onTap: () => NavigatorManager.navigateTo(context, SearchScreen(myUser: widget.myUser,),toExcuteAfterPop: () => SearchProductsCubit.get(context).refresh(),),
        child: Container(
          height: bottomNavHeight,
          width:bottomNavHeight,
          decoration: BoxDecoration(
            color: ColorManager.white,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow( offset: const Offset(0, 5),blurRadius: 5,color: ColorManager.primaryColor.withOpacity(0.4))]
          ),
          child: Center(
            child: CircleAvatar(
              radius: bottomNavHeight/2-3,
              backgroundColor: ColorManager.primaryColor,
              child:ColoredSvgPicture(color: ColorManager.white,path: AssetsManager.searchIcon,),
            ),
          ),
        ),
      ),
    );
  }
  
  Future<void> onOneIconTap()async{
    setState(() {});
    if(_activeIndex==0){
      GetHomeDataCubit.get(context).refresh();
    } if(_activeIndex==1){
      GetFavoritesProductsCubit.get(context).getFavoritesProducts();
    }
  }

}



