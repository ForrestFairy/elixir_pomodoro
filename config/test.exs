import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :elixir_pomodoro, ElixirPomodoroWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "TH3es0OdVX9+AzWxBU3sHIuWvJu3HMgON+tlGiEQOHji30WR25x6IJUkRqSFEraO",
  server: false

# In test we don't send emails.
config :elixir_pomodoro, ElixirPomodoro.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
