import 'package:app/src/components/features/appBar/app_bar_basic_widget.dart';
import 'package:app/src/components/main/button/app_button_base_builder.dart';
import 'package:app/src/components/main/overlay/app_loading_overlay_widget.dart';
import 'package:app/src/components/main/text/app_text_base_builder.dart';
import 'package:app/src/components/page/app_main_page_base_builder.dart';
import 'package:app/src/config/app_theme.dart';
import 'package:app/src/exts/app_exts.dart';
import 'package:app/src/routes/app_pages.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resources/resources.dart';

part 'order_status_page.dart';
part 'order_status_binding.dart';

class OrderStatusController extends GetxController {
  final GetOrderDetailUseCase _getOrderDetailUseCase;

  OrderStatusController(this._getOrderDetailUseCase);

  Rxn<OrderModel> order = Rxn<OrderModel>();

  Future<void> getOrderDetail() async {
    final orderId = Get.arguments as String;

    try {
      AppLoadingOverlayWidget.show();

      final result = await _getOrderDetailUseCase.executeObject(
        param: GetOrderDetailParam(
          orderId: orderId,
        ),
      );

      if (result.netData != null) {
        order.value = result.netData;
      }

      AppLoadingOverlayWidget.dismiss();
    } on AppException catch (e) {
      AppLoadingOverlayWidget.dismiss();
      AppExceptionExt(appException: e).detected();
    }
  }
}
