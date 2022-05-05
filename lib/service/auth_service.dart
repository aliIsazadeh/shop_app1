import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final GoTrueClient _client;
  AuthService(this._client);

  static const supabaseSessionKey = 'supabase_key';

  Future<bool> signUp(String email,String password) async{
    final response = await _client.signUp(email, password);
    if(response.error==null){
      _persistSession(response.data!);
      log('Successful sing up for user id ${response.user!.id}');
      return true;
    }
    log('Sing up error : ${response.error!.message}');
    return false;
  }

  Future<bool> singIn(String email,String password)async{
    final response = await _client.signIn(email: email , password:  password);
    if(response.error==null){
      _persistSession(response.data!);
      log('Successful sign in user ID : ${response.user!.id}');
      return true;
    }
    log('Error sign in : ${response.error!.message}');
    return false;
  }

  Future<bool> signOut() async {
    final response = await _client.signOut();
    if(response.error==null){
      log('Successful sign out}');
          return true;
    }
    log('Error sign out : ${response.error!.message}');
    return false ;
  }

  Future<bool> recoverSession()async {
    final prefs = await SharedPreferences.getInstance();

    if(prefs.containsKey(supabaseSessionKey)){
      log('Found persisted session string, attempting to recover session');
      final jsonString = prefs.getString(supabaseSessionKey)!;
      final response = await _client.recoverSession(jsonString);

      if(response.error == null){
        log('Successfully session recovered for user ID : ${response.user!.id}');
        _persistSession(response.data!);
        return true;
      }
    }
    return false;
  }

  Future<void> _persistSession(Session session) async{
    final prefs = await SharedPreferences.getInstance();
    log('Persisting session string');
    await prefs.setString(supabaseSessionKey, session.persistSessionString);
    }




}