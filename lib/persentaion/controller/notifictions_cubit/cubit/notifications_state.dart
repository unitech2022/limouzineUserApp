part of 'notifications_cubit.dart';

class NotificationsState extends Equatable {
  final RequestState getNotificationsState;
  final List<NotificationModel> notifications;

  NotificationsState(
      {this.getNotificationsState = RequestState.loading,
      this.notifications = const []});

  @override
  List<Object> get props => [getNotificationsState, notifications];
}
