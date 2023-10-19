import 'dart:math';

import 'package:app/src/components/main/dataImage/data_image_widget.dart';
import 'package:app/src/components/main/overlay/app_loading_overlay_widget.dart';
import 'package:app/src/components/main/text/app_text_base_builder.dart';
import 'package:app/src/components/page/app_main_page_base_builder.dart';
import 'package:app/src/config/app_theme.dart';
import 'package:app/src/pages/store/storeDetail/components/food_item_widget.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:resources/resources.dart';

part './store_detail_page.dart';
part './store_detail_binding.dart';

class StoreDetailController extends GetxController {
  final GetStoreMenuUseCase _getStoreMenuUseCase;
  final GetStoreDetailUseCase _getStoreDetailUseCase;
  final GetDocumentUseCase _getDocumentUseCase;

  final _isStoreDetailLoad = false.obs;
  final _isStoreMenuLoad = false.obs;

  Rxn<StoreModel> store = Rxn<StoreModel>();
  Rxn<MenuModel> menu = Rxn<MenuModel>();

  StoreDetailController(
    this._getStoreMenuUseCase,
    this._getStoreDetailUseCase,
    this._getDocumentUseCase,
  );

  Future<void> getStoreDetail() async {
    try {
      AppLoadingOverlayWidget.show();

      final result = await _getStoreDetailUseCase.executeObject(
        param: GetStoreDetailParam(
          storeId: Get.arguments as String,
        ),
      );

      final storeData = result.netData;

      store.value = storeData;

      _isStoreDetailLoad.value = true;

      if (_isStoreMenuLoad.value) {
        AppLoadingOverlayWidget.dismiss();
      }

      store.value?.coverImageData = await getImage(store.value?.coverImage);
    } catch (e) {
      AppLoadingOverlayWidget.dismiss();
      print(e);
    }
  }

  Future<void> getStoreMenu() async {
    try {
      AppLoadingOverlayWidget.show();

      final result = await _getStoreMenuUseCase.executeObject(
        param: GetStoreDetailParam(
          storeId: Get.arguments as String,
        ),
      );

      final menuData = result.netData;

      menu.value = menuData;

      _isStoreMenuLoad.value = true;

      if (_isStoreDetailLoad.value) {
        AppLoadingOverlayWidget.dismiss();
      }

      for (MenuSectionModel section in menu.value?.menuSections ?? []) {
        for (ProductModel product in section.products) {
          product.coverImageData = await getImage(product.coverImage);
          menu.refresh();
        }
      }
    } catch (e) {
      AppLoadingOverlayWidget.dismiss();
      print(e);
    }
  }

  Future<String?> getImage(String? imageId) async {
    if (imageId == null) return null;

    final splitId = imageId.split('|').last;

    final response = await _getDocumentUseCase.executeObject(
      param: GetDocumentParam(
        documentId: splitId,
      ),
    );

    return Future.value(response.netData!.content);
  }
}