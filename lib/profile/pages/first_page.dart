import 'package:flutter/material.dart';
import 'package:flutter_application_7/profile/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/profile.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '/constant/colors.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late ProfileBloc profileBloc;

  @override
  void initState() {
    super.initState();
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    profileBloc.add(FetchedProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        title: const Text("Profile Info"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is LoadingProfileState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedProfileState) {
            final profile = state.profile;
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 5,
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.people),
                        title: Text(profile.userId.toString()),
                      ),
                      ListTile(
                        leading: const Icon(Icons.assignment_ind),
                        title: Text(profile.id.toString()),
                      ),
                      ListTile(
                        leading: const Icon(Icons.alternate_email),
                        title: Text(profile.title),
                      ),
                      ListTile(
                        leading: const Icon(Icons.phone),
                        title: Text(profile.body),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is FailureProfileState) {
            return const Center(child: Text("Failed to load profile"));
          }
          return Container();
        },
      ),
    );
  }
}