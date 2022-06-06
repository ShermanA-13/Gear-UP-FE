require "rails_helper"

describe "Item index/shed" do
  before do
    # VCR.insert_cassette("displays_all_of_the_users_items")
    # json_response = File.read('spec/fixtures/items/user_items.json')
    # stub_request(:get, "https://gear-up-be.herokuapp.com/api/v1/users/1/items").
    #   to_return(status: 200, body: json_response)
    visit "/users/1/items"
  end

  after do
    # VCR.eject_cassette
  end

  it "displays all of the users items", :vcr do
    # save_and_open_page
    within "#item-1" do
      expect(page).to have_content("Water Bottle")
      expect(page).to have_content("Count: 5")
      expect(page).to have_content("Item ID: 1")
    end
    within "#item-2" do
      expect(page).to have_content("Trail Mix")
      expect(page).to have_content("Count: 8")
      expect(page).to have_content("Item ID: 2")
    end

    expect(page).not_to have_content("Good Socks")
    expect(page).not_to have_content("Count: 3")
    expect(page).not_to have_content("Item ID: 3")
  end

  it "each item links to the item's show page", :vcr do
    within "#item-1" do
      click_link("View Item")
    end

    expect(current_path).to eq("/users/1/items/1")
    expect(page).to have_content("Name: Water Bottle")
    expect(page).to have_content("Count: 5")

    expect(page).not_to have_content("Trail Mix")
    expect(page).not_to have_content("Count: 8")
  end
end

describe "create an item" do
  before do
    visit "/login?user_id=1"
    click_link("My Shed")
  end

  it "has a button to create a new item", :vcr do
    click_button("Add an item to your Shed")
    expect(current_path).to eq("/users/1/items/new")
  end

  it "does not show the button when visiting a different users page", :vcr do
    visit "/users/2/items"
    expect(page).not_to have_button("Add an item to your Shed")
  end
end
