defmodule HadesWeb.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :hades,
                              module: Hades.Guardian,
                              error_handler: HadesWeb.AuthErrorHandler

    plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}, realm: "Bearer"
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource, ensure: true, allow_blank: true
end