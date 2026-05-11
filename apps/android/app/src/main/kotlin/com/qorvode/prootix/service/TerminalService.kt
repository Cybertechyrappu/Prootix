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

class TerminalService : Service() {

    private val binder = TerminalBinder()
    private val serviceScope = CoroutineScope(Dispatchers.IO + SupervisorJob())
    
    private val _isRunning = MutableStateFlow(false)
    val isRunning: StateFlow<Boolean> = _isRunning

    private val _activeSessions = MutableStateFlow<Map<Int, Process>>(emptyMap())
    val activeSessions: StateFlow<Map<Int, Process>> = _activeSessions

    inner class TerminalBinder : Binder() {
        fun getService(): TerminalService = this@TerminalService
    }

    override fun onBind(intent: Intent?): IBinder = binder

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        when (intent?.action) {
            ACTION_START_TERMINAL -> startForegroundService()
            ACTION_STOP_TERMINAL -> stopSelf()
        }
        return START_STICKY
    }

    private fun startForegroundService() {
        val notification = createNotification()
        startForeground(NOTIFICATION_ID, notification)
        _isRunning.value = true
    }

    private fun createNotification(): Notification {
        val pendingIntent = PendingIntent.getActivity(
            this,
            0,
            Intent(this, MainActivity::class.java),
            PendingIntent.FLAG_IMMUTABLE
        )

        return NotificationCompat.Builder(this, ProotixApp.CHANNEL_TERMINAL)
            .setContentTitle("Prootix Terminal")
            .setContentText("Linux workstation is running")
            .setSmallIcon(R.drawable.ic_terminal)
            .setContentIntent(pendingIntent)
            .setOngoing(true)
            .build()
    }

    fun startSession(sessionId: Int, command: String, workingDir: String): Process {
        val process = Runtime.getRuntime().exec(arrayOf("/system/bin/sh", "-c", command), null)
        _activeSessions.value = _activeSessions.value + (sessionId to process)
        return process
    }

    fun stopSession(sessionId: Int) {
        _activeSessions.value[sessionId]?.let { process ->
            process.destroy()
            _activeSessions.value = _activeSessions.value - sessionId
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        _activeSessions.value.values.forEach { it.destroy() }
        serviceScope.cancel()
        _isRunning.value = false
    }

    companion object {
        const val ACTION_START_TERMINAL = "com.qorvode.prootix.START_TERMINAL"
        const val ACTION_STOP_TERMINAL = "com.qorvode.prootix.STOP_TERMINAL"
        const val NOTIFICATION_ID = 1001
    }
}