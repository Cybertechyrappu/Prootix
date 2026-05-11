#include <termios.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <signal.h>

#include <string>
#include <vector>

class TerminalNative {
public:
    TerminalNative();
    ~TerminalNative();
    
    bool openPty();
    void closePty();
    
    bool write(const std::string& data);
    std::string read(bool nonBlocking = false);
    
    bool resize(int rows, int cols);
    
    bool sendSignal(int signum);
    bool isConnected() const;
    
    int getMasterFd() const;
    int getSlaveFd() const;

private:
    int m_masterFd;
    int m_slaveFd;
    bool m_connected;
};

TerminalNative::TerminalNative() : m_masterFd(-1), m_slaveFd(-1), m_connected(false) {}

TerminalNative::~TerminalNative() {
    closePty();
}

bool TerminalNative::openPty() {
    if (m_connected) return true;
    
    int master, slave;
    char slaveName[256];
    
    if (openpty(&master, &slave, slaveName, nullptr, nullptr) == -1) {
        return false;
    }
    
    m_masterFd = master;
    m_slaveFd = slave;
    m_connected = true;
    
    return true;
}

void TerminalNative::closePty() {
    if (m_masterFd >= 0) {
        close(m_masterFd);
        m_masterFd = -1;
    }
    if (m_slaveFd >= 0) {
        close(m_slaveFd);
        m_slaveFd = -1;
    }
    m_connected = false;
}

bool TerminalNative::write(const std::string& data) {
    if (!m_connected || m_masterFd < 0) return false;
    ssize_t written = ::write(m_masterFd, data.c_str(), data.length());
    return written == static_cast<ssize_t>(data.length());
}

std::string TerminalNative::read(bool nonBlocking) {
    std::string result;
    if (!m_connected || m_masterFd < 0) return result;
    
    char buffer[4096];
    ssize_t bytesRead;
    
    if (nonBlocking) {
        fcntl(m_masterFd, F_SETFL, O_NONBLOCK);
    }
    
    bytesRead = ::read(m_masterFd, buffer, sizeof(buffer));
    if (bytesRead > 0) {
        result.append(buffer, bytesRead);
    }
    
    if (nonBlocking) {
        fcntl(m_masterFd, F_SETFL, 0);
    }
    
    return result;
}

bool TerminalNative::resize(int rows, int cols) {
    if (!m_connected || m_slaveFd < 0) return false;
    
    struct winsize ws;
    ws.ws_row = rows;
    ws.ws_col = cols;
    ws.ws_xpixel = 0;
    ws.ws_ypixel = 0;
    
    return ioctl(m_slaveFd, TIOCSWINSZ, &ws) == 0;
}

bool TerminalNative::sendSignal(int signum) {
    if (!m_connected) return false;
    return kill(0, signum) == 0;
}

bool TerminalNative::isConnected() const {
    return m_connected;
}

int TerminalNative::getMasterFd() const {
    return m_masterFd;
}

int TerminalNative::getSlaveFd() const {
    return m_slaveFd;
}