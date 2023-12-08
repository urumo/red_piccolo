# Red Piccolo (Codename)

## About The Project

Red Piccolo is an upcoming instant messaging application that offers more than just a platform to communicate. It is
designed to allow users to not only share their moments but also handle finances securely and swiftly with one another.
With a strong emphasis on security and speed, Red Piccolo aims to redefine the way we think about connectivity in our
daily lives.

## Prerequisites

Before you begin, ensure you have met the following requirements:

- PostgreSQL and Redis must be running on your system.
    - **PostgreSQL**: Set the `DATABASE_URL` environment variable with your PostgreSQL connection string.
    - **Redis**: Set the `REDIS_URL` environment variable with your Redis connection string.
- Node.js and Yarn must be installed for managing front-end dependencies.
- GCC must be installed to compile native extensions.
- Ruby version 3 or higher must be installed for managing back-end dependencies.

## Getting Started

To get a local copy up and running follow these simple steps.

### Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/urumo/red_piccolo.git
   ```
2. Install dependencies:
   ```sh
    bundle install --jobs 4
    yarn install
   ```
3. Prepare the database:
   ```sh
   rails db:prepare
   ```
4. Precompile the assets
    ```sh
    rails assets:precompile
    ```
5. Start the server:
   ```sh
    rails server
   ```
   This will start the Rails application on the default port. Visit http://localhost:3000 in your web browser to view the application.

## Building the Docker Image
- To build the Docker image for production, run:
    ```sh
    docker build -t red_piccolo:latest .
    ```
- To build the Docker image for development, run:
    ```sh
    docker build -f Dockerfile.dev -t redpiccolo:dev .
    ```

Replace redpiccolo with the name you prefer for your Docker image.

## Contributing
We welcome contributions to Red Piccolo. Any contributions you make are greatly appreciated.

1. Fork the Project
2. Create your Feature Branch (git checkout -b feature/AmazingFeature)
3. Commit your Changes (git commit -m 'Add some AmazingFeature')
4. Push to the Branch (git push origin feature/AmazingFeature)
5. Open a Pull Request

## License
Distributed under the [MIT](https://github.com/urumo/red_piccolo/blob/main/LICENSE) License. See LICENSE for more information.

## Contact
- [Aram Hayrapetyan](https://telegram.me/svcklite)
