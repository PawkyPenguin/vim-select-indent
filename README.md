Vim-Select-Indent
=================

is a Vim plugin that adds a new text object to Vim: Indented blocks. I usually find the need to delete or change indented blocks quickly when working with Java-like languages. For instance, I would like to be able to quickly delete a whole for-loop.

Installation
------------

First, you need to download your plugin. If you use a plugin manager, you hopefully know what to do (e.g. if you use vim-plug, put `Plug 'PawkyPenguin/vim-select-indent'` in your `.vimrc`).

However, Vim has recently added its own plugin managment system. Since Vim 8, I recommend installing plugins with the native plugin management. If you want to use the plugin, do the following:

```bash

cd ~/.vim/pack/<dir>/start
git clone https://github.com/PawkyPenguin/vim-select-indent

```

...where `<dir>` corresponds to the directory your plugins reside in. 

### Mappings

The plugin provides two methods that you can use: `select_inner_indent` and `select_outer_indent`. Of course you can choose any mappings you like. I personally have the following in my `.vimrc`:

```vim

if exists(':SelectIndentVersion')
	" Use indents as text objects
	onoremap ii :call selectindent#select_inner_indent()<CR>
	onoremap ai :call selectindent#select_outer_indent()<CR>

	" Select whole indents
	vnoremap ii :<c-u>call selectindent#select_inner_indent()<CR>
	vnoremap ai :<c-u>call selectindent#select_outer_indent()<CR>
endif

```

This creates mappings for both text objects and functionality for visual mode selection. For instance, you can now type `dii` to delete an inner indent (such as the content of a for-loop) and `vai` to visually select an outer indent (such as a whole method). Of course this relies on indentation levels; the plugin doesn't *actually* know anything about what for-loops look like. So be sure that your file is correctly indented!


Finally, I didn't really know where to put this, so here's a tip: The plugin stores your last cursor position, so if you accidentally select your whole file which causes your cursor to jump all the way to the top, then you can press `<C-O>` to get back to where you were.
