part of 'admin_bloc.dart';

@immutable
sealed class AdminEvent {}

final class GetAdminDataEvent extends AdminEvent {}

final class ChooseOrgEvent extends AdminEvent {
  final OrganizerModel org;
  ChooseOrgEvent({required this.org});
}