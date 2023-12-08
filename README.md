# Red Piccolo (Codename)

## About The Project

Red Piccolo is an ambitious instant messaging application that goes beyond conventional communication. It's designed to be a multi-faceted platform, allowing users not only to share life's moments but also to manage finances with ease and security. Red Piccolo will stand out with its commitment to speed and high security, setting a new standard for instant messaging applications.

The development of Red Piccolo is planned in multiple phases:

1. **Relay of Telegram**: Initially, Red Piccolo will act as a relay for Telegram, allowing users to connect and communicate using their existing Telegram accounts.
2. **Finances (Potential Crypto Integration)**: A key phase will introduce financial functionalities, potentially including cryptocurrency transactions, to provide users with a seamless financial exchange experience.
3. **Artificial Intelligence**: AI will play a role in enhancing user interactions, offering intelligent features that adapt to user needs.
4. **Standalone Product**: The final goal is to establish Red Piccolo as a standalone product, independent and full-featured, to serve as a primary platform for users' communication and financial needs.


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
