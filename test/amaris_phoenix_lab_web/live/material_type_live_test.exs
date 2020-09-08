defmodule AmarisPhoenixLabWeb.MaterialTypeLiveTest do
  use AmarisPhoenixLabWeb.ConnCase

  import Phoenix.LiveViewTest

  alias AmarisPhoenixLab.CMS

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp fixture(:material_type) do
    {:ok, material_type} = CMS.create_material_type(@create_attrs)
    material_type
  end

  defp create_material_type(_) do
    material_type = fixture(:material_type)
    %{material_type: material_type}
  end

  describe "Index" do
    setup [:create_material_type]

    test "lists all material_types", %{conn: conn, material_type: material_type} do
      {:ok, _index_live, html} = live(conn, Routes.material_type_index_path(conn, :index))

      assert html =~ "Listing Material types"
      assert html =~ material_type.name
    end

    test "saves new material_type", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.material_type_index_path(conn, :index))

      assert index_live |> element("a", "New Material type") |> render_click() =~
               "New Material type"

      assert_patch(index_live, Routes.material_type_index_path(conn, :new))

      assert index_live
             |> form("#material_type-form", material_type: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#material_type-form", material_type: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.material_type_index_path(conn, :index))

      assert html =~ "Material type created successfully"
      assert html =~ "some name"
    end

    test "updates material_type in listing", %{conn: conn, material_type: material_type} do
      {:ok, index_live, _html} = live(conn, Routes.material_type_index_path(conn, :index))

      assert index_live |> element("#material_type-#{material_type.id} a", "Edit") |> render_click() =~
               "Edit Material type"

      assert_patch(index_live, Routes.material_type_index_path(conn, :edit, material_type))

      assert index_live
             |> form("#material_type-form", material_type: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#material_type-form", material_type: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.material_type_index_path(conn, :index))

      assert html =~ "Material type updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes material_type in listing", %{conn: conn, material_type: material_type} do
      {:ok, index_live, _html} = live(conn, Routes.material_type_index_path(conn, :index))

      assert index_live |> element("#material_type-#{material_type.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#material_type-#{material_type.id}")
    end
  end

  describe "Show" do
    setup [:create_material_type]

    test "displays material_type", %{conn: conn, material_type: material_type} do
      {:ok, _show_live, html} = live(conn, Routes.material_type_show_path(conn, :show, material_type))

      assert html =~ "Show Material type"
      assert html =~ material_type.name
    end

    test "updates material_type within modal", %{conn: conn, material_type: material_type} do
      {:ok, show_live, _html} = live(conn, Routes.material_type_show_path(conn, :show, material_type))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Material type"

      assert_patch(show_live, Routes.material_type_show_path(conn, :edit, material_type))

      assert show_live
             |> form("#material_type-form", material_type: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#material_type-form", material_type: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.material_type_show_path(conn, :show, material_type))

      assert html =~ "Material type updated successfully"
      assert html =~ "some updated name"
    end
  end
end
