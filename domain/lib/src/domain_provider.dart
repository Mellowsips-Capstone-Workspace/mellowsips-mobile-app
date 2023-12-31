import 'package:domain/src/useCases/base_use_case.dart';
import 'package:get/get.dart';

class DomainProvider {
  static void inject() {
    Get.put<GetTestUseCase>(GetTestUseCaseImpl(Get.find()));
    Get.put<GetLocalTestUseCase>(GetLocalTestUseCaseImpl(Get.find()));
    Get.put<SaveLocalTestUseCase>(SaveLocalTestUseCaseImpl(Get.find()));

    // Auth
    Get.put<LoginUseCase>(LoginUseCaseImpl(Get.find()));
    Get.put<RegisterUseCase>(RegisterUseCaseImpl(Get.find()));
    Get.put<VerifyRegistrationUseCase>(
      VerifyRegistrationUseCaseImpl(Get.find()),
    );
    Get.put<RequestOtpUseCase>(RequestOtpUseCaseImpl(Get.find()));
    Get.put<LogoutUseCase>(LogoutUseCaseImpl(Get.find()));
    Get.put<GetTokensUseCase>(GetTokensUseCaseImpl(Get.find()));
    Get.put<ChangePasswordUseCase>(ChangePasswordUseCaseImpl(Get.find()));

    // Document
    Get.put<GetDocumentUseCase>(GetDocumentUseCaseImpl(Get.find()));

    // Store
    Get.put<GetStoreListUseCase>(GetStoreListUseCaseImpl(Get.find()));
    Get.put<SearchStoresUseCase>(SearchStoresUseCaseImpl(Get.find()));
    Get.put<GetStoreMenuUseCase>(GetStoreMenuUseCaseImpl(Get.find()));
    Get.put<GetStoreDetailUseCase>(GetStoreDetailUseCaseImpl(Get.find()));

    // Product
    Get.put<GetProductDetailUseCase>(GetProductDetailUseCaseImpl(Get.find()));

    // Cart
    Get.put<GetAllCartUseCase>(GetAllCartUseCaseImpl(Get.find()));
    Get.put<AddToCartUseCase>(AddToCartUseCaseImpl(Get.find()));
    Get.put<GetCartDetailUseCase>(GetCartDetailUseCaseImpl(Get.find()));
    Get.put<DeleteCartUseCase>(DeleteCartUseCaseImpl(Get.find()));
    Get.put<DeleteCartItemUseCase>(DeleteCartItemUseCaseImpl(Get.find()));
    Get.put<UpdateCartItemUseCase>(UpdateCartItemUseCaseImpl(Get.find()));
    Get.put<CalculateCartWithVouchersUseCase>(
      CalculateCartWithVouchersUseCaseImpl(Get.find()),
    );

    // Voucher
    Get.put<GetCartVouchersUseCase>(GetCartVouchersUseCaseImpl(Get.find()));

    // Order
    Get.put<GetOrderDetailUseCase>(GetOrderDetailUseCaseImpl(Get.find()));
    Get.put<CreateOrderUseCase>(CreateOrderUseCaseImpl(Get.find()));
    Get.put<UpdateOrderStatusUseCase>(UpdateOrderStatusUseCaseImpl(Get.find()));
    Get.put<SearchOrdersUseCase>(SearchOrdersUseCaseImpl(Get.find()));
    Get.put<GetTransactionByOrderIdUseCase>(
      GetTransactionByOrderIdUseCaseImpl(Get.find()),
    );

    // Notification
    Get.put<SubscribeNotificationsUseCase>(
      SubscribeNotificationsUseCaseImpl(Get.find()),
    );
    Get.put<UnsubscribeNotificationsUseCase>(
      UnsubscribeNotificationsUseCaseImpl(Get.find()),
    );
    Get.put<SearchNotificationsUseCase>(
      SearchNotificationsUseCaseImpl(Get.find()),
    );
    Get.put<MarkNotificationAsReadUseCase>(
      MarkNotificationAsReadUseCaseImpl(Get.find()),
    );
    Get.put<MarkAllNotificationAsReadUseCase>(
      MarkAllNotificationAsReadUseCaseImpl(Get.find()),
    );

    // Review
    Get.put<CreateStoreReviewUseCase>(
      CreateStoreReviewUseCaseImpl(Get.find()),
    );
    Get.put<SearchStoreReviewsUseCase>(
      SearchStoreReviewsUseCaseImpl(Get.find()),
    );

    // Home
    Get.put<GetCoffeeStoreListUseCase>(
      GetCoffeeStoreListUseCaseImpl(Get.find()),
    );
    Get.put<GetMilkTeaStoreListUseCase>(
      GetMilkTeaStoreListUseCaseImpl(Get.find()),
    );
    Get.put<GetQualifiedStoreListUseCase>(
      GetQualifiedStoreListUseCaseImpl(Get.find()),
    );
    Get.put<GetPromotingStoreListUseCase>(
      GetPromotingStoreListUseCaseImpl(Get.find()),
    );
    Get.put<GetBestSellingProductsUseCase>(
      GetBestSellingProductsUseCaseImpl(Get.find()),
    );

    // Profile
    Get.put<GetProfileUseCase>(
      GetProfileUseCaseImpl(Get.find()),
    );
    Get.put<UpdateProfileUseCase>(
      UpdateProfileUseCaseImpl(Get.find()),
    );
  }
}
