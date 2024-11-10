import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../../core/network/HoemSevice.dart';
import '../../home/logic/logic_home/home_cubit.dart';
import '../../product/model/Product.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  HomeCubit homeCubit;
  SearchCubit(this.homeCubit) : super(SearchInitial());

  Future SearchProduct(String searchString) async {
   if(searchString.isEmpty) return;

    try {
      emit(SearchLoading());

      final currentstate = homeCubit.state;

      if (currentstate is HomeSucces) {
        final allproduct = currentstate.products;
       final result =  allproduct.where((product) {
          final title = product.title.toLowerCase();
          return title.contains(searchString.toLowerCase());
        }).toList();

        // if result is empyt go to api
        // cal searchProducts

        emit(SearchSuccess(result));
      }

    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
