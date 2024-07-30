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

window.addEventListener('DOMContentLoaded', () => {
    const replaceText = (selector, text) => {
        const element = document.getElementById(selector)
        if (element) element.innerText = text
    }

    for (const dependency of ['chrome', 'node', 'electron']) {
        replaceText(`${dependency}-version`, process.versions[dependency])
    }
});