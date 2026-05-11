# ProGuard rules for Prootix

-keepattributes *Annotation*

-keepattributes SourceFile,LineNumberTable
-keepattributes Signature

-keep class com.qorvode.prootix.** { *; }

-dontwarn com.qorvode.prootix.**

-keepclasseswithmembers class * {
    native <methods>;
}

-keepclasseswithmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

-optimizationpasses 5
-allowaccessmodification
-dontpreverify

-verbose

-dontwarn javax.annotation.**
-dontwarn org.conscrypt.**
-dontwarn org.bouncycastle.**
-dontwarn org.openjsse.**