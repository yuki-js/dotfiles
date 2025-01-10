FROM kalilinux/kali-rolling:latest

RUN apt-get update \
    && apt-get upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        sudo curl ca-certificates

# Create a non-root user

ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo $USERNAME ALL=\(root\) ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Set password for the user as empty

RUN passwd -d $USERNAME

USER $USERNAME

WORKDIR /home/$USERNAME

# Install dotfiles
ENV DF_NO_DOCKER=1
ENV DF_SKIP_CONFIRM=1
RUN sh -c "$(curl -fSsL https://l.aoki.app/dotfiles)"

# re-enable password
RUN echo "$USERNAME:1919" | sudo chpasswd

CMD ["/usr/bin/zsh"]