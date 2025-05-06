// server enviorment :

server_env = {
  # Application Port - express server listens on this port (default 9000).
  PORT = "9000"

  # JWT access secret
  SECRET = "secret"

  # JWT refresh secret
  REFRESH_SECRET = "refreshsecret"

  # mail server settings
  SMTP_FROM = "youremail"
  SMTP_USER = "youremail"

  # Stripe secret key - https://stripe.com/docs/keys
  STRIPE_SECRET_KEY = "sk_test_4eC39HqLyjWDarjtT1zdp7dc"

  # Google OAuth2.0 settings for sign in with Google - https://console.developers.google.com/
  OAUTH_CLIENT_ID     = "287280guajkxxxxxxx.apps.googleusercontent.com"
  OAUTH_CLIENT_SECRET = "xxxxxxxxxxxxxxxxxxxx"
  OAUTH_REFRESH_TOKEN = "1"

  # Google OAuth2.0 settings for sending emails - https://console.developers.google.com/
  CLIENT_ID     = "938729280guajk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.apps.googleusercontent.com"
  CLIENT_SECRET = "xxxxxxxxxxxxxxxxxxxxxxxx"
  REFRESH_TOKEN = "1//XXXXXXXX"
}

client_env = {
  VITE_API_URL              = "pern-store-server:9000"
  VITE_GOOGLE_CLIENT_ID     = "893689195365-q5bgpgnofu5184jq0r4nu5869f53j6i4.apps.googleusercontent.com"
  VITE_GOOGLE_CLIENT_SECRET = "43EJjaP7mnyXWH8wy3ZFCR2i"
  VITE_STRIPE_PUB_KEY       = "pk_test_uuiduw984x4h4xx41489j94n"
  VITE_PAYSTACK_PUB_KEY     = "pk_test_uuiduw984x4h4xx41489j94n"
}

database_env = {
  # Postgres database local connection
  POSTGRES_USER = "postgres"
  # Postgres host (default: localhost)
  POSTGRES_HOST     = "3.84.191.228"
  POSTGRES_PASSWORD = "newpassword"
  POSTGRES_DB       = "pernstore"
  POSTGRES_PORT     = "5432"
}