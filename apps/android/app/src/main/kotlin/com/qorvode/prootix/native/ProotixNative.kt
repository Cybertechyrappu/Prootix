package com.qorvode.prootix.native

class ProotixNative {
    companion object {
        init {
            System.loadLibrary("prootix")
        }
    }
    
    external fun initEnvironment(path: String): String
    external fun executeCommand(command: String): Boolean
    external fun startProot(rootfsPath: String, kernelRelease: String): Int
    external fun stopProot(pid: Int): Boolean
    external fun getVersion(): String
}