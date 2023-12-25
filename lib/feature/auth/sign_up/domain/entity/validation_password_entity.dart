import 'package:equatable/equatable.dart';

enum PasswordStrength {
  weak,
  strong,
}

class ValidationPasswordEntity extends Equatable {
  const ValidationPasswordEntity({
    this.isHaveSymbol = false,
    this.isIncludeName = false,
    this.isEnableLength = false,
    this.isContainSpace = false,
    this.strength = PasswordStrength.weak,
  });

  final bool isHaveSymbol;
  final bool isIncludeName;
  final bool isEnableLength;
  final bool isContainSpace;
  final PasswordStrength strength;

  bool get isValid => isHaveSymbol && !isIncludeName && isEnableLength && !isContainSpace;

  @override
  List<Object?> get props => [
        isHaveSymbol,
        strength,
        isContainSpace,
        isEnableLength,
        isIncludeName,
      ];
}
