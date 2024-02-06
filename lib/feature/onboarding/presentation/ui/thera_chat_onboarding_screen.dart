import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theta_chat/common/presentation/widgets/app_bar/common_app_bar.dart';
import 'package:theta_chat/common/presentation/widgets/app_hbox_widget.dart';
import 'package:theta_chat/common/presentation/widgets/app_income_message.dart';
import 'package:theta_chat/common/presentation/widgets/app_outcome_message.dart';
import 'package:theta_chat/common/presentation/widgets/app_waiting_animated_dots.dart';
import 'package:theta_chat/common/presentation/widgets/keyboard_dismisser.dart';
import 'package:theta_chat/common/presentation/widgets/screen/internet_connection_status_widget.dart';
import 'package:theta_chat/config/theme.dart';
import 'package:theta_chat/feature/onboarding/presentation/controller/onboarding_riverpod.dart';
import 'package:theta_chat/feature/onboarding/presentation/ui/widgets/onboarding_footer.dart';
import 'package:theta_chat/feature/splash/presetation/splash_screen.dart';

class TheraChatOnboardingScreen extends ConsumerStatefulWidget {
  const TheraChatOnboardingScreen({Key? key}) : super(key: key);

  @override
  TheraChatOnboardingScreenState createState() => TheraChatOnboardingScreenState();
}

class TheraChatOnboardingScreenState extends ConsumerState<TheraChatOnboardingScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    listenState(context, ref);
    final state = ref.watch(onboardingProvider);
    final onboardingProviderController = ref.read(onboardingProvider.notifier);
    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: AppColors.grey20,
        appBar: CommonAppBar(
          onPressLeading: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const SplashScreen(),
            ),
          ),
          leadingSize: 30,
          leadingIcon: AppIcons.icUserOutline,
        ),
        body: InternetConnectionStatusWidget(
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: state.chat.length,
                  controller: _scrollController,
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 80),
                  separatorBuilder: (context, _) => const HBox(20),
                  itemBuilder: (context, index) {
                    final chat = state.chat[index];
                    if (state.isLoading && state.chat.length == index + 1) {
                      return const AppWaitingAnimatedDots();
                    } else if (chat.isAdditionalMessage) {
                      return Center(
                        child: Text(
                          chat.message,
                          style: AppTextStyle.caption1.copyWith(color: AppColors.grey600),
                        ),
                      );
                    } else if (chat.isAssistantMessage) {
                      return AppAssistantMessage(chat.message);
                    }
                    return AppOutcomeMessage(chat.message);
                  },
                ),
              ),
              OnboardingFooter(
                state,
                controller: _controller,
                activateChat: onboardingProviderController.stayLikeGuest,
                onSendMessage: () {
                  onboardingProviderController.sendNewMessage(_controller.text);
                  if (_controller.text.isNotEmpty && !state.isLoading) {
                    _controller.clear();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Отслеживает все изменения состояния провайдера `guestChatProvider`.
  ///
  /// Этот метод используется для реагирования на изменения в состоянии чата. При каждом
  /// изменении состояния, описанного в [GuestChatState], выполняются соответствующие действия.
  ///
  /// Возможные действия в зависимости от изменения состояния:
  ///   - При ошибке (статус `GuestChatStatus.failure`) показывается снэкбар с сообщением об ошибке.
  ///   - При изменении содержимого чата (сравнивается с предыдущим состоянием) происходит прокрутка к
  ///     самому нижнему сообщению в чате.
  void listenState(BuildContext context, WidgetRef ref) {
    ref.listen<OnboardingState>(
      onboardingProvider,
      (previous, current) {
        if (current.status == OnboardingStatus.failure) {
          FocusScope.of(context).unfocus();
          showError(current.chat.last.message);
        } else if (previous?.chat != current.chat || previous?.isLoading != current.isLoading) {
          jumpToBottomOfScroll();
        }
      },
    );
  }

  Future<void> showError(String lastMessage) async {
    final value = await showOkCancelAlertDialog(
      context: context,
      title: 'Sending error',
      message: 'Sorry, the message was not delivered. Try sending it again.',
      okLabel: 'Retry',
      cancelLabel: 'Cancel',
      canPop: false,
    );
    if (value == OkCancelResult.ok) {
      ref.read(onboardingProvider.notifier).sendNewMessage(lastMessage);
    }
  }

  /// Перемещает скролл к самому нижнему сообщению в списке.
  ///
  /// Этот метод используется для автоматического прокручивания содержимого виджета прокрутки
  /// (например, списка сообщений в чате) к самому последнему элементу. Это удобно, когда
  /// нужно сразу отобразить самые последние сообщения, например, после получения нового сообщения
  /// или при открытии чата.
  ///
  /// Метод использует [WidgetsBinding.instance.addPostFrameCallback] для того, чтобы
  /// дождаться завершения всех расчетов отрисовки UI перед прокруткой. Это гарантирует, что
  /// прокрутка будет работать корректно даже если UI еще не полностью построен.
  ///
  /// Использует [ScrollController.animateTo] для плавной прокрутки к нужной позиции.
  void jumpToBottomOfScroll() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.animateTo(
        curve: Curves.ease,
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
