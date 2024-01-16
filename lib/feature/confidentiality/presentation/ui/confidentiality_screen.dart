import 'package:flutter/material.dart';
import 'package:theta_chat/common/presentation/widgets/app_bar/flex_app_bar.dart';
import 'package:theta_chat/common/presentation/widgets/app_hbox_widget.dart';
import 'package:theta_chat/config/theme.dart';

class ConfidentialityScreen extends StatelessWidget {
  const ConfidentialityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey20,
      appBar: const FlexAppBar(
        'Confidentiality',
        backgroundColor: AppColors.grey20,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Наши гарантии конфиденциальности:',
              textAlign: TextAlign.start,
              style: AppTextStyle.h4,
            ),
            const HBox(12),
            Text(
              '''Мы ценим вашу приватность и обязуемся к строгой защите всех предоставленных вами данных. Вся информация, которую вы передаете через наше приложение, обсуждения в рамках сессий, личные данные, остаются абсолютно конфиденциальными и защищены согласно высоким стандартам безопасности.
Мы не передаем вашу личную информацию третьим лицам без вашего явного разрешения, за исключением случаев, когда это необходимо для оказания вам помощи и соблюдения законных требований. Наша команда обладает строгим этическим кодексом, гарантирующим неразглашение любой информации, полученной в процессе наших сессий.
Помните, что ваше доверие - наш приоритет. Мы стараемся создать безопасное и поддерживающее пространство для ваших разговоров и личного роста. Все данные хранятся в зашифрованном виде, а доступ к ним имеют только специально авторизованные лица, занимающиеся вашим обслуживанием.
Если у вас есть какие-либо вопросы или беспокойства относительно защиты вашей конфиденциальности, пожалуйста, обратитесь к нашей службе поддержки. Мы всегда готовы помочь и обеспечить вас всей необходимой информацией для обеспечения вашей уверенности в безопасности ваших данных.''',
              textAlign: TextAlign.start,
              style: AppTextStyle.body1,
            ),
          ],
        ),
      ),
    );
  }
}
