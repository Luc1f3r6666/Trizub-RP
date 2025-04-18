FROM ubuntu:20.04

# Встановлюємо необхідні пакети
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    wget unzip build-essential libstdc++6 libc6-i386 && \
    rm -rf /var/lib/apt/lists/*

# Створюємо робочу директорію
WORKDIR /samp

# Завантажуємо та встановлюємо PAWN Compiler
RUN wget https://github.com/pawn-lang/compiler/releases/download/v3.10.10/pawnc-linux.zip && \
    unzip pawnc-linux.zip -d /pawnc && \
    chmod +x /pawnc/pawnc && \
    mv /pawnc/pawnc /usr/local/bin/pawnc && \
    rm -rf /pawnc pawnc-linux.zip

# Копіюємо всі файли сервера
COPY . .

# Компілюємо gamemode (заміни "trizub.pwn" на свою назву)
RUN pawnc gamemodes/trizub.pwn -o gamemodes/trizub.amx

# Запускаємо сервер
CMD ["./samp03svr"]
