
## Dockerfile for creating Journal documents
FROM paullamar3/vim-7.4:v0.2
MAINTAINER Paul LaMar

# Add lines for the tabular, vim-markdown and fugitive plugins
RUN sed -i "s/call plug#end()/Plug 'godlygeek\/tabular'\nPlug 'plasticboy\/vim-markdown'\nPlug 'tpope\/vim-fugitive'\n&/" /home/vim/.vimrc 
RUN printf "%b" "\n\" Treat gitit's .page files as markdown\n" >> /home/vim/.vimrc && \
    printf "%b" "autocmd BufNewFile,BufRead *.page  set filetype=markdown\n" >> /home/vim/.vimrc

WORKDIR /home/vim/

RUN mkdir journal && chown vim journal

USER vim

RUN vim -c "PlugInstall|q|q"

## CMD /bin/bash
ENTRYPOINT ["vim"]
