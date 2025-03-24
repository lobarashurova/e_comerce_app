package kr.beam.e_comerce_app

import androidx.annotation.NonNull
import com.yandex.mapkit.MapKitFactory
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//        MapKitFactory.setLocale("ru")
        MapKitFactory.setApiKey("bd3431e1-3475-4bc8-bd0f-8e4c0ba6ef80")
        super.configureFlutterEngine(flutterEngine)
    }
}

