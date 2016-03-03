defmodule MacMe.LDAP.ConnectionTest do
  use ExUnit.Case, async: false
  alias MacMe.LDAP.Connection

  @random_name Faker.Internet.user_name
  @random_user_name 'test-user-#{@random_name}'
  @random_full_name 'Test User #{@random_name}'

  test "query data" do
    user = 'cn=test-user,ou=People,dc=example,dc=com'
    user_attributes = [
      {'objectClass', ['inetOrgPerson', 'organizationalPerson', 'person', 'top']},
      {'sn', ['Test User']},
      {'cn', ['test-user']}
    ]

    ldap_query = Connection.search(user)
    expected_query_result = [{:eldap_entry, user, user_attributes}]

    assert ldap_query == expected_query_result
  end

  # test "add a LDAP entry" do
  #   user = 'cn=#{@random_user_name},ou=People,dc=example,dc=com'
  #   user_attributes = [
  #     {'objectClass', ['inetOrgPerson', 'organizationalPerson', 'person', 'top']},
  #     {'sn', [@random_full_name]},
  #     {'cn', [@random_user_name]}
  #   ]

  #   :ok = Connection.add(user, user_attributes)

  #   search_filter = :eldap.equalityMatch('cn', @random_user_name)
  #   ldap_query = Connection.search(search_filter)
  #   expected_query_result = [{:eldap_entry, user, user_attributes}]

  #   assert ldap_query == expected_query_result
  # end

  # test "update a LDAP entry" do
  #   user = 'cn=#{@random_user_name},ou=People,dc=example,dc=com'
  #   new_full_name = '#{@random_full_name} -- update'
  #   changeset = [
  #     :eldap.mod_replace('sn', [new_full_name])
  #   ]

  #   update = :ok == Connection.update(user, changeset)

  #   search_filter = :eldap.equalityMatch('cn', @random_user_name)
  #   ldap_query = Connection.search(search_filter)
  #   user_attributes = [
  #     {'objectClass', ['inetOrgPerson', 'organizationalPerson', 'person', 'top']},
  #     {'cn', [@random_user_name]},
  #     {'sn', [new_full_name]}
  #   ]
  #   expected_query_result = [{:eldap_entry, user, user_attributes}]

  #   assert ldap_query == expected_query_result
  # end

  # test "delete a user account" do
  #   user = 'cn=#{@random_user_name},ou=People,dc=example,dc=com'

  #   :ok = Connection.delete(user)

  #   search_filter = :eldap.equalityMatch('cn', @random_user_name)
  #   ldap_query = Connection.search(search_filter)
  #   expected_query_result = []

  #   assert ldap_query == expected_query_result
  # end
end
