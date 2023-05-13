abstract class ApiK{
  //BASE URL
  static const String baseUrl="https://student.valuxapps.com/api/";


  //END POINTS
    //User END POINTS
      static const String signInEndPoint="login";
      static const String signUpEndPoint="register";
      static const String signOutEndPoint ="logout";
      static const String profileInfoEndPoint ="profile";
      static const String updateProfileEndPoint ="update-profile";
    //PRODUCTS AND BANNERS END POINTS
      static const String getHomeDataEndPoint ="home";
      static const String searchProductsEndPoint ="products/search";
    
    //FAVORITES END POINTS
      static const String getOraddOrDeleteFavoritesEndPoint="favorites";
  
  //HEADERS ATTRIBUTES
    static const String lang="lang";
    static const String ar="ar";
    static const String en="en";
    static const String contentType="Content-Type";
    static const String applicationOverJson ="application/json";
    static const String authorization="Authorization";

  //HTTP MESSAGES BODY ATTRIBUTES 
    //GENERALLY USED ATTRIBUTES
      static const String data ="data";
      static const String id ="id";
      static const String token ="token";
      static const String message ="message";
    
    //AT USER ENDPOINTS
      static const String name ="name";
      static const String phone ="phone";
      static const String email ="email";
      static const String password ="password";
      static const String image ="image";
      static const String status ="status";
    
    //AT PRODUCTS AND BANNERS
      static const String imagessssss ="images";
      static const String banners="banners";
      static const String productsssss="products";
      static const String producttttt="product";
      static const String price="price";
      static const String oldPrice="old_price";
      static const String discount="discount";
      static const String description="description";
      static const String inFav="in_favorites";
    //AT FAVORITES
      static const String productId="product_id";
    //AT SEARCH
      static const String text="text";


}