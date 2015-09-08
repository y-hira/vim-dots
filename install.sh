dir=`pwd`
ln -s $dir/.vimrc $HOME/.vimrc
ln -s $dir/vimfiles $HOME/.vim
mkdir $dir/vimfiles/bundle
git clone https://github.com/Shougo/neobundle.vim ./vimfiles/bundle/neobundle.vim
