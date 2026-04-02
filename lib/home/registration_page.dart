import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lottie/lottie.dart';

import '../auth/bloc/auth_bloc.dart';
import '../auth/bloc/auth_event.dart';
import '../auth/bloc/auth_state.dart';
import '../constant/colors.dart';
import '../constant/text_styles_value.dart';
import 'home_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            RegisterRequested(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
              phone: phoneController.text.trim(),
              name: nameController.text.trim(),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthSuccess) {
          // Показываем анимацию успеха
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => Center(
              child: SizedBox(
                width: 160,
                height: 160,
                child: Lottie.asset(
                  'assets/lottie/success.json',
                  repeat: false,
                ),
              ),
            ),
          );

          await Future.delayed(const Duration(seconds: 1));
          if (!context.mounted) return;
          Navigator.of(context).pop();

          // Переходим на HomePage с данными пользователя
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => HomePage(
                name: nameController.text.trim(),
                email: emailController.text.trim(),
                phone: phoneController.text.trim(),
              ),
            ),
          );
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.secondary,
          title: Text("registration_page".tr(), style: AppTextStyles.px10blue),
          actions: [
            IconButton(
              icon: const Text("EN"),
              onPressed: () => context.setLocale(const Locale('en')),
            ),
            IconButton(
              icon: const Text("RU"),
              onPressed: () => context.setLocale(const Locale('ru')),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "name".tr(),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      (value == null || value.isEmpty) ? "name_empty".tr() : null,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "email".tr(),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return "email_empty".tr();
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) return "email_invalid".tr();
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "phone".tr(),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return "phone_empty".tr();
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) return "phone_invalid".tr();
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  decoration: InputDecoration(
                    labelText: "password".tr(),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(obscurePassword ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => obscurePassword = !obscurePassword),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return "password_empty".tr();
                    if (value.length < 6) return "password_short".tr();
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: obscureConfirmPassword,
                  decoration: InputDecoration(
                    labelText: "confirm_password".tr(),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () => setState(() => obscureConfirmPassword = !obscureConfirmPassword),
                    ),
                  ),
                  validator: (value) {
                    if (value != passwordController.text) return "password_mismatch".tr();
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return Center(
                        child: SizedBox(
                          width: 120,
                          height: 120,
                          child: Lottie.asset('assets/lottie/loading.json'),
                        ),
                      );
                    }

                    return ElevatedButton(
                      onPressed: submitForm,
                      child: Text("register".tr()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}