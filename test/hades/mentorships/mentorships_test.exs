defmodule Hades.MentorshipsTest do
  use Hades.DataCase

  import Hades.Factory

  alias Hades.Mentorships

  setup do
    user = insert(:user)
    mentoree = insert(:mentoree, user: user)
    mentor = insert(:mentor, user: user)
    {:ok, user: user, mentoree: mentoree, mentor: mentor}
  end

  describe "mentors" do
    alias Hades.Mentorships.Mentor

    @valid_attrs %{is_active: true, max_mentorships: 2, skill_areas: ["Backend"]}
    @update_attrs %{is_active: false, max_mentorships: 3, skill_areas: ["Backend", "DevOps"]}
    @invalid_attrs %{is_active: nil, max_mentorships: nil, skill_areas: []}
    @invalid_skill_areas_attrs %{is_active: false, max_mentorships: 3, skill_areas: ["Bad", "Skills"]}

    test "list_mentors/0 returns all mentors" do
      assert Mentorships.list_mentors() != []
    end

    test "get_mentor!/1 returns the mentor with given id", %{mentor: mentor} do
      assert Mentorships.get_mentor!(mentor.id).id == mentor.id
    end

    test "create_mentor/1 with valid data creates a mentor" do
      assert {:ok, %Mentor{} = mentor} = Mentorships.create_mentor(@valid_attrs)
      assert mentor.is_active == true
      assert mentor.max_mentorships == 2
      assert mentor.skill_areas == ["Backend"]
    end

    test "create_mentor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Mentorships.create_mentor(@invalid_attrs)
    end

    test "create_mentor/1 with invalid skill areas returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Mentorships.create_mentor(@invalid_skill_areas_attrs)
    end

    test "update_mentor/2 with valid data updates the mentor", %{mentor: mentor} do
      assert {:ok, mentor} = Mentorships.update_mentor(mentor, @update_attrs)
      assert %Mentor{} = mentor
      assert mentor.is_active == false
      assert mentor.max_mentorships == 3
      assert mentor.skill_areas == ["Backend", "DevOps"]
    end

    test "update_mentor/2 with invalid data returns error changeset", %{mentor: mentor} do
      assert {:error, %Ecto.Changeset{}} = Mentorships.update_mentor(mentor, @invalid_attrs)
      assert mentor.skill_areas == Mentorships.get_mentor!(mentor.id).skill_areas
    end
  end

  describe "mentorees" do
    alias Hades.Mentorships.Mentoree

    @valid_attrs %{is_active: true, is_minority: true}
    @update_attrs %{is_active: false, is_minority: false}
    @invalid_attrs %{is_active: nil, is_minority: nil}

    test "list_mentorees/0 returns all mentorees" do
      assert Mentorships.list_mentorees() != []
    end

    test "get_mentoree!/1 returns the mentoree with given id", %{mentoree: mentoree} do
      assert Mentorships.get_mentoree!(mentoree.id).is_minority == mentoree.is_minority
    end

    test "create_mentoree/1 with valid data creates a mentoree", %{user: user} do
      assert {:ok, %Mentoree{} = mentoree} = Mentorships.create_mentoree(Map.merge(@valid_attrs, %{user_id: user.id}))
      assert mentoree.is_active == true
      assert mentoree.is_minority == true
    end

    test "create_mentoree/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Mentorships.create_mentoree(@invalid_attrs)
    end

    test "update_mentoree/2 with valid data updates the mentoree", %{mentoree: mentoree} do
      assert {:ok, mentoree} = Mentorships.update_mentoree(mentoree, @update_attrs)
      assert %Mentoree{} = mentoree
      assert mentoree.is_active == false
      assert mentoree.is_minority == false
    end

    test "update_mentoree/2 with invalid data returns error changeset", %{mentoree: mentoree} do
      assert {:error, %Ecto.Changeset{}} = Mentorships.update_mentoree(mentoree, @invalid_attrs)
    end
  end

  describe "requests" do
    alias Hades.Mentorships.Request

    @valid_attrs %{
      status: 1,
      skill_area: 1,
      mentoree_level: 2
    }

    test "create_request/1 with valid data creates a request" do
      mentoree = insert(:mentoree)
      assert {:ok, %Request{} = request } = Mentorships.create_request(Map.merge(@valid_attrs, %{
        mentoree_id: mentoree.id}))
      assert Mentorships.request_status(request) == :active
      assert Mentorships.request_skill_area(request) == :backend
      assert Mentorships.request_mentoree_level(request) == :intermediate
    end
  end
end
