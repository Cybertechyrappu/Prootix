package com.qorvode.prootix

import android.app.Application
import android.app.NotificationChannel
import android.app.NotificationManager
import android.os.Build

class ProotixApp : Application() {

    companion object {
        const val CHANNEL_TERMINAL = "terminal_sessions"
        const val CHANNEL_DOWNLOAD = "downloads"
    }

    override fun onCreate() {
        super.onCreate()
        createNotificationChannels()
    }

    private fun createNotificationChannels() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val terminalChannel = NotificationChannel(
                CHANNEL_TERMINAL,
                getString(R.string.notification_channel_terminal),
                NotificationManager.IMPORTANCE_LOW
            ).apply {
                description = "Notification for active terminal sessions"
                setShowBadge(false)
            }

            val downloadChannel = NotificationChannel(
                CHANNEL_DOWNLOAD,
                getString(R.string.notification_channel_download),
                NotificationManager.IMPORTANCE_LOW
            ).apply {
                description = "Notification for download progress"
                setShowBadge(false)
            }

            val notificationManager = getSystemService(NotificationManager::class.java)
            notificationManager.createNotificationChannel(terminalChannel)
            notificationManager.createNotificationChannel(downloadChannel)
        }
    }
}