import 'package:flutter/material.dart';
import 'package:wms/core/color_style.dart';

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
  String get webServiceConfiguration {
    switch (this) {
      case Configuration.embedded:
        return 'Embedded Demo';
      case Configuration.development:
        return 'http://s4devapp01.ffpgroup.net:8000/sap/opu/odata/sap/';
      case Configuration.production:
        return 'http://s4prdapp01.ffpgroup.net:8000/sap/opu/odata/sap/';
      default:
        return 'Missing Web Service Configuration';
    }
  }
}

extension SelectedWebServiceCookieConfiguration on Configuration {
  String get webServiceCookieConfiguration {
    switch (this) {
      case Configuration.embedded:
        return 'Embedded Demo';
      case Configuration.development:
        return 'sap-usercontext=sap-client=110;';
      case Configuration.production:
        return 'sap-usercontext=sap-client=200;';
      default:
        return 'Missing Web Service Cookie Configuration';
    }
  }
}
