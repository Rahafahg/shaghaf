import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shaghaf/data_layer/auth_layer.dart';
import 'package:shaghaf/models/organizer_model.dart';
import 'package:shaghaf/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseLayer {
  final supabase = Supabase.instance.client;
  Future createAccount(
      {required String email, required String password}) async {
    try {
      final AuthResponse response =
          await supabase.auth.signUp(email: email, password: password);
      if (response.user!.userMetadata!.isEmpty) {
        throw Exception('User Already Exists');
      }
      return response;
    } catch (e) {
      return e;
    }
  }

  Future verifyOtp(
      {required String email,
      required String otp,
      required String firstName,
      required String lastName,
      required String phoneNumber,
      required String externalId}) async {
    try {
      log("verifyOtp 1");
      final AuthResponse response = await supabase.auth
          .verifyOTP(email: email, token: otp, type: OtpType.email);
      log("verifyOtp 2");
      final id = response.user!.id;
      UserModel user = UserModel.fromJson({
        'user_id': id,
        'external_id': externalId,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'phone_number': phoneNumber,
      });
      await supabase.from("users").insert(user.toJson());
      GetIt.I.get<AuthLayer>().box.write('user', user.toJson());
      GetIt.I.get<AuthLayer>().user = user;
      return response;
    } catch (e) {
      return e;
    }
  }

  Future verifyOrganizerOtp(
      {required String email,
      required String otp,
      required String name,
      required String description,
      required String contactNumber,
      required String image}) async {
    try {
      final AuthResponse response = await supabase.auth
          .verifyOTP(email: email, token: otp, type: OtpType.email);
      final id = response.user!.id;
      OrganizerModel organizer = OrganizerModel.fromJson({
        'organizer_id': id,
        'email': email,
        'name': name,
        'image': image,
        'description': description,
        'contact_number': contactNumber,
        'license_number': '123456789'
      });
      await supabase.from("organizer").insert(organizer.toJson());
      GetIt.I.get<AuthLayer>().box.write('organizer', organizer.toJson());
      GetIt.I.get<AuthLayer>().organizer = organizer;
      return response;
    } catch (e) {
      return e;
    }
  }

  Future login(
      {required String email,
      required String password,
      required String externalId}) async {
    try {
      final AuthResponse response = await supabase.auth
          .signInWithPassword(email: email, password: password);
      await supabase
          .from('users')
          .update({'external_id': externalId}).eq('user_id', response.user!.id);
      final temp = await supabase
          .from('users')
          .select()
          .eq('user_id', response.user!.id);
      GetIt.I.get<AuthLayer>().user = UserModel.fromJson(temp.first);
      GetIt.I.get<AuthLayer>().box.write('user', GetIt.I.get<AuthLayer>().user);
      return response;
    } catch (e) {
      return e;
    }
  }

  Future nativeGoogleSignIn() async {
    const webClientId =
        '597665796791-ckkteirgascldjib553shdoc8b91p814.apps.googleusercontent.com';

    const iosClientId =
        '597665796791-gbqm8tukgrgf5b874icenmtrtr2b4rsl.apps.googleusercontent.com';

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: iosClientId,
        serverClientId: webClientId,
      );
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw 'No Access Token found.';
      }
      if (idToken == null) {
        throw 'No ID Token found.';
      }

      final response = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
      log("you are logeed!");
      log(response.session!.accessToken);
      await supabase.from('users').update({'external_id': 1111111111111}).eq(
          'user_id', response.user!.id);
      final temp = await supabase
          .from('users')
          .select()
          .eq('user_id', response.user!.id);
      GetIt.I.get<AuthLayer>().user = UserModel.fromJson(temp.first);
      GetIt.I.get<AuthLayer>().box.write('user', GetIt.I.get<AuthLayer>().user);
      log(GetIt.I.get<AuthLayer>().user!.email);
       return response;
    } catch (e) {
      log(e.toString());
    }
  }
}
