part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final User user;
  ProfileLoaded(this.user);
}
class ProfileUpdating extends ProfileState {
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
