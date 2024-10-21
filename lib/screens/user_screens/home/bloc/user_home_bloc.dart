import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:shaghaf/data_layer/supabase_layer.dart';
import 'package:shaghaf/models/workshop_model.dart';

part 'user_home_event.dart';
part 'user_home_state.dart';

class UserHomeBloc extends Bloc<UserHomeEvent, UserHomeState> {
  UserHomeBloc() : super(UserHomeInitial()) {
    on<GetWorkshopsEvent>((event, emit) async {
      List<WorkshopModel> workshops = [];
    final resp = await GetIt.I.get<SupabaseLayer>().supabase.from('workshop_group').select();
    workshops.clear();
    for (var element in resp) {
      workshops.add(WorkshopModel.fromJson(element));
    }
    log(resp.toString());
    emit(DataDoneState(workshops: workshops));
    });
  }
}
