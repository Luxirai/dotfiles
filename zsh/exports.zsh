export EDITOR=zed
# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# pnpm end
export PATH="$HOME/.cargo/bin:$PATH"
export LIBVA_DRIVER_NAME=iHD

export JAVA_HOME="$HOME/.local/jdks/temurin17"
export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export PATH="$JAVA_HOME/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"

export ELECTRON_OZONE_PLATFORM_HINT=wayland
export GDK_SCALE=2
export QT_SCALE_FACTOR=1.5
export GSK_RENDERER=cairo

export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

# opencode
export PATH="$HOME/.opencode/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

