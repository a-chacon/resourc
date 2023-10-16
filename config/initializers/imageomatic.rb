Imageomatic.configure do |config|
  if Rails.env.production?
    # For production deployments, set the following environment keys:
    #
    # ```
    # IMAGEOMATIC_SECRET_KEY=
    # IMAGEOMATIC_PUBLIC_KEY=
    # ```
    config.load_env
  else
    config.secret_key = "development_secret_15d3188837fc2d420964ad8eaa7f"
    config.public_key = "development_public_de599754f567d7411ec83302e156"
  end
end
