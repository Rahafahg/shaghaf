import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shaghaf/data_layer/data_layer.dart';
import 'package:shaghaf/data_layer/supabase_layer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(AdminInitial()) {
    on<GetAdminDataEvent>((event, emit) async {
      emit(LoadingState());
      try {
        await GetIt.I.get<SupabaseLayer>().getAllCategories();
        await GetIt.I.get<SupabaseLayer>().getAllWorkshops();
        await GetIt.I.get<SupabaseLayer>().getAllBookings();
        groupworkshopsByCategory(GetIt.I.get<DataLayer>().allWorkshops);
        emit(SuccessState());
      } catch (e) {
        emit(ErrorState(msg: 'something went wrong'));
      }
    });
  }
}
