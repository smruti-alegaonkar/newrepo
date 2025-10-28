# Use official Python base image
FROM python:3.9-slim

# Set working directory inside container
WORKDIR /app

# Copy project files into the container
COPY . .

# Install dependencies (if any)
RUN pip install --upgrade pip && \
    pip install pytest

# Default command to run tests (can be changed)
CMD ["pytest"]
