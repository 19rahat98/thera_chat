import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const primary = Color(0xFF1C1F23);
  static const black = Color(0xFF191614);
  static const error500 = Color(0xFFF04438);
  static const secondary = Color(0xFF888D92);
  static const grey20 = Color(0xFFFCFCFD);
  static const grey50 = Color(0xFFF9FAFB);
  static const grey100 = Color(0xFFF1F5F8);
  static const grey200 = Color(0xFFE5EAF2);
  static const grey300 = Color(0xFFC8CFDA);
  static const grey500 = Color(0xFF737986);
  static const grey700 = Color(0xFF394360);
  static const inDevPrimary = Color(0xFF9400D3);
  static const inDevPrimary100 = Color(0xFFFBCAFC);
  static const inDevPrimary400 = Color(0xFFD267FF);
  static const inDevPrimary500 = Color(0xFFAA00F3);
  static const inDevPrimary600 = Color(0xFF7300B5);
}

class AppIcons {
  static const icSendOutline = 'assets/icons/ic_send_outline.svg';
  static const icMeditationOutline = 'assets/icons/ic_meditation_outline.svg';
  static const icQuestionOutline = 'assets/icons/ic_question_outline.svg';
  static const icUserOutline = 'assets/icons/ic_user_outline.svg';
  static const icAppIcon = 'assets/icons/ic_app_icon.svg';
  static const icBookOutline = 'assets/icons/ic_book_outline.svg';
  static const icArrowRight = 'assets/icons/ic_arrow_right.svg';
  static const icArrowLeft = 'assets/icons/ic_arrow_left.svg';
  static const icCross = 'assets/icons/ic_cross.svg';
  static const icSunFilled = 'assets/icons/ic_sun_filled.svg';
  static const icInformationFilled = 'assets/icons/ic_information_filled.svg';
  static const icAlertCircleFilled = 'assets/icons/ic_alert_circle_filled.svg';
  static const icWorldOutline = 'assets/icons/ic_world_outline.svg';
  static const icLaunchIcon = 'assets/icons/ic_launch_icon.svg';
  static const icAppleFilled = 'assets/icons/ic_apple_filled.svg';
  static const icGoogleFilled = 'assets/icons/ic_google_filled.svg';
  static const icVisibleOutline = 'assets/icons/ic_visible_outline.svg';
  static const icCheckRounded = 'assets/icons/ic_check_rounded.svg';
  static const icHomeOutline = 'assets/icons/ic_home_outline.svg';
  static const icMeditationBody = 'assets/icons/ic_meditation_body.svg';
  static const icBookNav = 'assets/icons/ic_book_nav.svg';
  static const icSettingsOutline = 'assets/icons/ic_settings_outline.svg';
  static const icChatFilled = 'assets/icons/ic_chat_filled.svg';
}

class AppImages {
  static const icMeditationBackground1 = 'assets/images/ic_meditation_background_1.jpg';
  static const icMeditationBackground2 = 'assets/images/ic_meditation_background_2.jpg';
}

class AppStyle {}

class AppTextStyle {
  static final h1 = GoogleFonts.nunito(
    fontSize: 32,
    color: Colors.white,
    fontWeight: FontWeight.w700,
  );

  static final h4 = GoogleFonts.nunito(
    fontSize: 18,
    color: AppColors.black,
    fontWeight: FontWeight.w700,
  );

  static final h5 = GoogleFonts.nunito(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.w400,
  );

  static final body1 = GoogleFonts.nunito(
    fontSize: 16,
    color: AppColors.primary,
    fontWeight: FontWeight.w400,
  );

  static final body2 = GoogleFonts.nunito(
    fontSize: 14,
    color: AppColors.black,
    fontWeight: FontWeight.w400,
  );

  static final body3 = GoogleFonts.inter(
    fontSize: 16,
    color: AppColors.primary,
    fontWeight: FontWeight.w700,
  );

  static final button1 = GoogleFonts.nunito(
    fontSize: 16,
    color: AppColors.primary,
    fontWeight: FontWeight.w700,
  );

  static final button2 = GoogleFonts.nunito(
    fontSize: 14,
    color: AppColors.grey700,
    fontWeight: FontWeight.w700,
  );

  static final caption1 = GoogleFonts.nunito(
    fontSize: 12,
    color: AppColors.secondary,
    fontWeight: FontWeight.w400,
  );
}