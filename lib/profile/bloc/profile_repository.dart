import '../models/profile.dart';
import '../services/dio_client.dart';
import '../services/api_service.dart';

class ProfileRepository {
  final ApiService apiService;

  ProfileRepository({required this.apiService});

  Future<Profile> fetchProfile() async {
    final data = await apiService.getProfile();
    return Profile.fromJson(data as Map<String, dynamic>);
  }
}