









## write apk on quest
```
adb install -r quest_teleop_new.apk
```

__

## logging on headset
Android Logcat: Connect the headset via USB/Wi-Fi and enter the following in the PC terminal:
```
adb logcat -s Unity
```

You will see all Debug.Log files in real time in the Linux terminal.
---

Очистка временных файлов
Иногда Unity "клинит" на кэше импорта. Находясь в корне проекта, удали папку Library (не бойся, Unity пересоберет её при запуске, это безопасно):

```
rm -rf Library/
```
---

__

## file: /UnityProject/Assets/Plugins/Android/AndroidManifest.xml
```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest
    xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools">
    <uses-feature android:name="oculus.software.overlay_keyboard" android:required="true" />

    <uses-permission android:name="android.permission.CAMERA" />
    <uses-feature android:name="android.hardware.camera" />
    <uses-feature android:name="android.hardware.camera.autofocus" />

    <application>
       <!--Used when Application Entry is set to GameActivity, otherwise remove this activity block-->
        <activity android:name="com.unity3d.player.UnityPlayerGameActivity"
                  android:theme="@style/BaseUnityGameActivityTheme">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
            <meta-data android:name="unityplayer.UnityActivity" android:value="true" />
            <meta-data android:name="android.app.lib_name" android:value="game" />
        </activity>
    </application>
</manifest>
```




## PassthroughCamera with libOpenCvSharp (CV2) with Unity

### You need this 3 files, put it to this dir:
```
Assets/Plugins/Android/libs/arm64-v8a/libopencv_java4.so
Assets/Plugins/Android/libs/arm64-v8a//libOpenCvSharpExtern.so
Assets/Prefabs/CameraViewerManagerPrefab.prefab
```

## Give rights to files
```
sudo chmod -R 777 Assets/Plugins/Android/libs/arm64-v8a/
```

## Remove ReadOnly attribute
```
find Assets/Plugins/Android/libs/arm64-v8a/ -type f -name "*.so" -exec chmod 644 {} +
```




