# Flutter and Dart specific rules
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Keep Riverpod internals
-keep class dev.rlang.** { *; }

# Keep HTTP/OkHttp classes
-dontwarn okhttp3.**
-dontwarn okio.**

# Keep model classes used for JSON parsing (prevent field stripping)
-keepclassmembers class com.postsapp.posts_app.** {
    public *;
}
