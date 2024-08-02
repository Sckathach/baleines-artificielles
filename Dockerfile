FROM pytorch/pytorch:2.4.0-cuda11.8-cudnn9-devel

RUN apt-get update && \
    apt-get install -y wget git python3-pip fontconfig fuse curl unzip && \
    rm -rf /var/lib/apt/lists/*

# Install Node.js and npm
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs

# Download and extract Neovim with appimage 
RUN wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage && \
    chmod u+x nvim.appimage && \
    ./nvim.appimage --appimage-extract && \
    mv squashfs-root / && \
    ln -s /squashfs-root/usr/bin/nvim /usr/bin/nvim && \
    rm nvim.appimage

# RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.5.56/quarto-1.5.56-linux-amd64.tar.gz && \
#    tar -C /opt -xvzf quarto-1.5.56-linux-amd64.tar.gz && \
#    mkdir -p /root/.local/bin && \
#    ln -s /opt/quarto-1.5.56/bin/quarto /root/.local/bin/quarto && \
#    echo 'export PATH=$PATH:/root/.local/bin' >> /root/.bashrc

# Install Jupyter Notebook
RUN pip install --no-cache-dir jupyter 

WORKDIR /workspace

# Expose port for Jupyter Notebook
EXPOSE 8888

# Copy nvim config files 
COPY nvim /root/.config/nvim

# Copy Nerd Fonts JetBrains Mono
COPY fonts/JetBrainsMono /usr/share/fonts/truetype/jetbrainsmono

# Rebuild the font cache
RUN fc-cache -f -v

# Lazy script for lazy ppl
COPY jupyter.sh /home/jupyter.sh
RUN chmod +x /home/jupyter.sh

CMD ["bash"]
