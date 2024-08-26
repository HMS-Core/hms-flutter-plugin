package com.huawei.hms.flutter.ads_example

import android.util.Log
import com.huawei.hms.flutter.ads.utils.constants.InstallReferrer
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import org.json.JSONException
import org.json.JSONObject

class MainActivity: FlutterActivity(){
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        val sp = getSharedPreferences(InstallReferrer.INSTALL_REFERRER_FILE, MODE_PRIVATE)
        val editor = sp.edit()
        val jsonObject = JSONObject()
        if (!sp.contains(InstallReferrer.INSTALL_REFERRER_FILE)) {
            try {
                jsonObject.put("channelInfo", "Sample install referrer info")
                jsonObject.put("clickTimestamp", System.currentTimeMillis() - 123456L)
                jsonObject.put("installTimestamp", System.currentTimeMillis())
                editor.putString(InstallReferrer.TEST_SERVICE_PACKAGE_NAME, jsonObject.toString())
                editor.commit()
            } catch (e: JSONException) {
                Log.e("ExampleMainActivity", "saveOrDelete JSONException")
            }
        }
    }
}
