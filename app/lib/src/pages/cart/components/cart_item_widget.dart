import 'package:app/src/components/main/dataImage/data_image_widget.dart';
import 'package:app/src/components/main/text/app_text_base_builder.dart';
import 'package:app/src/config/app_theme.dart';
import 'package:app/src/exts/app_exts.dart';
import 'package:app/src/pages/cart/cart_controller.dart';
import 'package:app/src/routes/app_pages.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:resources/resources.dart';
import 'package:utilities/utilities.dart';

class CartItemWidget extends GetView<CartController> {
  final CartItemModel cartItem;
  final Function refreshCarts;

  const CartItemWidget({
    super.key,
    required this.cartItem,
    required this.refreshCarts,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: ValueKey(cartItem.id),
      padding: EdgeInsets.only(
        bottom: AppThemeExt.of.majorMarginScale(
          4,
        ),
      ),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 1 / 2,
          children: [
            Expanded(
              child: InkWell(
                onTap: () async {
                  await Get.toNamed(
                    Routes.productDetail,
                    arguments: {
                      AppConstants.isEditing: true,
                      CartParamKey.productId: cartItem.product.id,
                      CartParamKey.cartItemId: cartItem.id,
                      CartParamKey.quantity: cartItem.quantity,
                      CartParamKey.note: cartItem.note,
                      CartParamKey.addons: cartItem.addons,
                    },
                  );

                  refreshCarts();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppThemeExt.of.majorPaddingScale(4),
                  ),
                  margin: EdgeInsets.only(
                    left: AppThemeExt.of.majorPaddingScale(4),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.of.greenColor[50],
                    borderRadius: BorderRadius.circular(
                      AppThemeExt.of.majorScale(4),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.edit,
                      color: AppColors.of.greenColor,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  controller.deleteCartItem(cartItem.id);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppThemeExt.of.majorPaddingScale(4),
                  ),
                  margin: EdgeInsets.only(
                    left: AppThemeExt.of.majorPaddingScale(4),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.of.redColor[50],
                    borderRadius: BorderRadius.circular(
                      AppThemeExt.of.majorScale(4),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.delete_outline_rounded,
                      color: AppColors.of.redColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppThemeExt.of.majorPaddingScale(4),
            vertical: AppThemeExt.of.majorPaddingScale(4),
          ),
          decoration: BoxDecoration(
            color: AppColors.of.whiteColor,
            borderRadius: BorderRadius.circular(AppThemeExt.of.majorScale(4)),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.11),
                blurRadius: 16,
                offset: Offset(0, -4),
              ),
            ],
          ),
          child: Row(
            children: [
              DataImageWidget(
                width: AppThemeExt.of.majorScale(72 / 4),
                height: AppThemeExt.of.majorScale(72 / 4),
                borderRadius: BorderRadius.circular(
                  AppThemeExt.of.majorScale(3),
                ),
                imageData: cartItem.product.coverImageData,
              ),
              SizedBox(
                width: AppThemeExt.of.majorScale(4),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextBody1Widget()
                        .setText(cartItem.product.name)
                        .setTextStyle(AppTextStyleExt.of.textBody1s)
                        .build(context),
                    SizedBox(
                      height: AppThemeExt.of.majorScale(2 / 4),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (cartItem.addons.isNotEmpty)
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: AppThemeExt.of.majorScale(40),
                            ),
                            child: AppTextBody2Widget()
                                .setText(cartItem.addons
                                    .map((e) => e.name)
                                    .join(', '))
                                .setTextOverFlow(TextOverflow.ellipsis)
                                .setColor(AppColors.of.subTextColor)
                                .build(context),
                          ),
                        if (cartItem.addons.isNotEmpty)
                          AppTextBody2Widget()
                              .setText('-')
                              .setTextOverFlow(TextOverflow.ellipsis)
                              .setColor(AppColors.of.subTextColor)
                              .build(context),
                        if (cartItem.note.isNotEmpty)
                          Expanded(
                            child: AppTextBody2Widget()
                                .setText(cartItem.note.isNotEmpty
                                    ? cartItem.note
                                    : '')
                                .setTextOverFlow(TextOverflow.ellipsis)
                                .setColor(AppColors.of.subTextColor)
                                .build(context),
                          ),
                      ],
                    ),
                    SizedBox(
                      height: AppThemeExt.of.majorScale(6 / 4),
                    ),
                    Row(
                      children: [
                        AppTextBody2Widget()
                            .setText(
                                '${NumberExt.withSeparator(cartItem.tempPrice / cartItem.quantity)}đ')
                            .setTextStyle(AppTextStyleExt.of.textBody2s)
                            .setColor(AppColors.of.secondaryColor)
                            .build(context),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: AppThemeExt.of.majorScale(2),
                          ),
                          height: AppThemeExt.of.majorScale(3 / 4),
                          width: AppThemeExt.of.majorScale(3 / 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.of.grayColor[500],
                          ),
                        ),
                        AppTextBody2Widget()
                            .setText('${cartItem.quantity} ${R.strings.items}')
                            .build(context),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
