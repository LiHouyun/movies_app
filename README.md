# movies_app

A new Flutter project.

> [Web前端框架Flutter实战开发教程，两小时快速掌握flutter移动App开发](https://www.bilibili.com/video/BV1EY41177y4/?p=2&share_source=copy_web&vd_source=54da364394d3171749b2e716a4ee75dd)

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Git 操作命令记录
```sh
F:\Project\Flutter\movies_app>git init
Initialized empty Git repository in F:/Project/Flutter/movies_app/.git/

F:\Project\Flutter\movies_app>git add .
warning: in the working copy of '.metadata', LF will be replaced by CRLF the next time Git touches it
warning: in the working copy of 'linux/flutter/generated_plugin_registrant.cc', LF will be replaced by CRLF the next time Git touches it
warning: in the working copy of 'linux/flutter/generated_plugin_registrant.h', LF will be replaced by CRLF the next time Git touches it
warning: in the working copy of 'linux/flutter/generated_plugins.cmake', LF will be replaced by CRLF the next time Git touches it
warning: in the working copy of 'macos/Flutter/GeneratedPluginRegistrant.swift', LF will be replaced by CRLF the next time Git touches it
warning: in the working copy of 'pubspec.lock', LF will be replaced by CRLF the next time Git touches it
warning: in the working copy of 'windows/flutter/generated_plugin_registrant.cc', LF will be replaced by CRLF the next time Git touches it
warning: in the working copy of 'windows/flutter/generated_plugin_registrant.h', LF will be replaced by CRLF the next time Git touches it
warning: in the working copy of 'windows/flutter/generated_plugins.cmake', LF will be replaced by CRLF the next time Git touches it
// 忽略即可

F:\Project\Flutter\movies_app>git commit -m "Initial commit"
[master (root-commit) d155b7e] Initial commit

F:\Project\Flutter\movies_app>git branch
* master

F:\Project\Flutter\movies_app>git remote add origin https://github.com/LiHouyun/movies_app.git

F:\Project\Flutter\movies_app>git push -u origin master
Enumerating objects: 177, done.
Counting objects: 100% (177/177), done.
Delta compression using up to 8 threads
Compressing objects: 100% (146/146), done.
Writing objects: 100% (177/177), 267.01 KiB | 8.90 MiB/s, done.
Total 177 (delta 20), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (20/20), done.
To https://github.com/LiHouyun/movies_app.git
 * [new branch]      master -> master
branch 'master' set up to track 'origin/master'.

F:\Project\Flutter\movies_app>git branch dev-1

F:\Project\Flutter\movies_app>git switch dev-1
Switched to branch 'dev-1'

```

# 打包发布
## 改软件名称

`F:\Project\Flutter\movies_app\android\app\src\main\AndroidManifest.xml` 中 
``` xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <application
        android:label="movies_app"
        ...
        >
```

## 改软件图标

`F:\Project\Flutter\movies_app\android\app\src\main\res` 下的 `mipmap-hdpi`、`mipmap-mhdpi`、`mipmap-xhdpi`、`mipmap-xxhdpi`、`mipmap-xxxhdpi` 都要做对应大小的图片替换

## 创建密钥库
``` sh
F:\Project\Flutter\movies_app>keytool -genkey -v -keystore F:\my-release-key\my-release-key.jks -keyalg RSA -keysize 204
8 -validity 10000 -alias moviesapp-release-key
输入密钥库口令:

再次输入新口令:

输入唯一判别名。提供单个点 (.) 以将子组件留空，或按 ENTER 以使用大括号中的默认值。
您的名字与姓氏是什么?
  [Unknown]:
您的组织单位名称是什么?
  [Unknown]:
您的组织名称是什么?
  [Unknown]:
您所在的城市或区域名称是什么?
  [Unknown]:
您所在的省/市/自治区名称是什么?
  [Unknown]:
该单位的双字母国家/地区代码是什么?
  [Unknown]:
CN=Unknown, OU=Unknown, O=Unknown, L=Unknown, ST=Unknown, C=Unknown是否正确?
  [否]:  y

正在为以下对象生成 2,048 位RSA密钥对和自签名证书 (SHA384withRSA) (有效期为 10,000 天):
         CN=Unknown, OU=Unknown, O=Unknown, L=Unknown, ST=Unknown, C=Unknown
[正在存储F:\my-release-key\my-release-key.jks]
```
## 将密钥库 `my-release-key.jks` 复制到 `android/app` 下

## 配置签名信息
在Flutter项目的 `android` 目录下找到 `key.properties` 文件，如果没有这个文件，可以创建一个。

在 `key.properties` 文件中添加如下内容：

```properties
storePassword=132456
keyPassword=132456
keyAlias=moviesapp-release-key
storeFile=my-release-key.jks
```

修改 `build.gradle` 文件以使用签名信息。打开 `android/app/build.gradle`，并在 `android` 节点中添加签名配置：

```gradle

def keystorePropertiesFile = rootProject.file("key.properties")
def keystoreProperties = new Properties()
keystoreProperties.load(new FileInputStream(keystorePropertiesFile))

android {
    ...
    defaultConfig { ... }

    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile file(keystoreProperties['storeFile'])
            storePassword keystoreProperties['storePassword']
        }
    }

    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            shrinkResources true
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
}
```

## 打包APK文件
打开终端并导航到Flutter项目的根目录，然后运行以下命令来打包APK文件，这个命令会生成一个已签名且优化的APK文件

```bash
F:\Project\Flutter\movies_app>flutter build apk --release

Font asset "MaterialIcons-Regular.otf" was tree-shaken, reducing it from 1645184 to 1632 bytes (99.9% reduction). Tree-shaking can be disabled by providing the --no-tree-shake-icons flag when building your app.
Running Gradle task 'assembleRelease'...                           98.1s
✓ Built build\app\outputs\flutter-apk\app-release.apk (19.4MB)
```


## 安装并测试APK
将生成的APK文件安装到真实设备上进行测试：

```bash
adb install build/app/outputs/flutter-apk/app-release.apk
```

如果你想将应用发布到Google Play Store，还可以生成一个Android App Bundle (AAB) 文件，这在Google Play上是推荐的格式：

```bash
flutter build appbundle --release
```

这样你就成功地将Flutter应用打包为APK文件，可以进行发布了。
