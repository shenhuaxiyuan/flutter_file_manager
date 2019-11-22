# flutter_file_manager

本插件借用了另一个相似的开源项目改编而成了一个插件。


引入方式


flutter_file_manager:
  git:
    url: https://github.com/shenhuaxiyuan/flutter_file_manager.git


使用方式
    调用文件浏览器获取文件地址(如果调用文件浏览器打开文件直接切换FileManagerType.OpenFile即可)


  await FileCommon.getFilePermission();


  String path = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => FileManagerPage(FileManagerType.GetPath)));



打开文件
FlutterFileManager.openFile({"path": file.path});


打开文件功能需要自行在android的manifest中添加Provider
<provider
    android:name="androidx.core.content.FileProvider"
    android:authorities="${applicationId}.fileprovider"
    android:exported="false"
    android:grantUriPermissions="true"
    tools:replace="android:authorities">
    <meta-data
        android:name="android.support.FILE_PROVIDER_PATHS"
        android:resource="@xml/filepaths" />
</provider>

filepaths内容如下

<paths>
    <external-path
            name="external-path"
            path="."/>
    <external-cache-path
            name="external-cache-path"
            path="."/>
    <external-files-path
            name="external-files-path"
            path="."/>
    <!-- 物理路径为Context.getFilesDir() + /files/* -->
    <files-path
            name="files_path"
            path="."/>
    <cache-path
            name="cache-path"
            path="."/>
    <root-path
            name="name"
            path="."/>
    <external-path
        name="rc_external_path"
        path="." />
    <root-path
        name="rc_root_path"
        path="" />
</paths>
