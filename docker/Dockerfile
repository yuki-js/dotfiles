FROM debian:bookworm-slim

RUN apt-get -o Acquire::Retries=5 update \
    && DEBIAN_FRONTEND=noninteractive apt-get -o Acquire::Retries=5 upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get -o Acquire::Retries=5 install -y --no-install-recommends \
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
ENV DF_NO_NODEJS=1
ENV DF_NO_PYTHON=1
ENV DF_NO_AI_CLI=1
ENV DF_NO_SSH_IMPORT=1
COPY --chown=$USERNAME:$USERNAME . /home/$USERNAME/codes/dotfiles
RUN bash /home/$USERNAME/codes/dotfiles/scripts/entrypoint.sh

# re-enable password
RUN echo "$USERNAME:1919" | sudo chpasswd

# Record the build date as ~/.build_date
RUN echo `date -u +"%Y-%m-%dT%H:%M:%SZ"` > ~/.build_date


CMD ["/usr/bin/zsh"]