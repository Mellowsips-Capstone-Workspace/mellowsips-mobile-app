import 'package:configs/configs.dart';
import 'package:data/src/network/network_service.dart';
import 'package:data/src/raws/base_raw.dart';
import 'package:data/src/sources/local/base_local_data_source.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class NotificationWebSocket {
  final AuthLocalDataSource _authLocalDataSource;
  StompClient? _stompClient;

  NotificationWebSocket(this._authLocalDataSource);

  Future<void> _initialize({
    Function? onReceiveGlobalNotification,
    Function? onReceiveUserNotification,
  }) async {
    if (_stompClient != null) return;

    final tokens = await _authLocalDataSource.getTokens();

    Map<String, String>? header;

    if (tokens.netData?.accessToken != null) {
      header = {
        'Authorization': tokens.netData!.accessToken,
      };
    }

    _stompClient = StompClient(
      config: StompConfig.sockJS(
        url: '${BuildConfig.apiDomain}/ws',
        stompConnectHeaders: header,
        webSocketConnectHeaders: header,
        onConnect: (p0) {
          onConnectHandler(
            p0,
            onReceiveGlobalNotification: onReceiveGlobalNotification,
            onReceiveUserNotification: onReceiveUserNotification,
          );
        },
      ),
    );
  }

  Future<AppObjectResultRaw<EmptyRaw>> connect({
    Function? onReceiveGlobalNotification,
    Function? onReceiveUserNotification,
  }) async {
    await _initialize(
      onReceiveGlobalNotification: onReceiveGlobalNotification,
      onReceiveUserNotification: onReceiveUserNotification,
    );
    _stompClient?.activate();

    return Future.value(
      AppObjectResultRaw(
        netData: EmptyRaw(),
      ),
    );
  }

  void onConnectHandler(
    StompFrame frame, {
    Function? onReceiveGlobalNotification,
    Function? onReceiveUserNotification,
  }) async {
    _stompClient?.subscribe(
      destination: ApiProvider.notificationSocket,
      callback: (frame) {
        onReceiveGlobalNotification?.call(frame);
      },
    );

    _stompClient?.subscribe(
      destination: ApiProvider.userNotificationSocket,
      callback: (frame) {
        onReceiveUserNotification?.call(frame);
      },
    );
  }
}