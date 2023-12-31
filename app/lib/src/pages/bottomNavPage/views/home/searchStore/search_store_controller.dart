import 'dart:math';

import 'package:app/src/components/main/button/app_button_base_builder.dart';
import 'package:app/src/components/main/listView/app_list_view_controller.dart';
import 'package:app/src/components/main/text/app_text_base_builder.dart';
import 'package:app/src/components/main/textField/app_text_field_base_builder.dart';
import 'package:app/src/components/page/app_main_page_base_builder.dart';
import 'package:app/src/config/app_theme.dart';
import 'package:app/src/exts/app_exts.dart';
import 'package:app/src/routes/app_pages.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resources/resources.dart';

part './search_store_page.dart';
part './search_store_binding.dart';

class SearchStoreKey {
  static const hasPromo = 'hasPromo';
  static const isOpen = 'isOpen';
  static const filter = 'filter';
  static const isActive = 'isActive';
  static const keyword = 'keyword';
  static const search = 'search';
}

class SearchStoreController extends AppListViewController<StoreModel> {
  final SearchStoresUseCase _searchStoresUseCase;

  Rx<String> keyword = ''.obs;

  SearchStoreController(
    this._searchStoresUseCase,
  );

  @override
  Future<AppPaginationListResultModel<StoreModel>> onCall(
    AppListParam appListParam,
  ) async {
    final response = await _searchStoresUseCase.executePaginationList(
      param: SearchStoresParam(
        criteria: {
          SearchStoreKey.filter: {
            SearchStoreKey.isActive: true,
          },
          SearchStoreKey.keyword: keyword.value,
        },
        pagination: AppListParam(
          page: appListParam.page,
          itemsPerPage: appListParam.itemsPerPage,
        ).toJson,
      ),
    );

    return Future(
      () => AppPaginationListResultModel(
        netData: response.netData,
        hasMore: response.hasMore,
        total: response.total,
      ),
    );
  }
}
