//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class SearchScreen extends StatelessWidget {
//   const SearchScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => SearchCubit(homeCubit: getIt<HomeCubit>()),
//         ),
//       ],
//       child: const SearchScreenBody(),
//     );
//   }
// }