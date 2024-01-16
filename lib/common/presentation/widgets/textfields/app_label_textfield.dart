import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theta_chat/common/constants/app_core_constant.dart';
import 'package:theta_chat/config/theme.dart';

/// базовый виджет для работы текст филдом
class AppLabelTextFieldWidget extends StatefulWidget {
  const AppLabelTextFieldWidget({
    Key? key,
    this.color,
    this.label,
    this.value,
    this.autofillHints,
    this.onValueChanged,
    this.isEnabled = true,
    this.onShowTrailingWhen,
    this.trailingOnCompleted,
    this.onShowTrailing,
    this.trailing,
    this.isPassword,
    this.controller,
    this.inputType,
    this.focusNode,
    this.errorMessage,
    this.maxLength,
    this.textInputAction,
    this.contentPadding,
    this.fontSize,
    this.fontWeight,
    this.onTap,
    this.labelWidget,
    this.textInputFormatters,
    this.prefixIconPath,
    this.sufixIconPath,
    this.hintTextValue,
    this.onSubmitted,
    this.autofocus = false,
    this.labelStyle,
    this.borderRadius = const BorderRadius.all(Radius.circular(24)),
  }) : super(key: key);

  final bool autofocus;

  /// цвет контенера
  final Color? color;

  /// лайдел текстового поля
  final String? label;

  /// лайдел виджет текстового поля
  final Widget? labelWidget;

  /// значение текстового поля
  final String? value;

  /// слушатель при вводе значение в текстовое поле
  final ValueChanged<String>? onValueChanged;

  /// автивное/неактивное текстовое поле
  final bool isEnabled;

  /// функция по условию
  final bool Function(String value)? onShowTrailingWhen;

  /// Вызывается, когда пользователь указывает,
  /// что он закончил редактировать текст в поле.
  final Function(String value)? onSubmitted;

  /// виджет справой стороны при условии [onShowTrailingWhen]
  final Widget? trailingOnCompleted;

  /// событие при показе [trailing]
  final Function()? onShowTrailing;

  /// виджет справой стороны
  final Widget? trailing;

  /// флаг для опередения пароля (ЕСЛИ УКАЗАН ДАННЫЙ ФЛАГ,
  /// ТО ДРУГИЕ ИКОНКИ С ЛЕВОЙ СТОРОНЫ НЕ БУДУТ ОТОБРАЖАТЬСЯ)
  final bool? isPassword;

  /// контроллер для ввода текста
  final TextEditingController? controller;

  /// указываем тип поля
  final TextInputType? inputType;

  final FocusNode? focusNode;

  /// сообщение об ошибке
  final String? errorMessage;

  /// максимальная длина символов
  final int? maxLength;

  /// показывает action на кравиатуре, работает во всмеми типами кроме int
  final TextInputAction? textInputAction;

  /// добавляет паддинг для контента(label или text)
  final EdgeInsetsGeometry? contentPadding;

  /// радиус округления
  final BorderRadius borderRadius;

  /// размер шрифта, который пишет пользователь
  final double? fontSize;

  /// толщина шрифта, который пишет пользователь
  final FontWeight? fontWeight;

  /// событие нажатия по полю
  final Function()? onTap;

  /// форматтируем текст по запросу
  final List<TextInputFormatter>? textInputFormatters;

  /// путь для prefix иконки
  final String? prefixIconPath;

  /// путь для sufix иконки
  final String? sufixIconPath;

  /// указываем текст подсказки
  final String? hintTextValue;

  final Iterable<String>? autofillHints;

  final TextStyle? labelStyle;

  @override
  State<AppLabelTextFieldWidget> createState() => _AppLabelTextFieldWidgetState();
}

class _AppLabelTextFieldWidgetState extends State<AppLabelTextFieldWidget> {
  /// флаг указывающий на скрыть/паказать пароль
  var _isViewPassword = false;

  bool _isViewTrailing = false;

  // Color for border
  Color _borderColor = AppColors.grey200;

  // Use it to change color for border when textFiled in focus
  late FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _borderColor = _focusNode.hasFocus ? AppColors.primary : AppColors.grey200;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 16, top: 6, bottom: 4),
          decoration: BoxDecoration(
            color: widget.color ?? Colors.transparent,
            border: Border.all(
              color: _borderColor,
            ),
            borderRadius: widget.borderRadius,
          ),
          child: TextField(
            key: widget.key,
            autofocus: widget.autofocus,
            autofillHints: widget.autofillHints,
            onTap: () => widget.onTap?.call(),
            textInputAction: widget.textInputAction,
            focusNode: _focusNode,
            onChanged: _onValueChanged,
            style: AppTextStyle.body1,
            maxLength: widget.maxLength,
            obscureText: widget.isPassword ?? false ? !_isViewPassword : false,
            controller: widget.controller,
            onSubmitted: widget.onSubmitted,
            inputFormatters: widget.textInputFormatters,
            obscuringCharacter: '*',
            decoration: InputDecoration(
              isDense: true,
              label: widget.labelWidget,
              hintText: widget.hintTextValue,
              hintStyle: AppTextStyle.body1.copyWith(
                color: AppColors.secondary,
              ),
              suffixIcon: _getTrailingWidget(),
              labelText: widget.label,
              border: InputBorder.none,
              counterText: CoreConstant.empty,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              labelStyle: widget.labelStyle ??
                  AppTextStyle.caption1.copyWith(
                    color: widget.errorMessage?.isNotEmpty == true
                        ? AppColors.error500
                        : AppColors.secondary,
                  ),
              contentPadding: widget.contentPadding ?? const EdgeInsets.only(top: 4),
            ),
            keyboardType: widget.inputType ?? TextInputType.text,
            enabled: widget.isEnabled,
          ),
        ),
        Visibility(
          visible: widget.errorMessage?.isNotEmpty ?? false,
          child: Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Text(
              _getErrorMessage(),
              style: AppTextStyle.body2.copyWith(
                color: AppColors.error500,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ],
    );
  }

  /// выводит ошибку
  String _getErrorMessage() {
    final errorMessage = widget.errorMessage ?? CoreConstant.empty;
    return errorMessage;
  }

  /// при вводе значение в текстовое поле
  void _onValueChanged(String value) {
    final isPassword = widget.isPassword ?? false;
    final isShowTrailing = widget.onShowTrailingWhen?.call(value) ?? false;

    if (!isPassword) {
      if (isShowTrailing) {
        widget.onShowTrailing?.call();
        _isViewTrailing = true;
      } else {
        _isViewTrailing = false;
      }
      setState(() {});
    }

    final controller = widget.controller;
    final onValueChanged = widget.onValueChanged;

    onValueChanged?.call(
      controller?.value.text ?? value,
    );
  }

  Widget _getTrailingWidget() {
    final isPassword = widget.isPassword ?? false;
    final isError = widget.errorMessage?.isNotEmpty == true;

    if (isError) {
      return SvgPicture.asset(
        AppIcons.icInformationFilled,
        fit: BoxFit.none,
        width: 8,
      );
    } else if (isPassword) {
      return Padding(
        padding: const EdgeInsets.only(right: 22),
        child: InkWell(
          onTap: () {
            setState(() {
              _isViewPassword = !_isViewPassword;
            });
          },
          child: SvgPicture.asset(
            AppIcons.icVisibleOutline,
            color: AppColors.grey500,
          ),
        ),
      );
    }

    if (_isViewTrailing) {
      return widget.trailingOnCompleted ?? const SizedBox();
    }
    return widget.trailing ?? const SizedBox();
  }
}

class AppTextFieldIcon {
  AppTextFieldIcon({
    this.icon,
    this.height,
    this.width,
  });

  final String? icon;
  final double? width;
  final double? height;
}
