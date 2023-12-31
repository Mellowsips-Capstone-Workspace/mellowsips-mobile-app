part of '../base_use_case.dart';

abstract class SearchStoresUseCase
    extends BaseUseCase<SearchStoresParam, StoreModel> {}

class SearchStoresUseCaseImpl extends SearchStoresUseCase {
  final StoreRepository _storeRepository;

  SearchStoresUseCaseImpl(this._storeRepository);

  @override
  Future<AppPaginationListResultModel<StoreModel>> executePaginationList({
    SearchStoresParam? param,
  }) {
    return _storeRepository.searchStores(params: param!.toJson());
  }
}
