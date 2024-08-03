FROM nvidia/cuda:12.5.1-cudnn-devel-ubuntu20.04 AS base

RUN apt-get update && \
    apt-get install -y python3-pip python3-dev wget git fontconfig fuse curl unzip && \
    rm -rf /var/lib/apt/lists/*

# Install Node.js and npm for nvim's LSP
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs

# Download and extract Neovim with appimage
RUN wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage && \
    chmod u+x nvim.appimage && \
    ./nvim.appimage --appimage-extract && \
    ln -s /squashfs-root/usr/bin/nvim /usr/bin/nvim && \
    rm nvim.appimage

# Copy nvim config files
COPY nvim /root/.config/nvim

# Copy Nerd Fonts JetBrains Mono for nvchad 
COPY fonts/JetBrainsMono /usr/share/fonts/truetype/jetbrainsmono

# Rebuild the font cache
RUN fc-cache -f -v

RUN pip3 install --no-cache-dir --upgrade pip && \
    pip3 install --no-cache-dir jupyter

WORKDIR /workspace

# Expose jupyter's port 
EXPOSE 8888

# Lazy script for lazy ppl
COPY jupyter.sh /home/jupyter.sh
RUN chmod +x /home/jupyter.sh

CMD ["bash"]

####################################################################
# Base Pytorch
FROM base AS pytorch 

RUN pip install --no-cache-dir torch torchvision torchaudio


###################################################################
# Jax 
FROM base AS jax 

RUN pip install -U "jax[cuda12]" jaxlib





