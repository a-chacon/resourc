# resourc Project

**Project Description:** resourc is a community-driven platform for sharing technical articles, tools, open-source projects, and everything related to programming. Connect with developers, share knowledge, and grow together.

## Table of Contents
- [Getting Started](#getting-started)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Deployment](#deployment)
- [Built With](#built-with)
- [License](#license)

## Getting Started

This section provides an overview of your project and how to get it up and running.

### Prerequisites

- Ruby: Make sure you have Ruby installed. You can download it from [ruby-lang.org](https://www.ruby-lang.org/en/).
- Ruby on Rails: Your project is built with Rails. You can install it using `gem install rails`.
- SQLite: The production database used is SQLite.
- AWS S3: For storing images, this project uses AWS S3. Ensure you have AWS S3 credentials.

### Installation

1. Clone this repository.

```
git clone https://github.com/yourusername/resourc.git
```

2. Change into the project directory.

```
cd resourc
```
3. Install gem dependencies.

```
bundle install
```

4. Create and migrate the database.

```
rails db:create db:migrate
```


### Configuration

- Ensure you have the AWS S3 credentials set up. You can store them in the Rails `secrets.yml` or use environment variables.
- Configure your database settings in `config/database.yml`.

### Usage

Explain how to use your project. Provide examples and describe key features.

### Deployment

1. Set your environment to production.

```
export RAILS_ENV=production
```

2. Precompile your assets.

```
rails assets:precompile
```

3. Start your Rails server.

```
rails server -e production
```


### Built With

- Ruby on Rails
- SQLite
- AWS S3

## License

This project is licensed under the [License Name] - see the [LICENSE.md](LICENSE.md) file for details.

