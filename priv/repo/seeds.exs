# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     AmarisPhoenixLab.Repo.insert!(%AmarisPhoenixLab.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias AmarisPhoenixLab.CMS
alias AmarisPhoenixLab.Users

Users.create_role(%{
  name: "Admin"
})

Users.create_role(%{
  name: "Regular"
})

CMS.create_category(%{
  name: "Web"
})

CMS.create_category(%{
  name: "Mobile"
})

CMS.create_category(%{
  name: "Desktop"
})

CMS.create_category(%{
  name: "Techno study"
})

CMS.create_category(%{
  name: "Market study"
})

CMS.create_material_type(%{
  name: "Document"
})

CMS.create_material_type(%{
  name: "Image"
})

CMS.create_material_type(%{
  name: "Video"
})

CMS.create_material_type(%{
  name: "Url"
})
