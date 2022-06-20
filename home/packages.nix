{ config, lib, pkgs, ... }:

{
  # Bat, a substitute for cat.
  # https://github.com/sharkdp/bat
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.bat.enable
  programs.bat.enable = true;
  programs.bat.config = {
    style = "plain";
  };

  # Direnv, load and unload environment variables depending on the current directory.
  # https://direnv.net
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  # Htop
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.htop.enable
  programs.htop.enable = true;
  programs.htop.settings.show_program_path = true;

  # Zoxide, a faster way to navigate the filesystem
  # https://github.com/ajeetdsouza/zoxide
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.zoxide.enable
  programs.zoxide.enable = true;

  # Setup vim
  programs.vim.enable = true;
  programs.vim.extraConfig = 
    ''
   set showmode
   set encoding=utf8
   set ignorecase
   set smartcase
   set scrolloff=3 " 3 lines above/below cursor when scrolling
   " Emulated Plugins
   "set surround
   " Copy to system clipboard as well
   set clipboard+=unnamed
   " Use Idea to join lines smartly
   "set ideajoin
   " Multiple cursors support
   "set multiple-cursors
   " d only delete dont copy into clipboard"
   let mapleader = ","
   let g:mapleader = ","
   nnoremap x "_x
   nnoremap X "_X
   nnoremap d "_d
   nnoremap D "_D
   vnoremap d "_d
   nnoremap s "_s
   nnoremap S "_S
   vnoremap s "_s
   " replace currently selected text with default register
   " without yanking it
   if has('unnamedplus')
     set clipboard=unnamed,unnamedplus
     nnoremap <leader>d "+d
     nnoremap <leader>D "+D
     vnoremap <leader>d "+d
   else
     set clipboard=unnamed
     nnoremap <leader>d "*d
     nnoremap <leader>D "*D
     vnoremap <leader>d "*d
   endif
   if has('unnamedplus')
     set clipboard=unnamed,unnamedplus
     nnoremap <leader>s "+s
     nnoremap <leader>S "+S
     vnoremap <leader>s "+s
   else
     set clipboard=unnamed
     nnoremap <leader>s "*s
     nnoremap <leader>S "*S
     vnoremap <leader>s "*s
     endif
   " Use Q for formatting the current paragraph (or visual selection)
    vmap Q gq
    nmap Q gqap
   " These create newlines like o and O but stay in normal mode
    nmap zj o<Esc>k
    nmap zk O<Esc>j
   " key bindings for quickly moving between windows
   " h left, l right, k up, j down
   " nmap <leader>h <c-w>h
   " nmap <leader>l <c-w>l
   " nmap <leader>k <c-w>k
   " nmap <leader>j <c-w>j
   " Closing tabs
    nmap <leader>q :action CloseContent<cr>
    nmap <leader>Q :action ReopenClosedTab<cr>
   " To navigate between split panes
    nmap <leader>wo :action NextSplitter<cr>
    nmap <leader>wp :action PrevSplitter<cr>
    nmap <leader>j :action PrevSplitter<cr>
   " Splits manipulation
    nmap <leader>ws :action SplitHorizontally<cr>
    nmap <leader>wv :action SplitVertically<cr>
    nmap <leader>wc :action Unsplit<cr>
    nmap <leader>wC :action UnsplitAll<cr>
    nmap <leader>wd :action OpenEditorInOppositeTabGroup<cr>
    nmap <leader><leader> :action VimFilePrevious<cr>
   " nmap <leader>ww :action JumpToLastWindow<cr>
   " Navigation
    nmap <leader>h :action Back<cr>
    nmap <leader>l :action Forward<cr>
    nmap <leader>L :action RecentLocations<cr>
    nmap <leader>g :action GotoDeclaration<cr>
    nmap <leader>u :action FindUsages<cr>
    nmap <leader>f :action GotoFile<cr>
    nmap <leader>c :action GotoClass<cr>
    nmap <leader>s :action GotoSymbol<cr>
  " nmap <leader>m :action FileStructurePopup<cr>
    nmap <leader>; :action FileStructurePopup<cr>
    nmap <leader>M :action ActivateStructureToolWindow<cr>
    nmap <leader>d :action ShowErrorDescription<cr>
    nmap <leader>i :action GotoImplementation<cr>
    nmap <leader>I :action SelectIn<cr>
    nmap <leader>e :action RecentFiles<cr>
    nmap <leader>t :action GotoTest<cr>
    nmap <leader>p :action JumpToLastWindow<cr>
    nmap <leader>b :action ShowBookmarks<cr>
  " nmap <leader>a :action Switcher<cr>
    nmap <leader>a :action RecentChangedFiles<cr>
  " Errors
    nmap <leader>x :action GotoNextError<cr>
    nmap <leader>X :action GotoPreviousError<cr>
  " Refactorings
    vmap T :action Refactorings.QuickListPopupAction<cr>
    nmap <leader>rr :action RenameElement<cr>
    nmap <leader>rg :action Generate<cr>
    nmap <leader>rI :action OptimizeImports<cr>
  " Inspection
    nmap <leader>rc :action InspectCode<cr>
  " VCS operations
    nmap <leader>yy :action Vcs.Show.Local.Changes<cr>
    nmap <leader>yp :action Vcs.QuickListPopupAction<cr>
    nmap <leader>ya :action Annotate<cr>
    nmap <leader>yl :action Vcs.Show.Log<cr>
    nmap <leader>yd :action Compare.LastVersion<cr>
  " nmap <leader>yr :action Git.ResolveConflicts<cr>
  " Terminal
    nmap <leader>T :action ActivateTerminalToolWindow<cr>
  " External GVim
    nmap <leader>v :action Tool_External Tools_gvim<cr>
  " External Emacs
    nmap <leader>E :action Tool_External Tools_emacsclient<cr>
  " External Sublime Text
    nmap <leader>S :action Tool_External Tools_sublime_text<cr>
  " IdeaVim uses 'a' for alt instead of Vim's 'm'
    nmap <a-j> 15gj
    nmap <a-k> 15gk
  " Won't work in visual mode (with vmap) for some reason.
  " Use default map of <c-/> for that.
    nmap gcc :action CommentByLineComment<cr>
  " unimpaired mappings - from https://github.com/saaguero/ideavimrc/blob/master/.ideavimrc
    nnoremap [<space> O<esc>j
    nnoremap ]<space> o<esc>k
    nnoremap [q :action PreviousOccurence<cr>
    nnoremap ]q :action NextOccurence<cr>
    nnoremap [m :action MethodUp<cr>
    nnoremap ]m :action MethodDown<cr>
    nnoremap [c :action VcsShowPrevChangeMarker<cr>
    nnoremap ]c :action VcsShowNextChangeMarker<cr>
    " Tabs
    nnoremap [b :action PreviousTab<cr>
    nnoremap ]b :action NextTab<cr>
    " Search
    nmap <leader>/ :action Find<cr>
    nmap <leader>\ :action FindInPath<cr>
    " Moving lines
    nmap [e :action MoveLineUp<cr>
    nmap ]e :action MoveLineDown<cr>
    " Moving statements
    nmap [s :action MoveStatementUp<cr>
    nmap ]s :action MoveStatementDown<cr>
    " Building, Running and Debugging
    nmap ,c :action CompileDirty<cr>
    nmap ,r :action Run<cr>
    nmap ,R :action RunAnything<cr>
    nmap ,b :action Debug<cr>
    nmap ,c :action RunClass<cr>
    nmap ,d :action DebugClass<cr>
    nmap ,t :action RerunTests<cr>
    nmap ,T :action RerunFailedTests<cr>
    '';

  home.packages = with pkgs; [
    # Some basics
    #dart
    git
    curl
    tree
    cascadia-code
    exa # fancy version of `ls`
    fd # fancy version of `find`
    htop # fancy version of `top`


    # Useful nix related tools
    cachix # adding/managing alternative binary caches hosted by Cachix
    comma # run software from without installing it
    niv # easy dependency management for nix projects
    nix-tree # interactively browse dependency graphs of Nix derivations
    nix-update # swiss-knife for updating nix packages
    nixpkgs-review # review pull-requests on nixpkgs
    nodePackages.node2nix
    statix # lints and suggestions for the Nix programming language

  ] ++ lib.optionals stdenv.isDarwin [
    cocoapods
    m-cli # useful macOS CLI commands
  ];
}
