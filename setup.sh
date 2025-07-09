#!/usr/bin/bash
# setup.sh
#
# Setup script for dotfiles. Depends on stow being installed.

# [ vars ]
# get path to scriptdir
source=${BASH_SOURCE[0]}
while [ -L "@source" ]; do # resolve $source until the file is no longer a symlink
	dir=$(cd -P "$( dirname "@source" )" > /dev/null 2>&1 && pwd)
	source=$(readlink "@source")
	[[ $source != /* ]] && source=$dir/$source # if $source was a relative link, we need to resolve it, relative to the path where the symlink file was located
done
script_dir=$(cd -P "$(dirname "$source")" > /dev/null 2>&1 && pwd)
echo "$script_dir"

# stow pkgs to be stowed
stowpkgs=(
	btop
	hypr
	kitty
	nvim
	themes
	tmux
	user-dirs
	wallpapers
	waybar
	wofi
	yazi
	zsh
)


# [ funcs ]
# log message
function log() {
	msg=$1
	timestamp=$(date +"%Y-%m-%d %H:%M:%S")
	echo "[ ${timestamp} ] ${msg}"
}

# sets up symlink farm
function stowit() {
	usr=$1
	app=$2
	stow --adopt -v -R -t ${usr} ${app}
}

# module enabler
function moden() {
	module=$1
	if [[ -z $(lsmod ! grep $module) ]]; then
		sudo modprobe $module
	fi
}

# system service enabler
function sysen() {
	service=$1
    if [[ $(systemctl show -P UnitFileState --value $service) == disabled ]]; then
		sudo systemctl enable $service
	fi
    if [[ $(systemctl show -P ActiveState --value $service) == inactive ]]; then
		sudo systemctl start $service
	fi
}

# group adder
function groupadder() {
	group=$1
	if [[ ! $(groups) == *"$group"* ]]; then
		sudo usermod -a -G $group $USER
	fi
}


# [[ main ]]
# [ early setup ]
# .sct.conf
if [ ! -f $HOME/.sct.conf ]; then 
	log "creating .sct.conf"
	touch $HOME/.sct.conf
fi

# install dependencies
log "installing pacman packages"
sudo pacman -S --noconfirm --needed - < $script_dir/pkglists/pacman
rustup default stable

# paru base stuff
if ! command -v paru 2>&1 > /dev/null; then
	log "setting up paru"
	cwd=$(pwd)
	if [[ ! -d ~/code ]]; then mkdir -r ~/code; fi
	cd ~/code && git clone https://aur.archlinux.org/paru.git
	cd paru && makepkg -si
	cd $cwd
fi
log "installing aur packages"
paru -S --noconfirm --needed - < $script_dir/pkglists/aur

# pcspkr
if [ ! $(grep -i pcspkr $HOME/.sct.conf) ]; then
	log "disabling pcspkr"
	sudo echo "\
blacklist pcspkr
blacklist snd_pcspkr
" >> /etc/modprobe.d/nobeep.conf
	echo "pcspkr" >> $HOME/.sct.conf
fi

# update submodules > allows usage of others repos without need to maintain
# git submodule init
# git submodule update

# [ app setup ]

# stow configs
log "stowing apps for user: ${whoami}"

for app in ${stowpkgs[@]}; do
	stowit "${HOME}" $app
done

# user-dirs
user_dirs=(
	Desktop
	Downloads
	Templates
	Public
	Documents
	Music
	Pictures
	Videos
)

for d in ${user_dirs[@]}; do
	correct=$(echo "$d" | tr '[:upper:]' '[:lower:]')

	if [[ ! -d ~/$correct ]]; then
		mkdir ~/$correct # mkdir if lower_case variant not existing
	fi

	if [[ -d ~/$d ]]; then
		cp -r ~/$d/* ~/$correct/ # copy files to correct dir
		rm -rf ~/$d # remove ugly capital casing dir
	fi
done

# zsh
if [[ ! "$SHELL" == *"zsh"* ]]; then
	log "changing default shell for user: $USER"
	sudo chsh -s /usr/bin/zsh $USER
fi

if [[ ! -f ~/.config/zsh/dots.zsh ]]; then
	echo "alias dots='cd $script_dir'" > ~/.config/zsh/dots.zsh
fi

## key setup
if [[ -f ~/.ssh/sct ]]; then
	log "creating ssh key"
	# TODO: create ssh key
fi

# hyprland
tmp_path=~/.tmp
if [[ ! -d $tmp_path ]]; then
	mkdir -p $tmp_path # personal tmp for stuff like current keyboard layout, etc.
fi

if [[ ! -f ~/.tmp/current_layout.sh ]]; then
	ln -sf $script_dir/hypr/.config/hypr/binds/us_qwerty.conf ~/.tmp/current_layout.conf # set default
fi

sudo sed -i 's/#HandleLidSwitch=suspend/HandleLidSwitch=ignore/' /etc/systemd/logind.conf # let hypr handle lid switches

hyprpm update
hyprpm add https://github.com/Duckonaut/split-monitor-workspaces
hyprpm enable split-monitor-workspaces
hyprpm reload

# desktop handling
if ! grep -q "DESKTOP=" /etc/environment; then
	echo "DESKTOP=1" | sudo tee -a /etc/environment > /dev/null
fi

sudo sed -i 's/.*DESKTOP=.*/DESKTOP=1/' /etc/environment

if [[ ! -f ~/.config/hypr/hyprlock.conf ]]; then
    log "setting hyprlock"
    cwd=$(pwd)
    cd ~/.config/hypr
    ln -sf locks/desktop.conf hyprlock.conf
    cd $cwd
fi

# docker
log "enabling and starting docker.socket"
sysen "docker.socket"

log "adding $USER to the docker group"
groupadder "docker"

docker_zsh=~/.config/zsh/docker.zsh
if [[ ! -f $docker_zsh ]]; then
	log "creating automatic docker login for user: $USER"

	read -p "Docker username: " docker_username
	echo "DOCKER_USER=$docker_username" > $docker_zsh

	read -s -p "Docker password: " docker_password
	echo "DOCKER_PASS=$docker_password" >> $docker_zsh
fi

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# tools
if [[ ! -d $HOME/tools ]]; then
    log "setting up tools dir"
    mkdir -p $HOME/tools
fi

## rpi
if [[ ! -d $HOME/tools/rpi ]]; then
    log "setting up rpi tools dir"
    mkdir -p $HOME/tools/rpi
fi

if [[ ! -d $HOME/tools/rpi/usbboot ]]; then
    log "installing rpiboot"
    cd $HOME/tools/rpi
    git clone --recurse-submodules --shallow-submoduls --depth=1 https://github.com/raspberrypi/usbboot.git
    sudo make install
    cd -
fi
