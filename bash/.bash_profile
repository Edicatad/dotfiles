# .bash_profile

# Source bashrc if it exists
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# Source .profile if it exists
if [ -f ~/.profile ]; then
	. ~/.profile
fi

# User specific environment and startup programs
PATH=$PATH:$HOME/.local/bin:$HOME/bin
export PATH
# Rust
export PATH="$HOME/.cargo/bin:$PATH"
