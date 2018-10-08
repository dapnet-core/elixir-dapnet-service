defmodule DapnetService.Plug.BasicAuth do
  import Plug.Conn
  @realm "Basic realm=\"Login\""

  def init(opts), do: opts

  def call(conn, _) do
    case get_req_header(conn, "authorization") do
      ["Basic " <> auth] -> verify(conn, auth)
      _ ->
        unauthorized(conn)
    end
  end

  defp verify(conn, auth) do
    [username, password] = auth |> Base.decode64!() |> String.split(":")

    params = %{"username" => username, "password" => password}
    |> Poison.encode!()

    case HTTPoison.post("http://auth/auth/users/login", params) do
      {:ok, response} ->
        result = Poison.decode!(response.body)
        Plug.Conn.assign(conn, :login, result)
      _ ->
        unauthorized(conn)
    end
  end

  defp unauthorized(conn) do
    conn
    |> put_resp_header("www-authenticate", @realm)
    |> send_resp(401, "Unauthorized")
    |> halt()
  end
end
