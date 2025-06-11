/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/sf-ui-display-black.otf
  String get sfUiDisplayBlack => 'assets/fonts/sf-ui-display-black.otf';

  /// File path: assets/fonts/sf-ui-display-bold.otf
  String get sfUiDisplayBold => 'assets/fonts/sf-ui-display-bold.otf';

  /// File path: assets/fonts/sf-ui-display-heavy.otf
  String get sfUiDisplayHeavy => 'assets/fonts/sf-ui-display-heavy.otf';

  /// File path: assets/fonts/sf-ui-display-light.otf
  String get sfUiDisplayLight => 'assets/fonts/sf-ui-display-light.otf';

  /// File path: assets/fonts/sf-ui-display-medium.otf
  String get sfUiDisplayMedium => 'assets/fonts/sf-ui-display-medium.otf';

  /// File path: assets/fonts/sf-ui-display-semibold.otf
  String get sfUiDisplaySemibold => 'assets/fonts/sf-ui-display-semibold.otf';

  /// File path: assets/fonts/sf-ui-display-thin.otf
  String get sfUiDisplayThin => 'assets/fonts/sf-ui-display-thin.otf';

  /// File path: assets/fonts/sf-ui-display-ultralight.otf
  String get sfUiDisplayUltralight => 'assets/fonts/sf-ui-display-ultralight.otf';

  /// List of all assets
  List<String> get values => [
    sfUiDisplayBlack,
    sfUiDisplayBold,
    sfUiDisplayHeavy,
    sfUiDisplayLight,
    sfUiDisplayMedium,
    sfUiDisplaySemibold,
    sfUiDisplayThin,
    sfUiDisplayUltralight,
  ];
}

class $AssetsImgGen {
  const $AssetsImgGen();

  /// File path: assets/img/auth.webp
  AssetGenImage get auth => const AssetGenImage('assets/img/auth.webp');

  /// File path: assets/img/default_avatar.png
  AssetGenImage get defaultAvatar => const AssetGenImage('assets/img/default_avatar.png');

  /// File path: assets/img/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/img/logo.png');

  /// List of all assets
  List<AssetGenImage> get values => [auth, defaultAvatar, logo];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/comment.svg
  SvgGenImage get comment => const SvgGenImage('assets/svg/comment.svg');

  /// File path: assets/svg/facebook.svg
  SvgGenImage get facebook => const SvgGenImage('assets/svg/facebook.svg');

  /// File path: assets/svg/files.svg
  SvgGenImage get files => const SvgGenImage('assets/svg/files.svg');

  /// File path: assets/svg/google.svg
  SvgGenImage get google => const SvgGenImage('assets/svg/google.svg');

  /// File path: assets/svg/like.svg
  SvgGenImage get like => const SvgGenImage('assets/svg/like.svg');

  /// File path: assets/svg/my_file.svg
  SvgGenImage get myFile => const SvgGenImage('assets/svg/my_file.svg');

  /// File path: assets/svg/search_file.svg
  SvgGenImage get searchFile => const SvgGenImage('assets/svg/search_file.svg');

  /// File path: assets/svg/send.svg
  SvgGenImage get send => const SvgGenImage('assets/svg/send.svg');

  /// File path: assets/svg/upload_file.svg
  SvgGenImage get uploadFile => const SvgGenImage('assets/svg/upload_file.svg');

  /// List of all assets
  List<SvgGenImage> get values => [comment, facebook, files, google, like, myFile, searchFile, send, uploadFile];
}

class Assets {
  const Assets._();

  static const String aEnv = '.env';
  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsImgGen img = $AssetsImgGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();

  /// List of all assets
  static List<String> get values => [aEnv];
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

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

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}}) : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}}) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(_assetName, assetBundle: bundle, packageName: package);
    } else {
      loader = _svg.SvgAssetLoader(_assetName, assetBundle: bundle, packageName: package, theme: theme);
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ?? (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
