import 'package:flutter/material.dart';
import 'package:wms/core/color_style.dart';
import 'package:wms/user_auth/repository/demo_user_repository.dart';
import 'package:wms/user_auth/repository/development_user_repository.dart';
import 'package:wms/user_auth/repository/production_user_repository.dart';

enum Configuration { embedded, development, production }

extension SelectedConfiguration on Configuration {
  String get displayName {
    switch (this) {
      case Configuration.embedded:
        return 'Embedded Demo';
      case Configuration.development:
        return 'Development';
      case Configuration.production:
        return 'Production';
      default:
        return 'Missing Configuration';
    }
  }
}

extension SelectedBannerNameConfiguration on Configuration {
  String get displayBannerName {
    switch (this) {
      case Configuration.embedded:
        return 'DEMO';
      case Configuration.development:
        return 'DEV';
      case Configuration.production:
        return 'PRD';
      default:
        return 'Missing Banner Configuration';
    }
  }
}

extension SelectedBannerColorConfiguration on Configuration {
  Color get bannerColor {
    switch (this) {
      case Configuration.embedded:
        return ColorStyle.bannerDemoColor;
      case Configuration.development:
        return ColorStyle.bannerDevColor;
      case Configuration.production:
        return ColorStyle.bannerPrdColor;
      default:
        return Colors.white;
    }
  }
}

extension SelectedWebServiceConfiguration on Configuration {
  dynamic get webServiceConfiguration {
    switch (this) {
      case Configuration.embedded:
        return DemoUserRepository();
      case Configuration.development:
        return DevelopmentUserRepository();
      case Configuration.production:
        return ProductionUserRepository();
      default:
        return 'Missing Web Service Configuration';
    }
  }
}
