import '../models/profile.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class LoadingProfileState extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Profile profile;

  ProfileLoaded({required this.profile});
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError({required this.message});

}

class LoadedProfileState extends ProfileState {
  final Profile profile;
  LoadedProfileState({required this.profile});
}

class FailureProfileState extends ProfileState {
  final String error;
  FailureProfileState({required this.error});
}
