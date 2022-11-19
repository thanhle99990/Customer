import 'package:provider/provider.dart';
import 'package:provider_arc/core/services/authentication_service.dart';
import 'package:provider_arc/core/services/phone_auth.dart';
import 'package:provider_arc/core/viewmodels/widgets/placelist.dart';

import 'core/models/userobj.dart';
import 'core/services/api.dart';

List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders,
  ChangeNotifierProvider<PhoneAuthDataProvider>(
    builder: (context) => PhoneAuthDataProvider(),
  ),
  ChangeNotifierProvider<PlaceListModel>(
    builder: (context) => PlaceListModel(),
  ),
];

List<SingleChildCloneableWidget> independentServices = [
  Provider.value(value: Api())
];

List<SingleChildCloneableWidget> dependentServices = [
  ProxyProvider<Api, AuthenticationService>(
    builder: (context, api, authenticationService) =>
        AuthenticationService(api: api),
  ),
];

List<SingleChildCloneableWidget> uiConsumableProviders = [
  StreamProvider<UserObj>(
    builder: (context) =>
        Provider.of<AuthenticationService>(context, listen: false).user,
  ),
];
