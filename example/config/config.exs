import Config

config :fleature,
  host: "localhost",
  port: 4002,
  client_id: "XXXX",
  client_secret: "XXXX",
  feature_flags: %{
    "test" => false
  }

# Configures the endpoint
config :fleature_test, FleatureTestWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: FleatureTestWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: FleatureTest.PubSub,
  live_view: [signing_salt: "Uia3VBMl"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :fleature_test, FleatureTest.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.12.18",
  default: [
    args: ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
