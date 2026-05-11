#include <jni.h>
#include <android/log.h>
#include <string>
#include <memory>

#define LOG_TAG "ProotixJNI"
#define LOGI(...) __android_log_print(ANDROID_LOG_INFO, LOG_TAG, __VA_ARGS__)
#define LOGE(...) __android_log_print(ANDROID_LOG_ERROR, LOG_TAG, __VA_ARGS__)

extern "C" {

JNIEXPORT jstring JNICALL
Java_com_qorvode_prootix_native_ProotixNative_initEnvironment(JNIEnv *env, jobject thiz, jstring path) {
    const char* nativePath = env->GetStringUTFChars(path, nullptr);
    std::string result = "Environment initialized at: ";
    result += nativePath;
    env->ReleaseStringUTFChars(path, nativePath);
    LOGI("Init environment: %s", nativePath);
    return env->NewStringUTF(result.c_str());
}

JNIEXPORT jboolean JNICALL
Java_com_qorvode_prootix_native_ProotixNative_executeCommand(JNIEnv *env, jobject thiz, jstring command) {
    const char* cmd = env->GetStringUTFChars(command, nullptr);
    LOGI("Execute command: %s", cmd);
    env->ReleaseStringUTFChars(command, cmd);
    return JNI_TRUE;
}

JNIEXPORT jint JNICALL
Java_com_qorvode_prootix_native_ProotixNative_startProot(JNIEnv *env, jobject thiz, jstring rootfs_path, jstring kernel_release) {
    const char* path = env->GetStringUTFChars(rootfs_path, nullptr);
    const char* release = env->GetStringUTFChars(kernel_release, nullptr);
    LOGI("Starting PRoot: path=%s, kernel=%s", path, release);
    env->ReleaseStringUTFChars(rootfs_path, path);
    env->ReleaseStringUTFChars(kernel_release, release);
    return 0;
}

JNIEXPORT jboolean JNICALL
Java_com_qorvode_prootix_native_ProotixNative_stopProot(JNIEnv *env, jobject thiz, jint pid) {
    LOGI("Stopping PRoot PID: %d", pid);
    return JNI_TRUE;
}

JNIEXPORT jstring JNICALL
Java_com_qorvode_prootix_native_ProotixNative_getVersion(JNIEnv *env, jobject thiz) {
    return env->NewStringUTF("1.0.0");
}

}