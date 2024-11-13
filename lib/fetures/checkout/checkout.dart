import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/helpers/spacing.dart';
import '../../core/widgets/textfieldcutom.dart';
import '../profile-setting/logic/profile_cubit.dart';
import 'addadress/map.dart';
import 'addadress/mapscreen.dart';
import 'logic/checkout_cubit.dart';
class ConfirmOrderScreen extends StatelessWidget {
  const ConfirmOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CheckoutCubit>();

    return Scaffold(
      appBar: AppBar(title: Text("Confirm Order")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Delivery Address", style: Theme.of(context).textTheme.labelLarge),
              SizedBox(height: 16),
          
              BlocBuilder<CheckoutCubit, CheckoutState>(
                builder: (context, state) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(15.sp)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        ListTile(
                          title: Text("Locate on the map", style: TextStyle(color: Colors.red)),
                          trailing: IconButton(
                            icon: Icon(Icons.location_on),
                            onPressed: () async {
                              final location = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MapScreen(
                                    onLocationSelected: (LatLng location) {
                                      cubit.setLocationFromMap(location);
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        vertical(20),
                        CustomFormTextField(
                          hintText: "Department",
                          labelText: 'Department',
                          controller: cubit.departmentController,
                        ),
                        vertical(20),
                        CustomFormTextField(
                          hintText: "Street",
                          labelText: 'Street',
                          controller: cubit.streetController,
                        ),
                        vertical(20),
                        CustomFormTextField(
                          hintText: "City",
                          labelText: 'City',
                          controller: cubit.cityController,
                        ),
                      ],
                    ),
                  );
                },
              ),
          
          
              vertical(20),
          
              ElevatedButton(
                onPressed: () {
                  // Add functionality to save address
                },
                child: Text("Save Address"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}