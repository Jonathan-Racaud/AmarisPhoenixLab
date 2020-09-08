defmodule AmarisPhoenixLabWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers
  alias Phoenix.HTML.Form

  @doc """
  Renders a component inside the `AmarisPhoenixLabWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, AmarisPhoenixLabWeb.UserLive.FormComponent,
        id: @user.id || :new,
        action: @live_action,
        user: @user,
        return_to: Routes.user_index_path(@socket, :index) %>
  """
  def live_modal(socket, component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(socket, AmarisPhoenixLabWeb.ModalComponent, modal_opts)
  end

  def validated_text_input(form, field, opts \\ []) do
    name = Form.input_id(form, field) <> "-validation"
    newOpts = opts ++ [aria_describedby: name]
    Form.text_input(form, field, newOpts)
  end
end
