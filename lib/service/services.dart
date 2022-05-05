import 'package:flutter/cupertino.dart';
import 'package:shop_app1/service/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shop_app1/secret.dart';

class Services extends InheritedWidget {

  final AuthService authService;

  const Services._({required this.authService, required Widget child}) : super (child: child);

  factory Services({required Widget child}){
    final client = SupabaseClient(supabaseSecretUrl, supabaseSecretKey);
    final authService = AuthService(client.auth);
    return Services._(authService: authService, child: child );
  }

  static Services of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<Services>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    throw UnimplementedError();
  }

}