import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_event.dart';
import 'profile_state.dart';
import 'profile_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;

  ProfileBloc({required this.repository}) : super(LoadingProfileState()) {
    on<FetchedProfileEvent>((event, emit) async {
      emit(LoadingProfileState());
      try {
        final profile = await repository.fetchProfile();
        emit(LoadedProfileState(profile: profile));
      } catch (e) {
        emit(FailureProfileState(error: e.toString()));
      }
    });
  }
}