package com.qorvode.prootix.service

import android.app.Notification
import android.app.PendingIntent
import android.app.Service
import android.content.Intent
import android.os.Binder
import android.os.IBinder
import androidx.core.app.NotificationCompat
import com.qorvode.prootix.ProotixApp
import com.qorvode.prootix.R
import com.qorvode.prootix.ui.MainActivity
import kotlinx.coroutines.*
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import java.io.File
import java.io.FileOutputStream
import java.io.InputStream

class DownloadService : Service() {

    private val binder = DownloadBinder()
    private val serviceScope = CoroutineScope(Dispatchers.IO + SupervisorJob())
    
    private val _downloadProgress = MutableStateFlow<Map<String, DownloadState>>(emptyMap())
    val downloadProgress: StateFlow<Map<String, DownloadState>> = _downloadProgress

    data class DownloadState(
        val url: String,
        val fileName: String,
        val totalBytes: Long,
        val downloadedBytes: Long,
        val isComplete: Boolean,
        val error: String? = null
    ) {
        val progress: Float get() = if (totalBytes > 0) downloadedBytes.toFloat() / totalBytes else 0f
    }

    inner class DownloadBinder : Binder() {
        fun getService(): DownloadService = this@DownloadService
    }

    override fun onBind(intent: Intent?): IBinder = binder

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        return START_NOT_STICKY
    }

    fun startDownload(url: String, outputDir: File, fileName: String) {
        serviceScope.launch {
            try {
                _downloadProgress.value = _downloadProgress.value + (fileName to 
                    DownloadState(url, fileName, 0, 0, false))
                
                downloadFile(url, File(outputDir, fileName))
                
                _downloadProgress.value = _downloadProgress.value + (fileName to
                    DownloadState(url, fileName, 0, 0, true))
            } catch (e: Exception) {
                _downloadProgress.value = _downloadProgress.value + (fileName to
                    DownloadState(url, fileName, 0, 0, false, e.message))
            }
        }
    }

    private suspend fun downloadFile(url: String, outputFile: File) {
        withContext(Dispatchers.IO) {
            val connection = java.net.URL(url).openConnection()
            connection.connect()
            
            val totalBytes = connection.contentLength.toLong()
            var downloadedBytes = 0L
            
            connection.getInputStream().use { input ->
                FileOutputStream(outputFile).use { output ->
                    val buffer = ByteArray(8192)
                    var bytesRead: Int
                    
                    while (input.read(buffer).also { bytesRead = it } != -1) {
                        output.write(buffer, 0, bytesRead)
                        downloadedBytes += bytesRead
                        
                        _downloadProgress.value = _downloadProgress.value + (outputFile.name to
                            DownloadState(url, outputFile.name, totalBytes, downloadedBytes, false))
                    }
                }
            }
        }
    }

    fun cancelDownload(fileName: String) {
        _downloadProgress.value = _downloadProgress.value - fileName
    }

    override fun onDestroy() {
        super.onDestroy()
        serviceScope.cancel()
    }

    companion object {
        const val NOTIFICATION_ID = 1002
    }
}