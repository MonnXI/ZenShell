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
const { exec } = window.require('child_process');

function checkPackage(packageName) {
    return new Promise((resolve) => {
        exec(`which ${packageName}`, (error, stdout, stderr) => {
            if (error || stderr) {
                resolve(false);
            } else {
                resolve(true);
            }
        });
    });
}

function installPackage(packageName) {
    return new Promise((resolve, reject) => {
        const progressBar = document.getElementById('progress-bar');
        const progressContainer = document.getElementById('progress-container');
        progressContainer.style.display = 'block'; // Show progress container

        const installProcess = exec(`sudo apt-get install -y ${packageName}`);

        installProcess.stdout.on('data', (data) => {
            const regex = /([0-9]+)%/; // Regex to find the progress percentage
            const match = regex.exec(data);
            if (match) {
                const percentage = parseFloat(match[1]);
                progressBar.value = percentage; // Update progress bar
            }
        });

        installProcess.on('close', (code) => {
            progressContainer.style.display = 'none'; // Hide progress container
            if (code === 0) {
                resolve(`Successfully installed ${packageName}`);
            } else {
                reject(`Failed to install ${packageName}`);
            }
        });

        installProcess.on('error', (error) => {
            progressContainer.style.display = 'none'; // Hide progress container on error
            reject(`Failed to start installation: ${error}`);
        });
    });
}

async function checkAndInstallPackages() {
    const packages = ['jq', 'curl', 'nmcli'];
    for (const pkg of packages) {
        const isInstalled = await checkPackage(pkg);
        if (!isInstalled) {
            const answer = confirm(`${pkg} not found! Install?`);
            if (answer) {
                try {
                    const result = await installPackage(pkg);
                    console.log(result);
                } catch (error) {
                    console.error(error);
                }
            }
        } else {
            console.log(`${pkg} is present on the system!`);
        }
    }
}

async function downloadZenShell(release) {
    const progressBar = document.getElementById('progress-bar');
    const progressContainer = document.getElementById('progress-container');
    
    progressContainer.style.display = 'block'; // Show progress container

    const curlCommand = `curl -L --progress-bar -o zenshell https://raw.githubusercontent.com/MonnXI/ZenShell/${release}/zenshell.sh`;
    const curlProcess = exec(curlCommand);

    curlProcess.stdout.on('data', (data) => {
        const regex = /([0-9]*\.[0-9]*)%/; // Regex to find the progress percentage
        const match = regex.exec(data);
        if (match) {
            const percentage = parseFloat(match[1]);
            progressBar.value = percentage; // Update progress bar
        }
    });

    curlProcess.on('close', (code) => {
        if (code === 0) {
            console.log(`${release.charAt(0).toUpperCase() + release.slice(1)} version downloaded successfully.`);
            // Move the file to /usr/bin, make it executable, and then delete the original file
            exec('sudo mv zenshell /usr/bin/zenshell && sudo chmod +x /usr/bin/zenshell && rm -f zenshell', (error) => {
                if (error) {
                    console.error('Failed to move and set executable permissions for zenshell');
                } else {
                    console.log('zenshell moved to /usr/bin and made executable.');
                    // Navigate to success page after downloading ZenShell
                    window.location.href = 'success.html'; // Redirect to success page
                }
            });
        } else {
            console.error(`Error downloading ${release} version.`);
            progressContainer.style.display = 'none'; // Hide progress container on error
        }
    });

    curlProcess.on('error', (error) => {
        console.error(`Failed to start download: ${error}`);
        progressContainer.style.display = 'none'; // Hide progress container on error
    });
}

document.addEventListener("DOMContentLoaded", function() {
    let form = document.querySelector("form");

    function checkSelectVersion() {
        let selectedVersion = document.querySelector('input[name="version"]:checked').value;
        return selectedVersion;
    }

    async function submitHandler(event) {
        event.preventDefault();
        await checkAndInstallPackages();
        const selectedVersion = checkSelectVersion();
        await downloadZenShell(selectedVersion); // Download ZenShell after packages are installed
    }

    form.addEventListener("submit", submitHandler);

    console.log("No errors");
});
