abstract class AuthEvent {}

class RegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String phone;

  RegisterRequested({
    required this.name,
    required this.email,
    required this.phone, required String password,
  });
}