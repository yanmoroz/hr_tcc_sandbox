// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// Directory path: assets/icons/auth
  $AssetsIconsAuthGen get auth => const $AssetsIconsAuthGen();

  /// Directory path: assets/icons/quick_links
  $AssetsIconsQuickLinksGen get quickLinks => const $AssetsIconsQuickLinksGen();
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// Directory path: assets/images/surveys
  $AssetsImagesSurveysGen get surveys => const $AssetsImagesSurveysGen();
}

class $AssetsIconsAuthGen {
  const $AssetsIconsAuthGen();

  /// File path: assets/icons/auth/face_id_big.svg
  String get faceIdBig => 'assets/icons/auth/face_id_big.svg';

  /// File path: assets/icons/auth/touch_id_big.svg
  String get touchIdBig => 'assets/icons/auth/touch_id_big.svg';

  /// List of all assets
  List<String> get values => [faceIdBig, touchIdBig];
}

class $AssetsIconsQuickLinksGen {
  const $AssetsIconsQuickLinksGen();

  /// Directory path: assets/icons/quick_links/page
  $AssetsIconsQuickLinksPageGen get page =>
      const $AssetsIconsQuickLinksPageGen();

  /// Directory path: assets/icons/quick_links/widget
  $AssetsIconsQuickLinksWidgetGen get widget =>
      const $AssetsIconsQuickLinksWidgetGen();
}

class $AssetsImagesSurveysGen {
  const $AssetsImagesSurveysGen();

  /// File path: assets/images/surveys/developing_environment.png
  AssetGenImage get developingEnvironment =>
      const AssetGenImage('assets/images/surveys/developing_environment.png');

  /// File path: assets/images/surveys/padel_tennis.png
  AssetGenImage get padelTennis =>
      const AssetGenImage('assets/images/surveys/padel_tennis.png');

  /// List of all assets
  List<AssetGenImage> get values => [developingEnvironment, padelTennis];
}

class $AssetsIconsQuickLinksPageGen {
  const $AssetsIconsQuickLinksPageGen();

  /// File path: assets/icons/quick_links/page/confluence.svg
  String get confluence => 'assets/icons/quick_links/page/confluence.svg';

  /// File path: assets/icons/quick_links/page/ispring.svg
  String get ispring => 'assets/icons/quick_links/page/ispring.svg';

  /// File path: assets/icons/quick_links/page/jira.svg
  String get jira => 'assets/icons/quick_links/page/jira.svg';

  /// File path: assets/icons/quick_links/page/potok.svg
  String get potok => 'assets/icons/quick_links/page/potok.svg';

  /// File path: assets/icons/quick_links/page/telegram.svg
  String get telegram => 'assets/icons/quick_links/page/telegram.svg';

  /// List of all assets
  List<String> get values => [confluence, ispring, jira, potok, telegram];
}

class $AssetsIconsQuickLinksWidgetGen {
  const $AssetsIconsQuickLinksWidgetGen();

  /// File path: assets/icons/quick_links/widget/confluence.svg
  String get confluence => 'assets/icons/quick_links/widget/confluence.svg';

  /// File path: assets/icons/quick_links/widget/ispring.svg
  String get ispring => 'assets/icons/quick_links/widget/ispring.svg';

  /// File path: assets/icons/quick_links/widget/jira.svg
  String get jira => 'assets/icons/quick_links/widget/jira.svg';

  /// File path: assets/icons/quick_links/widget/potok.svg
  String get potok => 'assets/icons/quick_links/widget/potok.svg';

  /// File path: assets/icons/quick_links/widget/telegram.svg
  String get telegram => 'assets/icons/quick_links/widget/telegram.svg';

  /// List of all assets
  List<String> get values => [confluence, ispring, jira, potok, telegram];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
