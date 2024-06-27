FROM python:3.8.19-alpine AS base
ENV DEBIAN_FRONTEND=noninteractive


FROM base AS permission
ARG UID=1000
ARG GID=1000
ARG USER_NAME=app
ARG SRC_DIR=/var/www

RUN addgroup -g ${GID} ${USER_NAME}
RUN adduser -D -s /bin/sh -G ${USER_NAME} -u ${UID} ${USER_NAME}
RUN mkdir ${SRC_DIR}
RUN chown -R ${USER_NAME}:${USER_NAME} ${SRC_DIR}

FROM permission AS dependencies
WORKDIR ${SRC_DIR}
USER ${USER_NAME}

ENV PATH=/home/${USER_NAME}/.local/bin/:${PATH}
COPY --chown=${USER_NAME}:${USER_NAME} ./requirements.txt ./requirements.txt
RUN python -m pip install -r requirements.txt

FROM dependencies AS develop
WORKDIR ${SRC_DIR}
USER ${USER_NAME}

EXPOSE 8000
CMD ["uvicorn", "app.main:app", "--reload", "--host", "0.0.0.0", "--port", "8000"]