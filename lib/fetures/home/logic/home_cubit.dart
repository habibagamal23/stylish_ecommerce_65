import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shtylishecommerce/core/network/HoemSevice.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeService homeService;
  HomeCubit(this.homeService) : super(HomeInitial()) {
    getAllCategries();
  }

  late final catigres;
  Future getAllCategries() async {
    emit(HomeLoading());
    try {
      catigres = await homeService.getAllCategories();
      emit(HomeSucces(catigres));
    } catch (e) {
      emit(HomeErorr(e.toString()));
    }
  }
}
