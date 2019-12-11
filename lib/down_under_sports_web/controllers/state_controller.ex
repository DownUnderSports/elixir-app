defmodule DownUnderSportsWeb.StateController do
  use DownUnderSportsWeb, :controller

  alias DownUnderSports.Metas
  alias DownUnderSports.Metas.State

  def index(conn, _params) do
    states = Metas.list_states()
    render(conn, "index.html", states: states)
  end

  def new(conn, _params) do
    changeset = Metas.change_state(%State{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"state" => state_params}) do
    case Metas.create_state(state_params) do
      {:ok, state} ->
        conn
        |> put_flash(:info, "State created successfully.")
        |> redirect(to: Routes.state_path(conn, :show, state))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    state = Metas.get_state!(id)
    render(conn, "show.html", state: state)
  end

  def edit(conn, %{"id" => id}) do
    state = Metas.get_state!(id)
    changeset = Metas.change_state(state)
    render(conn, "edit.html", state: state, changeset: changeset)
  end

  def update(conn, %{"id" => id, "state" => state_params}) do
    state = Metas.get_state!(id)

    case Metas.update_state(state, state_params) do
      {:ok, state} ->
        conn
        |> put_flash(:info, "State updated successfully.")
        |> redirect(to: Routes.state_path(conn, :show, state))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", state: state, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    state = Metas.get_state!(id)
    {:ok, _state} = Metas.delete_state(state)

    conn
    |> put_flash(:info, "State deleted successfully.")
    |> redirect(to: Routes.state_path(conn, :index))
  end
end
