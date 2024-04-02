if [ ! -d ~/.sbash ]; then
    mkdir ~/.sbash
fi

rsync -av --progress . ~/.sbash/ \
     --exclude .gitignore \
     --exclude .git/ \
     --exclude .github

if [ -f ~/.bashrc ]; then
     mv ~/.bashrc ~/.bashrc.old
fi

echo "source ~/.sbash/.bashrc" > ~/.bashrc

touch ~/.sbash/lib/secret.sh

exec bash -l