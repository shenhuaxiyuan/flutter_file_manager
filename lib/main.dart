import 'package:flutter/material.dart';
import 'package:flutter_file_manager/file_manager_page.dart';

void main() {
//  Future<void> getSDCardDir() async {
//    Common().sDCardDir = (await getExternalStorageDirectory()).path;
//  }

  // Permission check
//  Future<void> getPermission() async {
//    if (Platform.isAndroid) {
//      bool permission1 = await SimplePermissions.checkPermission(Permission.ReadExternalStorage);
//      bool permission2 = await SimplePermissions.checkPermission(Permission.WriteExternalStorage);
//      if (!permission1) {
//        await SimplePermissions.requestPermission(Permission.ReadExternalStorage);
//      }
//      if (!permission2) {
//        await SimplePermissions.requestPermission(Permission.WriteExternalStorage);
//      }
////      await getSDCardDir();
//      Common().sDCardDir = (await getExternalStorageDirectory()).path;
//    } else if (Platform.isIOS) {
//      Common().sDCardDir = (await getApplicationDocumentsDirectory()).path;
//    }
//  }
//
//  Future.wait([initializeDateFormatting("zh_CN", null), getPermission()]).then((result) {
//    runApp(MyApp());
//  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter File Manager',
      theme: ThemeData(
//        platform: TargetPlatform.iOS,
        primarySwatch: Colors.blue,
      ),
      home: FileManagerPage(FileManagerType.OpenFile),
    );
  }
}
