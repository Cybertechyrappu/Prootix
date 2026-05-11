package com.qorvode.prootix.receiver

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import com.qorvode.prootix.service.TerminalService

class BootReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action == Intent.ACTION_BOOT_COMPLETED) {
            val serviceIntent = Intent(context, TerminalService::class.java).apply {
                action = TerminalService.ACTION_START_TERMINAL
            }
            context.startForegroundService(serviceIntent)
        }
    }
}