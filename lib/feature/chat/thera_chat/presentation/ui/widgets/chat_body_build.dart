import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theta_chat/common/presentation/widgets/app_hbox_widget.dart';
import 'package:theta_chat/common/presentation/widgets/app_income_message.dart';
import 'package:theta_chat/common/presentation/widgets/app_loading_container.dart';
import 'package:theta_chat/common/presentation/widgets/app_outcome_message.dart';
import 'package:theta_chat/common/presentation/widgets/app_waiting_animated_dots.dart';
import 'package:theta_chat/common/presentation/widgets/keyboard_dismisser.dart';
import 'package:theta_chat/config/theme.dart';
import 'package:theta_chat/feature/chat/guest/presentation/ui/widgets/guest_chat_text_field.dart';
import 'package:theta_chat/feature/chat/thera_chat/presentation/controller/thera_chat_controller.dart';

class ChatBodyBuild extends ConsumerStatefulWidget {
  const ChatBodyBuild({Key? key}) : super(key: key);

  @override
  ChatBodyBuildState createState() => ChatBodyBuildState();
}

class ChatBodyBuildState extends ConsumerState<ChatBodyBuild> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();

  @override
  void didChangeDependencies() {
    jumpToBottomOfScroll();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    listenState(context, ref);
    final state = ref.watch(theraChatProvider);
    final theraChatController = ref.read(theraChatProvider.notifier);
    return Column(
      children: [
        Expanded(
          child: AppLoadingContainer(
            isLoading: state.isLoading,
            child: KeyboardDismisser(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: state.chat.length,
                controller: _scrollController,
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 80),
                separatorBuilder: (context, _) => const HBox(20),
                itemBuilder: (context, index) {
                  final chat = state.chat[index];
                  if (state.isWaitingAssistant && state.chat.length == index + 1) {
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
                  return AppOutcomeMessage(
                    chat.message,
                    isHaveError: state.errorMessage != null,
                  );
                },
              ),
            ),
          ),
        ),
        GuestChatTextField(
          onSendMessage: () {
            if (state.enableChat && _textController.text.isNotEmpty) {
              theraChatController.sendNewMessage(_textController.text);
              _textController.clear();
            }
          },
          autofocus: false,
          controller: _textController,
        ),
      ],
    );
  }

  /// Отслеживает все изменения состояния провайдера `theraChatProvider`.
  ///
  /// Этот метод используется для реагирования на изменения в состоянии чата. При каждом
  /// изменении состояния, описанного в [TheraChatState], выполняются соответствующие действия.
  ///
  /// Возможные действия в зависимости от изменения состояния:
  ///   - При ошибке (статус `TheraChatState.failure`) показывается снэкбар с сообщением об ошибке.
  ///   - При изменении содержимого чата (сравнивается с предыдущим состоянием) происходит прокрутка к
  ///     самому нижнему сообщению в чате.
  void listenState(BuildContext context, WidgetRef ref) {
    ref.listen<TheraChatState>(
      theraChatProvider,
      (previous, current) {
        if (current.status == TheraChatStatus.failure) {
          showError(current.chat.last.message);
        } else if (previous?.chat != current.chat ||
            previous?.isWaitingAssistant != current.isWaitingAssistant) {
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
      ref.read(theraChatProvider.notifier).sendNewMessage(lastMessage);
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
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
