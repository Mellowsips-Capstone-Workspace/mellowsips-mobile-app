part of 'app_main_page_base_builder.dart';

class AppMainPageWidget extends AppMainPageBaseBuilder {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(Get.context!).requestFocus(FocusNode()),
      child: Scaffold(
        key: _key,
        backgroundColor: _backgroundColor ?? AppColors.of.grayColor[2],
        appBar: _appBar,
        endDrawer: _endDrawer,
        endDrawerEnableOpenDragGesture: false,
        onEndDrawerChanged: _onEndDrawerChanged,
        resizeToAvoidBottomInset: _resizeToAvoidBottomInset ?? false,
        floatingActionButton: _floatingActionButton,
        floatingActionButtonLocation: _floatingActionButtonLocation,
        bottomNavigationBar: _bottomNavigationBar,
        body: _body ?? const SizedBox(),
      ),
    );
  }

  @override
  AppMainPageBaseBuilder setBackgroundColor(Color? backgroundColor) {
    _backgroundColor = backgroundColor;
    return this;
  }

  @override
  AppMainPageBaseBuilder setBody(Widget? body) {
    _body = body;
    return this;
  }

  @override
  AppMainPageBaseBuilder setEndDrawer(Widget? endDrawer) {
    _endDrawer = endDrawer;
    return this;
  }

  @override
  AppMainPageBaseBuilder setEndDrawerChanged(
      void Function(bool p1)? onEndDrawerChanged) {
    _onEndDrawerChanged = onEndDrawerChanged;
    return this;
  }

  @override
  AppMainPageBaseBuilder setKey(Key? key) {
    _key = key;
    return this;
  }

  @override
  AppMainPageBaseBuilder setAppBar(PreferredSizeWidget? appBar) {
    _appBar = appBar;
    return this;
  }

  @override
  AppMainPageBaseBuilder setResizeToAvoidBottomInset(
      bool? resizeToAvoidBottomInset) {
    _resizeToAvoidBottomInset = resizeToAvoidBottomInset;
    return this;
  }

  @override
  AppMainPageBaseBuilder setFloatingActionButton(Widget? floatingActionButton) {
    _floatingActionButton = floatingActionButton;
    return this;
  }

  @override
  AppMainPageBaseBuilder setFloatingActionButtonLocation(
    FloatingActionButtonLocation? floatingActionButtonLocation,
  ) {
    _floatingActionButtonLocation = floatingActionButtonLocation;
    return this;
  }

  @override
  AppMainPageBaseBuilder setBottomNavigationBar(
    Widget? bottomNavigationBar,
  ) {
    _bottomNavigationBar = bottomNavigationBar;
    return this;
  }
}
