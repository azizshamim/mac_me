defmodule HelperTest do
  use ExUnit.Case, async: false
  alias MacMe.LDAP.Helper

  @fake_ou Faker.Internet.domain_word
  @fake_dn "ou=#{@fake_ou},dc=example,dc=com"
  @group_ou "ou=Groups,dc=example,dc=com"

  # test "create a new ou" do
  #   :ok == Helper.add(@fake_dn)

  #   assert Helper.exists?(@fake_dn) == true
  # end

  test "extract a base_dn from a dn" do
    base_dn = @fake_dn |> Helper.base_dn

    assert base_dn == "ou=#{@fake_ou}"
  end

  test "extract a basename from a dn" do
    basename = @fake_dn |> Helper.basename

    assert basename == @fake_ou
  end

  test "extract a type from a dn" do
    type = @fake_dn |> Helper.basename(:type)
    assert type == "ou"
  end

  test "properly detects an object that exists in the db" do
    assert Helper.exists?(@group_ou)
  end

  # test "properly detects the absence of an object" do
  #   dn = "dc=doesnotexist,dc=example,dc=com"
  #   refute Helper.exists?(dn)
  # end
end
