part of '../base_raw.dart';

@JsonSerializable()
@CopyWith()
class OrderRaw extends BaseRaw {
  final String id;
  final String status;
  final int finalPrice;
  final OrderDetailsRaw details;
  final OrderTransactionRaw? latestTransaction;
  final List<VoucherOrderRaw> voucherOrders;

  OrderRaw({
    required this.id,
    required this.status,
    required this.finalPrice,
    required this.details,
    required this.latestTransaction,
    required this.voucherOrders,
  });

  factory OrderRaw.fromJson(Map<String, dynamic> json) =>
      _$OrderRawFromJson(json);

  Map<String, dynamic> toJson() => _$OrderRawToJson(this);

  @override
  BaseModel toModel() {
    return OrderModel(
      id: id,
      status: status,
      finalPrice: finalPrice,
      details: details.toModel() as OrderDetailsModel,
      latestTransaction: latestTransaction?.toModel() as OrderTransactionModel?,
      voucherOrders:
          voucherOrders.map((e) => e.toModel() as VoucherOrderModel).toList(),
    );
  }
}
