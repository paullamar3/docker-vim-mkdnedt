## Dockerfile for creating Markdown documents
FROM paullamar3/docker-vim:v0.1
MAINTAINER Paul LaMar <pal3@outlook.com>

# Add lines for the tabular, vim-markdown plugins
RUN sed -i "s/call plug#end()/Plug 'godlygeek\/tabular'\nPlug 'plasticboy\/vim-markdown'\n&/" /home/vim/.vimrc

# Add command to treat '.page' files as markdown.
RUN printf "%b" "\n\" Treat gitit's .page files as markdown\n" >> /home/vim/.vimrc && \
    printf "%b" "autocmd BufNewFile,BufRead *.page  set filetype=markdown\n" >> /home/vim/.vimrc && \
    printf "%b" "\" Some markdown specific settings\n" >> /home/vim/.vimrc && \
    printf "%b" "set nowrap \nset spell \nset textwidth=79 \n" >> /home/vim/.vimrc && \
    printf "%b" "highlight SpellBad ctermbg=5 \n" >> /home/vim/.vimrc 

COPY entrypoint.sh /home/vim/

# Put us in the vim home folder
WORKDIR /home/vim/

# Make the 'mkdn' folder
RUN mkdir mkdn
RUN chown vim mkdn

# Switch to vim user
USER vim

# Install the new vim plugins.
RUN vim -c "PlugInstall|q|q"

ENTRYPOINT ["/home/vim/entrypoint.sh"]
