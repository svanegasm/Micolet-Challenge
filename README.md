# Micolet Challenge

## Dependencies

- [Docker](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04)
- [Docker Compose](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04)

## Running the Application

**1. Clone the repository and change to the project directory:**

```bash
git clone https://github.com/svanegasm/Micolet-Challenge.git
cd Micolet-Challenge
```

**2. Check the status of the Docker service:**
```bash
sudo service docker status
```

If the Docker service is not running, start it:
```bash
sudo service docker start
```

**3. Build and start the application using Docker Compose:**
```bash
docker-compose up --build
```

**This will set up the environment and start the application. You can access it in your web browser at http://localhost:3000.**