part of '../base_param.dart';

@JsonSerializable()
@CopyWith()
class CreateOrderParam extends BaseParam {
  final String cartId;
  final String? qrCode;
  final String? qrId;
  final String initialTransactionMethod;
  final List<String?> vouchers;

  CreateOrderParam({
    required this.cartId,
    this.qrCode,
    this.qrId,
    required this.initialTransactionMethod,
    this.vouchers = const [],
  });

  factory CreateOrderParam.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderParamFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrderParamToJson(this);
}
