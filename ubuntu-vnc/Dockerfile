FROM dorowu/ubuntu-desktop-lxde-vnc:focal-lxqt

RUN apt update \
    && apt install -y --no-install-recommends --allow-unauthenticated \
        thunderbird gimp vim mlocate gtk2-engines obconf less \
    && apt autoclean -y \
    && apt autoremove -y \
