import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../../core/network/HoemSevice.dart';
import '../../home/logic/logic_home/home_cubit.dart';
import '../../product/model/Product.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final HomeCubit homeCubit;
  final HomeService homeService;

  SearchCubit({required this.homeCubit, required this.homeService})
      : super(SearchInitial());

  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());
    final currentState = homeCubit.state;
    debugPrint('Current state type: ${currentState.runtimeType}');

    if (currentState is HomeSucces) {
      final allProducts = currentState.products;
      final searchResults = allProducts.where((product) {
        final name = product.title.toLowerCase();
        return name.contains(query.toLowerCase());
      }).toList();

      if (searchResults.isEmpty) {
        await _searchByApi(query);
      } else {
        emit(SearchSuccess(searchResults));
      }
    } else {
      debugPrint('Products not loaded in HomeCubit');
      await _searchByApi(query);
    }
  }

  Future<void> _searchByApi(String query) async {
    try {
      final products = await homeService.searchProducts(query);
      if (products.isEmpty) {
        emit(SearchEmpty());
      } else {
        emit(SearchSuccess(products));
      }
    } catch (e) {
      emit(SearchError("Failed to load search results: ${e.toString()}"));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
