defmodule ElixirApi.DataTest do
  use ElixirApi.DataCase

  alias ElixirApi.Data

  describe "users" do
    alias ElixirApi.Data.User

    @valid_attrs %{name: "some name", email: "some email", dob: ~D[2010-04-17]}
    @update_attrs %{name: "some updated name", email: "some updated email", dob: ~D[2011-05-18]}
    @invalid_attrs %{name: nil, email: nil, dob: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Data.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Data.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Data.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Data.create_user(@valid_attrs)
      assert user.name == "some name"
      assert user.email == "some email"
      assert user.dob == ~D[2010-04-17]
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Data.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Data.update_user(user, @update_attrs)
      assert user.name == "some updated name"
      assert user.email == "some updated email"
      assert user.dob == ~D[2011-05-18]
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Data.update_user(user, @invalid_attrs)
      assert user == Data.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Data.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Data.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Data.change_user(user)
    end
  end
end
