import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider_arc/core/constants/app_contstants.dart';
import 'package:provider_arc/main.dart';
import 'package:provider_arc/ui/views/login/authen.dart';
import 'package:provider_arc/ui/views/login/forgotpass.dart';
import 'package:provider_arc/ui/views/login/login.dart';
import 'package:provider_arc/ui/views/login/otp.dart';
import 'package:provider_arc/ui/views/login/signup.dart';
import 'package:provider_arc/ui/views/main_page.dart';
import 'package:provider_arc/ui/views/other/letgo_view.dart';
import 'package:provider_arc/ui/views/other/notification_view.dart';
import 'package:provider_arc/ui/views/other/onboard_view.dart';
import 'package:provider_arc/ui/views/other/promo.dart';
import 'package:provider_arc/ui/views/payment/addpaymentcard.dart';
import 'package:provider_arc/ui/views/payment/payment.dart';
import 'package:provider_arc/ui/views/payment/selectpayment.dart';
import 'package:provider_arc/ui/views/place/addnewplace_view.dart';
import 'package:provider_arc/ui/views/place/addplacemap_view.dart';
import 'package:provider_arc/ui/views/place/favourite_view.dart';
import 'package:provider_arc/ui/views/place/pickaddress_view.dart';

import 'views/other/agreement_view.dart';
import 'views/user/changepass_view.dart';
import 'views/user/profile_view.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.Intro:
        return MaterialPageRoute(builder: (_) => IntroView());
      case RoutePaths.Authen:
        return MaterialPageRoute(builder: (_) => AuthenView());
      case RoutePaths.Login:
        return MaterialPageRoute(builder: (_) => LoginView());
      case RoutePaths.ForgotPass:
        return MaterialPageRoute(builder: (_) => ForgotPassView());
      case RoutePaths.Signup:
        return MaterialPageRoute(builder: (_) => SignupView());
      case RoutePaths.MainPage:
        return MaterialPageRoute(builder: (_) => MainPage());
      case RoutePaths.VerifyOtp:
        return MaterialPageRoute(builder: (_) => VerifyOTPView());
      case RoutePaths.Letgo:
        return MaterialPageRoute(builder: (_) => LetgoView());
      case RoutePaths.Agreement:
        return MaterialPageRoute(builder: (_) => AgreementView());
      case RoutePaths.Pickadresss:
        return MaterialPageRoute(builder: (_) => PickAdressView());
      case RoutePaths.Favourite:
        return MaterialPageRoute(builder: (_) => FavoriteView());
      case RoutePaths.Splash:
        return MaterialPageRoute(builder: (_) => SplashView());
      case RoutePaths.Addplace:
        return MaterialPageRoute(builder: (_) => AddNewPlaceView());
      case RoutePaths.AddplaceMap:
        return MaterialPageRoute(builder: (_) => AddPlacemapView());
      case RoutePaths.Profile:
        return MaterialPageRoute(builder: (_) => ProfileView());
      case RoutePaths.Changepass:
        return MaterialPageRoute(builder: (_) => ChangepassView());
      case RoutePaths.Notication:
        return MaterialPageRoute(builder: (_) => NotificationView());
      case RoutePaths.Payment:
        return MaterialPageRoute(builder: (_) => PaymementView());
      case RoutePaths.SelectPayment:
        return MaterialPageRoute(builder: (_) => SelectPaymementView());
      case RoutePaths.AddPayment:
        return MaterialPageRoute(builder: (_) => Addpaymentcard());
      case RoutePaths.Promo:
        return MaterialPageRoute(builder: (_) => PromoView());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
