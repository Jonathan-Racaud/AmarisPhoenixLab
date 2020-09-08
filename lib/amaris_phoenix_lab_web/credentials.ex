# This module is taken from this discussion on the Pow github
# https://github.com/danschultzer/pow/issues/271#issuecomment-631209633
#
# It is to allow getting the current_user in the live view

defmodule AmarisPhoenixLabWeb.Credentials do
  @moduledoc "Authentication helper functions"

  alias AmarisPhoenixLab.Users.User
  alias Phoenix.LiveView.Socket
  alias Pow.Store.CredentialsCache

  @doc """
  Retrieves the currently-logged-in user from the Pow credentials cache.
  """
  @spec get_user(
          socket :: Socket.t(),
          session :: map(),
          config :: keyword()
        ) :: %User{} | nil

  def get_user(socket, session, config \\ [otp_app: :amaris_phoenix_lab])

  def get_user(socket, %{"amaris_phoenix_lab_auth" => signed_token}, config) do
    conn = struct!(Plug.Conn, secret_key_base: socket.endpoint.config(:secret_key_base))
    salt = Atom.to_string(Pow.Plug.Session)

    with {:ok, token} <- Pow.Plug.verify_token(conn, salt, signed_token, config),
         # Replaced  `[backend: Pow.Store.Backend.EtsCache]` with `config`
         {user, _metadata} <- CredentialsCache.get(config, token) do
      user
    else
      _any -> nil
    end
  end

  def get_user(_, _, _), do: nil
end
