defmodule AmarisPhoenixLabWeb.MaterialLiveTest do
  use AmarisPhoenixLabWeb.ConnCase

  import Phoenix.LiveViewTest

  alias AmarisPhoenixLab.CMS

  @create_attrs %{name: "some name", source: "some source"}
  @update_attrs %{name: "some updated name", source: "some updated source"}
  @invalid_attrs %{name: nil, source: nil}

  defp fixture(:material) do
    {:ok, material} = CMS.create_material(@create_attrs)
    material
  end

  defp create_material(_) do
    material = fixture(:material)
    %{material: material}
  end

  describe "Index" do
    setup [:create_material]

    test "lists all materials", %{conn: conn, material: material} do
      {:ok, _index_live, html} = live(conn, Routes.material_index_path(conn, :index))

      assert html =~ "Listing Materials"
      assert html =~ material.name
    end

    test "saves new material", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.material_index_path(conn, :index))

      assert index_live |> element("a", "New Material") |> render_click() =~
               "New Material"

      assert_patch(index_live, Routes.material_index_path(conn, :new))

      assert index_live
             |> form("#material-form", material: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#material-form", material: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.material_index_path(conn, :index))

      assert html =~ "Material created successfully"
      assert html =~ "some name"
    end

    test "updates material in listing", %{conn: conn, material: material} do
      {:ok, index_live, _html} = live(conn, Routes.material_index_path(conn, :index))

      assert index_live |> element("#material-#{material.id} a", "Edit") |> render_click() =~
               "Edit Material"

      assert_patch(index_live, Routes.material_index_path(conn, :edit, material))

      assert index_live
             |> form("#material-form", material: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#material-form", material: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.material_index_path(conn, :index))

      assert html =~ "Material updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes material in listing", %{conn: conn, material: material} do
      {:ok, index_live, _html} = live(conn, Routes.material_index_path(conn, :index))

      assert index_live |> element("#material-#{material.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#material-#{material.id}")
    end
  end

  describe "Show" do
    setup [:create_material]

    test "displays material", %{conn: conn, material: material} do
      {:ok, _show_live, html} = live(conn, Routes.material_show_path(conn, :show, material))

      assert html =~ "Show Material"
      assert html =~ material.name
    end

    test "updates material within modal", %{conn: conn, material: material} do
      {:ok, show_live, _html} = live(conn, Routes.material_show_path(conn, :show, material))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Material"

      assert_patch(show_live, Routes.material_show_path(conn, :edit, material))

      assert show_live
             |> form("#material-form", material: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#material-form", material: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.material_show_path(conn, :show, material))

      assert html =~ "Material updated successfully"
      assert html =~ "some updated name"
    end
  end
end
