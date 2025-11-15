FROM python:3.10-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    #  Required to compile C/C++ modules (gym-retro builds internal components)
    cmake \
    # Compression library with headers needed for building modules
    zlib1g-dev \
    # JPEG image support (gym-retro processes game frames)
    libjpeg-dev \
    # Audio and video processing tools (retro uses this for rendering/recording)
    ffmpeg \
    # Compiler toolchain: gcc, g++, make (needed by many Python packages)
    build-essential \
    # Allows installing packages directly from GitHub repositories
    git \
    # Clean up cached apt files to reduce image size
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --upgrade pip && pip install -r requirements.txt

COPY . .

CMD ["python", "main.py"]