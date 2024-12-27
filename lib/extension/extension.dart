import '../constants/asset_path.dart';

extension StringExtensions on String {

  String getPath(AssetPaths type) {
    switch (type) {
      case AssetPaths.image:
        return "assets/images/$this";
    }
  }
}