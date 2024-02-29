enum TokenType { accessToken, refreshToken }

enum MessageCodeType { correct, wrong, answer }

enum RoleType { woman, man, oldWoman, oldMan }

enum LearningStateType { beforeRecorded, recorded, corrected, completed }

enum CreateTemplateType { recentSubject, newSubject }

enum CreatingTemplateStepType {
  selectCreatingMethod,
  selectRecentSubject,
  inputSubject,
  inputFirstRole,
  inputSecondRole,
  addWord,
  inputTitle,
}

enum OfficialCategoryType {
  all,
  restaurant,
  transportation,
  shopping,
  medical,
  travel,
  cinema,
  school,
  beautySalon,
  bank,
  social,
  relationship,
  academy
}

RoleType getRoleTypeWith(String role) {
  switch (role) {
    case 'man':
      return RoleType.man;
    case 'woman':
      return RoleType.woman;
    case 'oldMan':
      return RoleType.oldMan;
    case 'oldWoman':
      return RoleType.oldWoman;
    default:
      throw Error();
  }
}

MessageCodeType getMessageCodeWith(int number) {
  switch (number) {
    case 1:
      return MessageCodeType.answer;
    case 0:
      return MessageCodeType.correct;
    case -1:
      return MessageCodeType.wrong;
    default:
      throw Error();
  }
}

extension MessageCodeExtension on MessageCodeType {
  int get value {
    switch (this) {
      case MessageCodeType.answer:
        return 1;
      case MessageCodeType.correct:
        return 0;
      case MessageCodeType.wrong:
        return -1;
      default:
        throw Error();
    }
  }
}

extension RoleTypeExtension on RoleType {
  String get value {
    switch (this) {
      case RoleType.man:
        return '남성';
      case RoleType.woman:
        return '여성';
      case RoleType.oldMan:
        return '중년 남성';
      case RoleType.oldWoman:
        return '중년 여성';
      default:
        return 'none';
    }
  }
}

extension OfficialCategoryTypeExtension on OfficialCategoryType {
  String get value {
    switch (this) {
      case OfficialCategoryType.all:
        return '전체';
      case OfficialCategoryType.restaurant:
        return '음식점';
      case OfficialCategoryType.transportation:
        return '교통';
      case OfficialCategoryType.shopping:
        return '쇼핑';
      case OfficialCategoryType.medical:
        return '의료';
      case OfficialCategoryType.travel:
        return '여행';
      case OfficialCategoryType.cinema:
        return '영화관';
      case OfficialCategoryType.school:
        return '학교';
      case OfficialCategoryType.beautySalon:
        return '미용실';
      case OfficialCategoryType.bank:
        return '은행';
      case OfficialCategoryType.social:
        return '친목';
      case OfficialCategoryType.relationship:
        return '인간관계';
      case OfficialCategoryType.academy:
        return '학원';
      default:
        return 'none';
    }
  }
}
