import 'dart:math';

import 'package:app/src/components/main/button/app_button_base_builder.dart';
import 'package:app/src/components/main/dataImage/data_image_widget.dart';
import 'package:app/src/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app/src/components/main/overlay/app_loading_overlay_widget.dart';
import 'package:app/src/components/main/text/app_text_base_builder.dart';
import 'package:app/src/components/page/app_main_page_base_builder.dart';
import 'package:app/src/config/app_theme.dart';
import 'package:app/src/exts/app_exts.dart';
import 'package:app/src/pages/store/storeDetail/components/product_item_widget.dart';
import 'package:app/src/routes/app_pages.dart';
import 'package:domain/domain.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:resources/resources.dart';
import 'package:utilities/utilities.dart';

part './store_detail_page.dart';
part './store_detail_binding.dart';

class StoreDetailController extends GetxController {
  final GetStoreMenuUseCase _getStoreMenuUseCase;
  final GetStoreDetailUseCase _getStoreDetailUseCase;
  final GetDocumentUseCase _getDocumentUseCase;
  final GetAllCartUseCase _getAllCartUseCase;
  final GetTokensUseCase _getTokensUseCase;

  // final ScrollController scrollController = ScrollController();

  final _isStoreDetailLoad = false.obs;
  final _isStoreMenuLoad = false.obs;

  Rxn<StoreModel> store = Rxn<StoreModel>();
  Rxn<MenuModel> menu = Rxn<MenuModel>();
  Rx<int> numberOfCartItems = 0.obs;
  Rxn<String> cartId = Rxn<String>();
  Rx<bool> isLoggedIn = Rx<bool>(false);

  StoreDetailController(
    this._getStoreMenuUseCase,
    this._getStoreDetailUseCase,
    this._getDocumentUseCase,
    this._getAllCartUseCase,
    this._getTokensUseCase,
  );

  Future<void> getStoreDetail(
    String storeId,
  ) async {
    try {
      AppLoadingOverlayWidget.show();

      final result = await _getStoreDetailUseCase.executeObject(
        param: GetStoreDetailParam(
          storeId: storeId,
        ),
      );

      final storeData = result.netData;

      store.value = storeData;

      _isStoreDetailLoad.value = true;

      if (_isStoreMenuLoad.value) {
        if (Get.arguments[AppConstants.action] ==
            AppConstants.navigateToProduct) {
          Get.toNamed(
            Routes.productDetail,
            arguments: {
              AppConstants.productId: Get.arguments[AppConstants.productId]
            },
          );
        }
        AppLoadingOverlayWidget.dismiss();
      }

      store.value?.coverImageData = await AppImageExt.getImage(
        _getDocumentUseCase,
        store.value?.coverImage,
      );
    } on AppException catch (e) {
      AppLoadingOverlayWidget.dismiss();
      AppExceptionExt(appException: e).detected();
    }
  }

  Future<void> getStoreMenu(
    String storeId,
  ) async {
    try {
      AppLoadingOverlayWidget.show();

      final result = await _getStoreMenuUseCase.executeObject(
        param: GetStoreDetailParam(
          storeId: storeId,
        ),
      );

      final menuData = result.netData;

      menu.value = menuData;

      _isStoreMenuLoad.value = true;

      if (_isStoreDetailLoad.value) {
        if (Get.arguments?[AppConstants.action] ==
            AppConstants.navigateToProduct) {
          Get.toNamed(
            Routes.productDetail,
            arguments: {
              AppConstants.productId: Get.arguments[AppConstants.productId]
            },
          );
        }
        AppLoadingOverlayWidget.dismiss();
      }

      for (MenuSectionModel section in menu.value?.menuSections ?? []) {
        for (ProductModel product in section.products) {
          product.coverImageData = await AppImageExt.getImage(
            _getDocumentUseCase,
            product.coverImage,
          );
          menu.refresh();
        }
      }
    } on AppException catch (e) {
      AppLoadingOverlayWidget.dismiss();
      AppExceptionExt(appException: e).detected();
    }
  }

  Future<void> checkIsLoggedIn() async {
    try {
      final result = await _getTokensUseCase.executeObject();

      if (result.netData?.accessToken != null &&
          result.netData!.accessToken.isNotEmpty) {
        isLoggedIn.value = true;
        getNumberOfCartItems();
      }
    } on AppException catch (e) {
      AppLoadingOverlayWidget.dismiss();
      AppExceptionExt(appException: e).detected();
    }
  }

  Future<void> getNumberOfCartItems() async {
    try {
      AppLoadingOverlayWidget.show();
      numberOfCartItems.value = 0;
      cartId.value = null;
      final result = await _getAllCartUseCase.executeList();

      if (result.netData != null) {
        final cart = result.netData!
            .firstWhereOrNull((cart) => cart.store.id == store.value?.id);

        if (cart != null) {
          numberOfCartItems.value = cart.numberOfItems;
          cartId.value = cart.id;
        }
      }

      AppLoadingOverlayWidget.dismiss();
    } on AppException catch (e) {
      AppLoadingOverlayWidget.dismiss();
      AppExceptionExt(appException: e).detected();
    }
  }

  String voucherText(VoucherModel voucher) {
    String text = '';
    if (voucher.discountType == AppConstants.cash) {
      text = '${R.strings.discount} ${NumberExt.vndDisplay(voucher.value)}';
    } else {
      text = '${R.strings.discount} ${voucher.value}%';
    }

    if (voucher.maxDiscountAmount != null && voucher.maxDiscountAmount! > 0) {
      text +=
          ' ${R.strings.maximum} ${NumberExt.vndDisplay(voucher.maxDiscountAmount!)}';
    }

    return text;
  }
}
