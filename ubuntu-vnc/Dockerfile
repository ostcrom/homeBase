FROM dorowu/ubuntu-desktop-lxde-vnc

RUN apt update \
    && apt install -y --no-install-recommends --allow-unauthenticated \
        thunderbird gimp vim\
    && apt autoclean -y \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*
