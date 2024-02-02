import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theta_chat/common/presentation/widgets/app_bar/flex_app_bar.dart';
import 'package:theta_chat/common/presentation/widgets/app_hbox_widget.dart';
import 'package:theta_chat/common/presentation/widgets/app_loading_container.dart';
import 'package:theta_chat/common/presentation/widgets/app_terms_and_policy_widget.dart';
import 'package:theta_chat/common/presentation/widgets/buttons/app_filled_color_button.dart';
import 'package:theta_chat/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:theta_chat/common/presentation/widgets/keyboard_dismisser.dart';
import 'package:theta_chat/common/presentation/widgets/screen/app_adaptive_layout_screen.dart';
import 'package:theta_chat/common/presentation/widgets/snack_bars.dart';
import 'package:theta_chat/common/presentation/widgets/textfields/app_label_textfield.dart';
import 'package:theta_chat/config/theme.dart';
import 'package:theta_chat/feature/auth/change_password/presentation/ui/change_password_screen.dart';
import 'package:theta_chat/feature/auth/common/domain/entity/user_detail_entity.dart';
import 'package:theta_chat/feature/auth/common/presentation/controller/authentication_controller.dart';
import 'package:theta_chat/feature/auth/forget_password/presentation/ui/forget_password_screen.dart';
import 'package:theta_chat/feature/auth/update_user_data/presentation/controller/update_user_controller.dart';

class UpdateUserDataScreen extends ConsumerStatefulWidget {
  const UpdateUserDataScreen(this.user, {Key? key}) : super(key: key);

  final UserDetailEntity user;

  @override
  UpdateUserDataScreenState createState() => UpdateUserDataScreenState();
}

class UpdateUserDataScreenState extends ConsumerState<UpdateUserDataScreen> {
  late TextEditingController _nameController;

  late TextEditingController _surnameController;
  late TextEditingController _emailController;

  @override
  void didChangeDependencies() {
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _surnameController = TextEditingController(text: widget.user.surname);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    listenState(context, ref);
    final state = ref.watch(updateUserProvider);
    final updateController = ref.read(updateUserProvider.notifier)..initController(widget.user);
    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: AppColors.grey20,
        appBar: const FlexAppBar(
          'Personal Information',
          backgroundColor: AppColors.grey20,
        ),
        body: AppLoadingContainer(
          isLoading: state.isLoading,
          child: AppAdaptiveLayoutScreen(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            footer: Column(
              children: [
                const AppTermsAndPolicyWidget(),
                AppFilledColorButton(
                  onTap: () => updateController.update(
                    _emailController.text,
                    _nameController.text,
                    _surnameController.text,
                  ),
                  height: 48,
                  borderRadiusRadii: 30,
                  color: AppColors.inDevPrimary500,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Сохранить',
                    style: AppTextStyle.button1.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                const HBox(16),
              ],
            ),
            child: Column(
              children: [
                const HBox(16),
                AppLabelTextFieldWidget(
                  label: 'First name',
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  inputType: TextInputType.emailAddress,
                ),
                const HBox(8),
                AppLabelTextFieldWidget(
                  label: 'Last name',
                  controller: _surnameController,
                  textInputAction: TextInputAction.next,
                  inputType: TextInputType.emailAddress,
                ),
                const HBox(8),
                Text(
                  'Make sure it matches the name on your government ID.',
                  style: AppTextStyle.body2.copyWith(
                    color: AppColors.grey500,
                  ),
                ),
                const HBox(16),
                AppLabelTextFieldWidget(
                  label: 'Email',
                  controller: _emailController,
                  textInputAction: TextInputAction.next,
                  inputType: TextInputType.emailAddress,
                ),
                const HBox(20),
                AppTextButton(
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ChangePasswordScreen(),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  text: 'Сhange password',
                  style: AppTextStyle.button3,
                ),
                AppTextButton(
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ForgetPasswordScreen(),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  text: 'Forget password',
                  style: AppTextStyle.button3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Слушаем все изменение состонии провайдера
  void listenState(BuildContext context, WidgetRef ref) {
    ref.listen<UpdateUserState>(
      updateUserProvider,
      (previous, current) {
        if (current.status == UpdateUserStatus.success) {
          ref.read(authProvider.notifier).updateUserData(current.user);
          showSuccessSnackBar(context, 'Success');
          Navigator.pop(context);
        }
      },
    );
  }
}
