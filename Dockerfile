ARG BASE_TAG="develop"
ARG BASE_IMAGE="core-ubuntu-jammy"
FROM kasmweb/$BASE_IMAGE:$BASE_TAG
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

# Copy custom bashrc
COPY Assets/.bashrc $HOME

RUN add-apt-repository ppa:aslatter/ppa

# Install apps
RUN apt-get update && apt-get install -y kitty ranger tty-clock cmatrix htop make screen vim dnsutils zip unzip

# Install Ansible
COPY Assets/install/ansible $INST_SCRIPTS/ansible/
RUN bash $INST_SCRIPTS/ansible/install_ansible.sh  && rm -rf $INST_SCRIPTS/ansible/

# Install Terraform
COPY Assets/install/terraform $INST_SCRIPTS/terraform/
RUN bash $INST_SCRIPTS/terraform/install_terraform.sh  && rm -rf $INST_SCRIPTS/terraform/

# Autostart Kitty
COPY Assets/install/terminal/custom_startup.sh $STARTUPDIR/custom_startup.sh
RUN chmod +x $STARTUPDIR/custom_startup.sh
RUN chmod 755 $STARTUPDIR/custom_startup.sh

# Update the desktop environment to be optimized for a single application
RUN cp $HOME/.config/xfce4/xfconf/single-application-xfce-perchannel-xml/* $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/
RUN cp /usr/share/extra/backgrounds/bg_kasm.png /usr/share/extra/backgrounds/bg_default.png
RUN apt-get remove -y xfce4-panel

# Custom Background
COPY Assets/bkg.png /usr/share/extra/backgrounds/bg_default.png

# Install  Starship
RUN wget https://starship.rs/install.sh && chmod +x install.sh && ./install.sh -y
RUN mkdir $HOME/.config/starship
COPY Assets/config/starship/starship.toml $HOME/.config/starship.toml
RUN chown 1000:1000  $HOME/.bashrc

# Install and Theme Neofetch
RUN chown 1000:1000 $HOME/.bashrc && apt install neofetch -y 
RUN mkdir $HOME/.config/neofetch
COPY Assets/config/neofetch/config.conf $HOME/.config/neofetch/config.conf
COPY Assets/config/neofetch/ascii.txt $HOME/.config/neofetch/ascii.txt

### Kitty theming
RUN mkdir $HOME/.config/kitty
COPY Assets/config/kitty/kitty.conf $HOME/.config/kitty/kitty.conf
COPY Assets/config/kitty/help $HOME/.config/kitty/help

#DRACULA
COPY Assets/config/kitty/dracula/dracula.conf $HOME/.config/kitty/dracula.conf
COPY Assets/config/kitty/dracula/diff.conf $HOME/.config/kitty/diff.conf
RUN echo "include dracula.conf" >> ~/.config/kitty/kitty.conf

### Source Code Font
RUN mkdir $HOME/.fonts
COPY Assets/install/fonts/SourceCode/install.sh $HOME/.fonts/SourceCode.sh
RUN chmod +x $HOME/.fonts/SourceCode.sh
RUN bash $HOME/.fonts/SourceCode.sh && rm -rf $HOME/.fonts/SourceCode.sh

### Mono Nerd Font
RUN wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.2/FiraCode.zip -P $HOME/.fonts \
        && unzip $HOME/.fonts/FiraCode.zip -d $HOME/.fonts

### JetBrains Font
RUN mkdir /usr/share/fonts/JetBrains
COPY Assets/install/fonts/JetBrainsMono-2.242/fonts/* /usr/share/fonts/JetBrains

# Random Color Script
#RUN git clone https://gitlab.com/dwt1/shell-color-scripts.git && cd shell-color-scripts && make install


######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
