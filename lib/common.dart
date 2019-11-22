// Permission check
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';



Future<void> getFilePermission() async {
  if (Platform.isAndroid) {
    PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
    if(permission != PermissionStatus.granted){
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    }
    
    Common().sDCardDir = (await getExternalStorageDirectory()).path;
  } else if (Platform.isIOS) {
    Common().sDCardDir = (await getApplicationDocumentsDirectory()).path;
  }
}



class Common {
  factory Common() => _getInstance();

  static Common get instance => _getInstance();
  static Common _instance; // 单例对象

  static Common _getInstance() {
    if (_instance == null) {
      _instance = Common._internal();
    }
    return _instance;
  }

  Common._internal();

  /////////////////////////////////////////////////////////////

  String sDCardDir;

  String getFileSize(int fileSize) {
    String str = '';

    if (fileSize < 1024) {
      str = '${fileSize.toStringAsFixed(2)}B';
    } else if (1024 <= fileSize && fileSize < 1048576) {
      str = '${(fileSize / 1024).toStringAsFixed(2)}KB';
    } else if (1048576 <= fileSize && fileSize < 1073741824) {
      str = '${(fileSize / 1024 / 1024).toStringAsFixed(2)}MB';
    }

    return str;
  }

  String selectIcon(String ext) {
    String iconImg = 'assets/images/unknown.png';

    switch (ext) {
      case '.ppt':
      case '.pptx':
        iconImg = 'assets/images/file/ppt.png';
        break;
      case '.doc':
      case '.docx':
        iconImg = 'assets/images/file/word.png';
        break;
      case '.xls':
      case '.xlsx':
        iconImg = 'assets/images/file/excel.png';
        break;
      case '.jpg':
      case '.jpeg':
      case '.png':
        iconImg = 'assets/images/file/image.png';
        break;
      case '.txt':
        iconImg = 'assets/images/file/txt.png';
        break;
      case '.mp3':
        iconImg = 'assets/images/file/mp3.png';
        break;
      case '.mp4':
        iconImg = 'assets/images/file/video.png';
        break;
      case '.rar':
      case '.zip':
        iconImg = 'assets/images/file/zip.png';
        break;
      case '.psd':
        iconImg = 'assets/images/file/psd.png';
        break;
      default:
        iconImg = 'assets/images/file/file.png';
        break;
    }
    return iconImg;
  }
}
