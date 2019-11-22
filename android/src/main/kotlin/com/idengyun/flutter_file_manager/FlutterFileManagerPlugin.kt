package com.idengyun.flutter_file_manager

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.webkit.MimeTypeMap
import androidx.core.content.FileProvider
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.io.File

class FlutterFileManagerPlugin: MethodCallHandler {

  private val METHOD_CHANNEL = "flutter_file_manager"

  companion object {

    lateinit var activity: Activity;

    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "flutter_file_manager")
      channel.setMethodCallHandler(FlutterFileManagerPlugin())
      this.activity = registrar.activity();
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    }
    else if (call.method == "openFile") run {
      val map = call.arguments as HashMap<String,String>
      val path = map["path"] as String
      openFile(activity, path)
      result.success("")
    }
    else if (call.method == "install") run {
      val path = call.arguments as String
      install(activity, path)
      result.success("")
    }
    else {
      result.notImplemented()
    }
  }

  private fun openFile(context: Context, filePath: String) {
      val file = File(filePath);
    var path = filePath
    try {
      if (!path.contains("file://")) {
        path = "file://$path"
      }
      //获取文件类型
      val extensions = path.split(".","/")
      val extension = extensions[extensions.size-1]
      println("extension:${extension}")
      val mimeType = MimeTypeMap.getSingleton().getMimeTypeFromExtension(extension)
      println("mineType:${mimeType}")

      val intent = Intent()
      intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
      intent.setAction(Intent.ACTION_VIEW)
      //设置文件的路径和文件类型
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
        val fileUri = FileProvider.getUriForFile(context, context.getPackageName()+".fileprovider", file);//android 7.0以上
        intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
        intent.setDataAndType(fileUri, mimeType);
      }else {
        intent.setDataAndType(Uri.fromFile(file), mimeType)
      }

      //跳转
      context.startActivity(intent)
    } catch (e: Exception) {
      println(e)
    }

  }

  private fun install(context: Context, filePath:String){
    val intent = Intent(Intent.ACTION_VIEW);
//    String filePath=Context.getExternalFilesDir()+"/download"+"/test.apk";
    val file = File(filePath);
    intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
    if (Build.VERSION.SDK_INT >= 24) {//大于7.0使用此方法
      val apkUri = FileProvider.getUriForFile(context, context.getPackageName()+".fileprovider", file);///-----ide文件提供者名

      //添加这一句表示对目标应用临时授权该Uri所代表的文件
      intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
      intent.setDataAndType(apkUri, "application/vnd.android.package-archive");
    }else {//小于7.0就简单了
      // 由于没有在Activity环境下启动Activity,设置下面的标签
      intent.setDataAndType(Uri.fromFile(file),"application/vnd.android.package-archive");
    }
    context.startActivity(intent);
  }


}
