import 'dart:developer';
import 'dart:io';
import 'dart:math' as mm;

import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shaghaf/data_layer/auth_layer.dart';
import 'package:shaghaf/data_layer/data_layer.dart';
import 'package:shaghaf/models/booking_model.dart';
import 'package:shaghaf/models/categories_model.dart';
import 'package:shaghaf/models/organizer_model.dart';
import 'package:shaghaf/models/user_model.dart';
import 'package:shaghaf/models/workshop_group_model.dart';
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
    // try {
    log("verifyOtp 1");

    final AuthResponse response = await supabase.auth
        .verifyOTP(email: email, token: otp, type: OtpType.signup);

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
    // } catch (e) {
    //   return e;
    // }
  }

  Future verifyOrganizerOtp(
      {required String email,
      required String otp,
      required String name,
      required String description,
      required String contactNumber,
      required File? image}) async {
    final AuthResponse response = await supabase.auth
        .verifyOTP(email: email, token: otp, type: OtpType.signup);
    String imageUrl = "";
    if (image != null) {
      try {
        // Upload file to Supabase storage
        await GetIt.I
            .get<SupabaseLayer>()
            .supabase
            .storage
            .from('organizer_images')
            .upload('public/${image.path.split('/').last}', image);
      } catch (e) {
        log('Error uploading image: $e');
      }

      try {
        // Upload file to Supabase storage
        imageUrl = GetIt.I
            .get<SupabaseLayer>()
            .supabase
            .storage
            .from('organizer_images')
            .getPublicUrl('public/${image.path.split('/').last}');
      } catch (e) {
        log('Error uploading image: $e');
      }
    }

    final id = response.user!.id;
    OrganizerModel organizer = OrganizerModel.fromJson({
      'organizer_id': id,
      'email': email,
      'name': name,
      'image': imageUrl,
      'description': description,
      'contact_number': contactNumber,
      'license_number': '123456789'
    });
    await supabase.from("organizer").insert(organizer.toJson());
    GetIt.I.get<AuthLayer>().box.write('organizer', organizer.toJson());
    GetIt.I.get<AuthLayer>().organizer = organizer;
    return response;
  }

  Future login(
      {required String email,
      required String password,
      required String role,
      required String externalId}) async {
    try {
      final AuthResponse response = await supabase.auth
          .signInWithPassword(email: email, password: password);
      if (role == 'user') {
        await supabase.from('users').update({'external_id': externalId}).eq(
            'user_id', response.user!.id);
        final temp = await supabase
            .from('users')
            .select()
            .eq('user_id', response.user!.id);
        GetIt.I.get<AuthLayer>().user = UserModel.fromJson(temp.first);
        GetIt.I
            .get<AuthLayer>()
            .box
            .write('user', GetIt.I.get<AuthLayer>().user);
        log(GetIt.I.get<AuthLayer>().box.hasData('user').toString());
      }
      if (role == 'organizer') {
        final temp = await supabase
            .from('organizer')
            .select()
            .eq('organizer_id', response.user!.id);
        GetIt.I.get<AuthLayer>().organizer =
            OrganizerModel.fromJson(temp.first);
        GetIt.I
            .get<AuthLayer>()
            .box
            .write('organizer', GetIt.I.get<AuthLayer>().organizer);
        log(GetIt.I.get<AuthLayer>().box.hasData('organizer').toString());
      }
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
      GetIt.I
          .get<AuthLayer>()
          .box
          .write('user', GetIt.I.get<AuthLayer>().user!.toJson());
      log(GetIt.I.get<AuthLayer>().user!.email);
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  getAllWorkshops() async {
    log('hello yaser im getting data right now ---------------');
    List<WorkshopGroupModel> workshops = [];
    final response = await GetIt.I
        .get<SupabaseLayer>()
        .supabase
        .from('workshop_group')
        .select('*, workshop(*)');
    for (var workshopAsJson in response) {
      workshops.add(WorkshopGroupModel.fromJson(workshopAsJson));
    }
    GetIt.I.get<DataLayer>().workshops = workshops;
    GetIt.I.get<DataLayer>().workshopOfTheWeek =
        workshops[mm.Random().nextInt(workshops.length)];
  }

  getAllCategories() async {
    final categoriesAsMap = await supabase.from('categories').select();
    log(categoriesAsMap.toString());

    // Convert the map into a list of CategoriesModel
    final List<CategoriesModel> categories =
        categoriesAsMap.map<CategoriesModel>((category) {
      return CategoriesModel.fromJson(category);
    }).toList();

    // Separate the 'Others' category from the list
    final List<CategoriesModel> othersCategory = categories
        .where((category) => category.categoryName == 'Others')
        .toList();
    final List<CategoriesModel> otherCategories = categories
        .where((category) => category.categoryName != 'Others')
        .toList();

    // Add 'Others' at the end of the list
    final List<CategoriesModel> orderedCategories = [
      ...otherCategories,
      ...othersCategory
    ];

    // Assign the ordered categories to the DataLayer
    GetIt.I.get<DataLayer>().categories = orderedCategories;

    log(GetIt.I.get<DataLayer>().categories.toString());
  }

  getBookings() async {
    final bookingAsMap = await supabase
        .from('booking')
        .select()
        .eq('user_id', GetIt.I.get<AuthLayer>().user!.userId);
    log(bookingAsMap.toString());
    // Convert the map into a list of CategoriesModel
    GetIt.I.get<DataLayer>().bookings =
        bookingAsMap.map<BookingModel>((booking) {
      return BookingModel.fromJson(booking);
    }).toList();
    log(GetIt.I.get<DataLayer>().bookings.toString());
  }

  Future<dynamic> saveBooking({
    required Workshop workshop,
    required String qr,
    required int numberOfTickets,
    required double totalPrice,
  }) async {
    try {
      // Inserting a new booking, relying on the default booking_date and booking_id
      final booking = await supabase.from('booking').insert({
        'user_id': GetIt.I.get<AuthLayer>().user!.userId,
        'workshop_id': workshop.workshopId,
        'number_of_tickets': numberOfTickets,
        'total_price': totalPrice,
        'qr_code': qr,
      }).select();

      log(booking.toString());
      getBookedWorkshops();
      return booking.first;
    } catch (e) {
      log('Error saving booking: $e');
      return null;
    }
  }

  Future<void> addWorkshop() async {
    log('add 1');
    try {
      final response = await supabase.from('workshop_group').insert({
        'title' : 'hey from supabase !!',
        'image' : 'https://zedjjijsfzjenhezfxlt.supabase.co/storage/v1/object/public/organizer_images/public/pasta%20making.png',
        'description' : 'helo im desc',
        'category_id' : '6dd02c50-016c-4bc9-8d90-61354d9677d8',
        'targeted_audience' : 'shaghaf',
        'organizer_id' : GetIt.I.get<AuthLayer>().organizer!.organizerId
      }).select();
      log(response.first['workshop_group_id']);
      await addSingleWorkshop(response.first['workshop_group_id']);
    } catch (e) {
      log('message ${e.toString()}');
    }
  }

  Future<void> addSingleWorkshop(String workshopGroupId) async {
    log('add 2');
    log(workshopGroupId);
    try {
      await supabase.from('workshop').insert({
        'date' : '2024-11-17',
        'from_time' : '10:00',
        'to_time' : '12:00',
        'price' : 151,
        'number_of_seats' : 12,
        'available_seats' : 12,
        'instructor_name' : 'yso kh',
        'instructor_image' : 'https://zedjjijsfzjenhezfxlt.supabase.co/storage/v1/object/public/organizer_images/public/pasta%20making.png',
        'instructor_description' : 'hi hi im inst desc',
        'is_online' : false,
        'workshop_group_id' : workshopGroupId
      });
      log('$workshopGroupId successfull');
    } catch (e) {
      log(e.toString());
    }
  }
  submitRating(
      {required String workshopGroupId,
      required double rating,
      String? comment}) async {
    try {
      await supabase.from('review').insert({
        'rating': rating,
        'comments': comment,
        'workshop_group_id': workshopGroupId,
        'user_id': GetIt.I.get<AuthLayer>().user!.userId,
      }).select();
    } catch (e) {
      log("Error submit rating: $e");
    }
  }
}
