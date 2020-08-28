# RemoteBackend
This is the Elixir Backend that powers the automated point assigment for users :-)

- This application is standard elixir application that uses the [Phoenix](https://www.phoenixframework.org/) library to provide an endpoint for retrieval of users.

- Basic familiarity with Elixir is a pre requisite 

- The application has a dependency on PostgresQL for data storage
  

### Installation

Clone repo
```shell
git clone https://github.com/churcho/remote_backend
cd remote_backend
```

Install Dependencies

This project uses [`asdf-elixir`](https://github.com/asdf-vm/asdf-elixir) for managing Elixir versions. Refer to the asdf documentation on how to run different version per project.

```shell
asdf install
mix deps.get
```

Setup initial seed configs
```shell
# In your config/config.exs file
config :remote_backend,
  max_points: 100, # Maximum points a user can be awarded
  max_user_seed: 100 #You can change this to test performance
```

Create and Migrate Database

This process will seed the initial database with random users.
The number of initial users to seed is specified in the 

```shell
mix ecto.setup
```

### Start Server

```shell
mix phx.server
```

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.




