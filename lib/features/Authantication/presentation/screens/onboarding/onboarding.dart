import 'package:e_commerce_app_with_payment_gateway/core/resources/assets_manager.dart';
import 'package:e_commerce_app_with_payment_gateway/core/resources/navigator_manager.dart';
import 'package:e_commerce_app_with_payment_gateway/core/style/color_manager.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/presentation/screens/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({required this.contextOfMaterialApp,super.key});
  final BuildContext contextOfMaterialApp;
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController= PageController();

  int _currentPageIndex=0;

  List<PageInfo>?_pages;

  @override
  Widget build(BuildContext context) {
    _pages= [
      PageInfo(label:AppLocalizations.of(context)!.onBoadingTitle1,content:AppLocalizations.of(context)!.onBoadingbody1,svgPicture: SvgPicture.asset(AssetsManager.onBoardingOne )),
      PageInfo(label:AppLocalizations.of(context)!.onBoadingTitle2,content:AppLocalizations.of(context)!.onBoadingTitle2,svgPicture: SvgPicture.asset(AssetsManager.onBoardingTwo)),
      PageInfo(label:AppLocalizations.of(context)!.onBoadingTitle3,content:AppLocalizations.of(context)!.onBoadingbody3,svgPicture: SvgPicture.asset(AssetsManager.onBoardingThree)),
    ];
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, 
      statusBarIconBrightness: Brightness.dark
    ));
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _pageDesign(),
              Row(
                children: [
                  _indicator(),
                  const Spacer(),
                  _button(),
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  InkWell _button() {
    return InkWell(
      onTap: (){
        if(_currentPageIndex==_pages!.length-1){
          NavigatorManager.nagivateToAndCloseThePreviousScreens(context,  SignUpScreen(contextOfMaterialApp: widget.contextOfMaterialApp,));
        }else{
          _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
        }
      },
      child: Container(
        width: 60,
        height: 60,
        decoration:const BoxDecoration(
          shape: BoxShape.circle,
          color: ColorManager.primaryColor,
          boxShadow: [
            BoxShadow(blurRadius: 5,color: ColorManager.primaryColor),
          ],
        ),
        child:Icon(_currentPageIndex!=_pages!.length-1?Icons.navigate_next_sharp:Icons.done_rounded,size: 30,),
      ),
    );
  }

  Wrap _indicator() {
    return Wrap(
      children: List<Widget>.generate(_pages!.length, (int index) {
        return AnimatedContainer(
          duration:const Duration(milliseconds: 300),
          height: 10,
          width: (index == _currentPageIndex) ? 30.0 : 10.0,
          margin:const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: (index == _currentPageIndex)
                ? ColorManager.primaryColor
                : ColorManager.grey,
          ),
        );
      }),
    );
  }

  Expanded _pageDesign() {
    return Expanded(
      child: PageView.builder(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (value){
          _currentPageIndex=value;
          setState(() {});
        },
        itemCount: _pages!.length,
        itemBuilder:(context, index) {
          return  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_pages![index].label,style:const TextStyle(fontSize: 26,fontWeight: FontWeight.w700),),
              const SizedBox(height: 15,),
              Text(_pages![index].content,style:const TextStyle(color: Colors.grey,fontSize: 16),),
              SizedBox(height: MediaQuery.of(context).size.height*0.1,),
              SizedBox(height: MediaQuery.of(context).size.height*0.4,child: _pages![index].svgPicture),
            ],
          );
        },
      ),
    );
  }
}

class PageInfo{
  String label;
  String content;
  SvgPicture svgPicture;
  PageInfo({required this.content,required this.label,required this.svgPicture});
}