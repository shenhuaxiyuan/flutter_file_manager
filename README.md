# flutter_file_manager

本插件借用了另一个相似的开源项目改编而成了一个插件。


引入方式


flutter_file_manager:


  git:


    url::https://github.com/shenhuaxiyuan/flutter_file_manager.git


使用方式
    调用文件浏览器获取文件地址(如果调用文件浏览器打开文件直接切换FileManagerType.OpenFile即可)


  await FileCommon.getFilePermission();


  String path = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => FileManagerPage(FileManagerType.GetPath)));



打开文件
FlutterFileManager.openFile({"path": file.path});