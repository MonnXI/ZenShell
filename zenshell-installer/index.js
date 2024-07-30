// #######################################################################
// #  ____         ___ _        _ _ 
// # |_  /___ _ _ / __| |_  ___| | |
// #  / // -_) ' \\__ \ ' \/ -_) | |
// # /___\___|_||_|___/_||_\___|_|_|
// #                                
// # Program: ZenShell
// # Copyright (c) 2024 MonnTheBoss
// #
// # This script is governed by the terms of the GNU General Public License v3.0
// # The latest version of the license can be found at:
// # https://www.gnu.org/licenses/gpl-3.0.html
// #
// # ZenShell's website can be found at http://184.144.140.71:8080
// #######################################################################

const { app, BrowserWindow } = require('electron')

const createWindow = () => {
    const win = new BrowserWindow({
        width: 525,
        height: 300,
        webPreferences: {
            nodeIntegration: true, 
            contextIsolation: false,
        }
    })

    win.loadFile('index.html')
}

app.whenReady().then(() => {
    createWindow()
})

app.on('window-all-closed', () => {
    if (process.platform !== 'darwin') app.quit()
})

