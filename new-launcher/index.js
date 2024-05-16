const {app, BrowserWindow, Menu} = require('electron')
//Menu.setApplicationMenu(false)

const createWindow = () => {
  const win = new BrowserWindow({
    width: 800,
    height: 600
  })

  win.loadFile('index.html')
}

app.whenReady().then(() => {
  createWindow()
})


app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') app.quit()
})
