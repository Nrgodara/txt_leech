FROM ubuntu:latest

RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends gcc libffi-dev musl-dev ffmpeg aria2 python3-venv python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /app/
WORKDIR /app/

# Create and activate virtual environment
RUN python3 -m venv venv
ENV PATH="/app/venv/bin:$PATH"

# Install Python packages
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir --requirement requirements.txt

CMD python3 modules/main.py
