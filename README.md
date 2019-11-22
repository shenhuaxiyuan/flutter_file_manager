# flutter_file_manager

本插件借用了另一个相似的开源项目改编而成了一个插件。

同时支持android和ios的文件选择以及打开文件 ，android和ios的打开文件都是调用的系统去打开。
对于android打开的是SD卡，而对于ios，打开的是NSDocuments

引入方式

请自行下载下来放到自己项目中，然后本地引用插件
```
flutter_file_manager:
    path: ./flutter_file_manager
```

发现插件中的资源文件好像不能生效，可以自行把assets里面的图片文件拷贝到自己的资源文件内


使用方式
    调用文件浏览器获取文件地址(如果调用文件浏览器打开文件直接切换FileManagerType.OpenFile即可)

```
  await FileCommon.getFilePermission();


  String path = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => FileManagerPage(FileManagerType.GetPath)));
```


打开文件
```
FlutterFileManager.openFile({"path": file.path});
```

打开文件功能需要自行在android的manifest中添加Provider


![Image](https://github.com/shenhuaxiyuan/flutter_file_manager/blob/master/image.jpg)

```
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
```

filepaths内容如下
```
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
```