part of 'app_button_base_builder.dart';

class AppOutlinedButtonWidget extends AppButtonBaseBuilder {
  @override
  AppOutlinedButtonWidget setButtonText(String? buttonText) {
    _buttonText = buttonText;
    return this;
  }

  @override
  AppOutlinedButtonWidget setIsDisabled(bool isDisabled) {
    _isDisabled = isDisabled;
    return this;
  }

  @override
  AppOutlinedButtonWidget setOnPressed(void Function()? onPressed) {
    _onPressed = onPressed;
    return this;
  }

  @override
  AppOutlinedButtonWidget setPrefixIcon(Widget? prefixIcon) {
    _prefixIcon = prefixIcon;
    return this;
  }

  @override
  AppOutlinedButtonWidget setTextStyle(TextStyle? textStyle) {
    _textStyle = textStyle;
    return this;
  }

  @override
  AppOutlinedButtonWidget setAppButtonSize(AppButtonSize? appButtonSize) {
    _appButtonSize = appButtonSize;
    return this;
  }

  @override
  AppOutlinedButtonWidget setAppButtonType(AppButtonType? appButtonType) {
    _appButtonType = appButtonType;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    if (_prefixIcon == null && _buttonText == null) return const SizedBox();
    if (_appButtonType == AppButtonType.circle) {
      return _circle(context);
    }
    if (_appButtonType == AppButtonType.square) {
      return _square(context);
    }
    return _standard(context);
  }

  Widget _standard(BuildContext context) {
    return _prefixIcon != null
        ? OutlinedButton.icon(
            onPressed: _isDisabled == true ? null : _onPressed,
            style: _buttonStyle(context),
            icon: _prefixIcon!,
            label: AppTextBody1Widget()
                .setTextStyle(_textStyle ?? AppTextStyleExt.of.textBody1s)
                .setText(_buttonText!)
                .build(context),
          )
        : OutlinedButton(
            onPressed: _isDisabled == true ? null : _onPressed,
            style: _buttonStyle(context),
            child: AppTextBody1Widget()
                .setTextStyle(_textStyle ?? AppTextStyleExt.of.textBody1s)
                .setText(_buttonText!)
                .build(context),
          );
  }

  Widget _circle(BuildContext context) {
    double buttonPadding = AppThemeExt.of.majorScale(13 / 4);
    if (_appButtonSize == AppButtonSize.small) {
      buttonPadding = AppThemeExt.of.majorScale(5 / 4);
    }
    return _prefixIcon != null
        ? Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.of.borderColor)),
            child: InkWell(
              onTap: _onPressed,
              borderRadius: BorderRadius.all(
                  Radius.circular(AppThemeExt.of.majorScale(1))),
              focusColor: Colors.blue,
              child: Container(
                  padding: EdgeInsets.all(buttonPadding), child: _prefixIcon),
            ),
          )
        : Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.of.borderColor)),
            child: InkWell(
              borderRadius: BorderRadius.all(
                  Radius.circular(AppThemeExt.of.majorScale(1))),
              focusColor: Colors.blue,
              child: Container(
                  padding: EdgeInsets.all(buttonPadding),
                  child: Row(
                    children: [
                      AppTextBody1Widget().setText(_buttonText!).build(context)
                    ],
                  )),
            ),
          );
  }

  Widget _square(BuildContext context) {
    double width = AppThemeExt.of.majorScale(12);
    double height = AppThemeExt.of.majorScale(12);
    double horizontalPadding = AppThemeExt.of.majorScale(3);
    if (_appButtonSize == AppButtonSize.medium) {
      width = AppThemeExt.of.majorScale(10);
      height = AppThemeExt.of.majorScale(10);
      horizontalPadding = AppThemeExt.of.majorScale(2);
    }
    if (_appButtonSize == AppButtonSize.small) {
      width = AppThemeExt.of.majorScale(8);
      height = AppThemeExt.of.majorScale(8);
      horizontalPadding = AppThemeExt.of.majorScale(1);
    }

    return SizedBox(
        width: width,
        height: height,
        child: _prefixIcon != null
            ? OutlinedButton(
                onPressed: _isDisabled == true ? null : _onPressed,
                style: _buttonStyle(context)?.copyWith(
                  padding: MaterialStateProperty.resolveWith<EdgeInsets?>(
                    (Set<MaterialState> states) => EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                  ),
                ),
                child: _prefixIcon!,
              )
            : OutlinedButton(
                onPressed: _isDisabled == true ? null : _onPressed,
                style: _buttonStyle(context)?.copyWith(
                  padding: MaterialStateProperty.resolveWith<EdgeInsets?>(
                    (Set<MaterialState> states) => EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                  ),
                ),
                child:
                    AppTextBody1Widget().setText(_buttonText!).build(context),
              ));
  }

  ButtonStyle? _buttonStyle(BuildContext context) {
    double horizontalPadding = AppThemeExt.of.majorScale(4);
    double verticalPadding = AppThemeExt.of.majorScale(10 / 4);
    TextStyle? textStyle = _textStyle ?? AppTextStyleExt.of.textBody1m;

    if (_appButtonSize == AppButtonSize.medium) {
      horizontalPadding = AppThemeExt.of.majorScale(3);
      verticalPadding = AppThemeExt.of.majorScale(5 / 4);
      textStyle = _textStyle ?? AppTextStyleExt.of.textBody1m;
    }
    if (_appButtonType == AppButtonType.danger) {
      return AppButtonStyle.outlinedButtonDangerStyle?.copyWith(
        padding: MaterialStateProperty.resolveWith<EdgeInsets?>(
          (Set<MaterialState> states) => EdgeInsets.symmetric(
              horizontal: horizontalPadding, vertical: verticalPadding),
        ),
        textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
          (Set<MaterialState> states) => textStyle,
        ),
      );
    }
    return context.theme.outlinedButtonTheme.style?.copyWith(
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) => _backgroundColor,
      ),
      padding: MaterialStateProperty.resolveWith<EdgeInsets?>(
        (Set<MaterialState> states) => EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
      ),
      textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
        (Set<MaterialState> states) => textStyle,
      ),
    );
  }
}
