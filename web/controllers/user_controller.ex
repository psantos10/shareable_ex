defmodule ShareableEx.UserController do
  use ShareableEx.Web, :controller

  #alias ShareableEx.Repo
  alias ShareableEx.User

  def profile(conn, _params) do
    #text conn, "Hello UserProfile: #{conn.params["username"]}"
    user = Repo.get_by(User, username: conn.params["username"])

    render conn, "profile.html", user: user
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "Account created successfully.")
        |> redirect(to: "/@#{user_params["username"]}") #user_path(conn, :profile, user_params["username"]))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

end
