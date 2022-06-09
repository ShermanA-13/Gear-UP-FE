require "rails_helper"

describe "Item show page" do
  before do
    visit "/users/1/items/1"
  end

  it "displays the item's attributes (name, desc, categ)", :vcr do
    expect(page).to have_content("Name: Water Bottle")
    expect(page).to have_content("Count: 5")
    expect(page).to have_content("Item Category: Tents")

    expect(page).not_to have_content("Name: Trail Mix")
    expect(page).not_to have_content("Count: 8")
  end

  it "has a link to return to the user's item index", :vcr do
    click_link("Return to the Item Shed")

    expect(current_path).to eq("/users/1/items")
  end

end
describe "delete item" do
  before do
    visit "/login?user_id=1"
  end

  it "has a link to delete an item", :vcr do
    visit "/users/1/items"
    within '#item-2' do
      click_link 'View Item'
    end

    expect(page).to have_link("Delete Trail Mix")
  end

  it "does not have delete link on other users item pages", :vcr do
    visit "/users/2/items"
    within '#item-3' do
      click_link 'View Item'
    end

    expect(page).not_to have_link("Delete Good Socks")
  end

end
describe "error handling" do

  it "fails gracefully" do
    visit "users/0/items/1"
    expect(page).to have_content("No user with id 0")
    expect(page).to have_content("Status: NOT FOUND")
    expect(page).to have_content("Code: 404")
  end

  it "fails gracefully" do
    visit "users/1/items/0"
    expect(page).to have_content("No item with id 0")
    expect(page).to have_content("Status: NOT FOUND")
    expect(page).to have_content("Code: 404")
  end
end

describe "update item" do
  before do
    visit "/login?user_id=1"
    click_link("Trail Mix")

  end

  it "has a button taking you to the update page", :vcr do
    expect(page).to have_button("Edit Trail Mix")
  end
  it "the button takes you to the update page", :vcr do
    click_button "Edit Trail Mix"
    expect(current_path).to eq("/users/1/items/2/edit")
  end
end
