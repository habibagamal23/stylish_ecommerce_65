import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shtylishecommerce/core/colors.dart';
import 'package:shtylishecommerce/core/di/di.dart';
import '../logic/profile_cubit.dart';
import '../model/user.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: ColorsManager.mainRed,
      ),
      body: BlocProvider(
        create: (context) => gitit<ProfileCubit>()..loadProfile(),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileError) {
              return Center(child: Text(state.message));
            } else if (state is ProfileLoaded) {
              return _buildProfileView(context, state.user);
            } else {
              return const Center(child: Text("No data available"));
            }
          },
        ),
      ),
    );
  }

  Widget _buildProfileView(BuildContext context, User user) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(user.image),
                  backgroundColor: ColorsManager.mainRed,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: ColorsManager.mainRed,
                    shape: BoxShape.circle,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Username TextField
          _buildTextField(
              label: "Username",
              controller: context.read<ProfileCubit>().usernameController),
          const SizedBox(height: 10),

          // Email TextField
          _buildTextField(
              label: "Email",
              controller: context.read<ProfileCubit>().emailController),
          const SizedBox(height: 10),

          // Address TextField
          _buildTextField(
              label: "Address",
              controller: context.read<ProfileCubit>().addressController),
          const SizedBox(height: 10),

          // City TextField
          _buildTextField(
              label: "City",
              controller: context.read<ProfileCubit>().cityController),
          const SizedBox(height: 10),

          // Save Changes Button
          ElevatedButton(
            onPressed: () {
              // // Handle the update logic here
              // context.read<ProfileCubit>().updateProfile(
              //   username: _usernameController.text,
              //   email: _emailController.text,
              //   // Add other fields if needed
              // );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.mainRed,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Save Changes',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      {required String label,
      required TextEditingController controller,
      bool obscureText = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
