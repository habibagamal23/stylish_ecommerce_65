import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shtylishecommerce/core/di/di.dart';
import '../logic/profile_cubit.dart';
import '../model/user.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => gitit<ProfileCubit>()..loadProfile(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
          backgroundColor: Colors.red,
        ),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileError) {
              // Show an error message if there's an error
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is ProfileLoaded) {
              // Show a success message after profile is updated
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated successfully!')),
              );
            }
          },
          builder: (context, state) {
            if (state is ProfileLoading) {
              // Show loading indicator when loading data or saving changes
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoaded) {
              // Display the profile view with the latest data
              return _buildProfileView(context, state.user);
            } else if (state is ProfileError) {
              // Display an error message if there's an error
              return Center(child: Text(state.message));
            } else {
              // Display a default message if no data is available
              return const Center(child: Text("No data available"));
            }
          },
        ),
      ),
    );
  }

  Widget _buildProfileView(BuildContext context, User user) {
    final cubit = context.read<ProfileCubit>();

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
                  backgroundImage: NetworkImage(user.image ?? ''),
                  backgroundColor: Colors.grey,
                ),
                GestureDetector(
                  onTap: () async {
                    final picker = ImagePicker();
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.gallery);

                    if (pickedFile != null) {
                      String imageUrl = pickedFile.path;
                      await cubit.updateProfile(imageUrl: imageUrl);
                    }
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.red,
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
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildTextField(
              label: "Username", controller: cubit.usernameController),
          const SizedBox(height: 10),
          _buildTextField(label: "Email", controller: cubit.emailController),
          const SizedBox(height: 10),
          _buildTextField(
              label: "Password",
              controller: cubit.passwordController,
              obscureText: true),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              cubit.updateProfile();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
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

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool obscureText = false,
  }) {
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
