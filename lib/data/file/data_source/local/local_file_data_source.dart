import 'dart:io';

abstract interface class LocalFileDataSource {
  Future<File?> getImagePath({required bool isOrigin});

  Future<bool> saveImage({required bool isOrigin, required File file});
}