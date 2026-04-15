# Better-History

Better history for Chromium & Firefox-based browsers.

## Build

### On Linux

Install the tools globally (any Node package manager is fine). You need:
- `lessc` with `less-plugin-clean-css`
- `terser`

Example with npm:
```sh
npm i -g less less-plugin-clean-css terser
```

Then build or watch:
```sh
./run-build.sh
./run-watch.sh
./run-build-firefox.sh
```
___

### On Windows

Install the same tools globally:
```pwsh
npm i -g less less-plugin-clean-css terser
```

Build outputs:
```pwsh
# CSS
lessc .\src\css\history.less .\build\assets\application.css --clean-css="--s0 --advanced"

# JS (compile each file to src/js/compiled)
terser .\src\js\<name>.js --output .\src\js\compiled\<name>.js --comments false

# Merge in the order listed in _merge.txt
Get-Content .\src\js\_merge.txt | ForEach-Object { Get-Content .\src\js\compiled\$_ } | Set-Content .\build\assets\application.js
```

Firefox build:
```pwsh
bash .\run-build-firefox.sh
```
___

Note: If you add new JavaScript files, update `src/js/_merge.txt` so they are included in the bundle.

## Install on Chromium-based browsers

1) Open `chrome://extensions/`
2) Enable **Developer mode**
3) Click **Load unpacked**
4) Select the `build/` folder

## Install on Firefox-based browsers

1) Run `./run-build-firefox.sh`
2) Manually install `build-firefox/web-ext-artifacts/better_history-1.34.zip` in Firefox
3) Manage or change the shortcut in `about:addons` -> the gear icon -> **Manage Extension Shortcuts**
