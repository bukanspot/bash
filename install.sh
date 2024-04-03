install() {
     echo "Installing..."
     echo "source ~/.sbash/.bashrc" > ~/.bashrc

     rsync -av --progress . ~/.sbash/ \
          --exclude .gitignore \
          --exclude .git/ \
          --exclude .github/

     touch ~/.sbash/lib/secret.sh
}

update() {
     echo "Updating installation..."
     rsync -av --progress . ~/.sbash/ \
          --exclude .gitignore \
          --exclude .github/ \
          --exclude .git/ \
          --exclude themes/ \
          --exclude lib/
}

reinstall() {
     echo "Cleaning up..."
     cd ~
     rm -rf ~/.sbash/
     cd $working_dir
     install
}

uninstall() {
     echo "Uninstalling..."
     cd ~
     rm -rf .sbash
     rm -f .bashrc
     if [ -f ~/.bashrc.old ]; then
          mv ~/.bashrc.old ~/.bashrc
     fi
}

if [ "$1" == "clean" ]; then
     working_dir=$(pwd)
     if [ $(basename $working_dir) == ".sbash" ]; then
          echo "Please run clean option from source, not from the instalation directory."
          echo "For more information please visit: https://github.com/bukanspot/sbash"
          exit 1
     fi
     reinstall
elif [ "$1" == "remove" ]; then
     if [ -d ~/.sbash ]; then
          uninstall
     else
          echo "The script is not installed."
          echo "Do you want to install the script? (y/n)"; read answer
          if [ "$answer" == "y" ]; then
               install
          fi
     fi
else
     if [ -d ~/.sbash ]; then
          working_dir=$(pwd)
          if [ -n "$working_dir" ] && [ $(basename "$working_dir") == ".sbash" ]; then
               echo "The script is already installed."
               echo "Do you want to remove the installation? (y/n)"; read answer
               if [ "$answer" == "y" ]; then
                    uninstall
               fi
          else
               update
          fi
     else
          if [ -f ~/.bashrc ]; then
               mv ~/.bashrc ~/.bashrc.old
          fi
          install
     fi
fi

exec bash -l