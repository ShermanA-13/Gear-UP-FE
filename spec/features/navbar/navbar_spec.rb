require 'rails_helper'

RSpec.describe 'navbar' do
  before do
    data = {
      first_name: 'Pickles',
      last_name: 'McTickles',
      email: 'dilllord@dills.org'
    }

    @user = UserFacade.create_user(data)
    visit "/login?user_id=#{@user.id}"
  end

  it 'logo links to user dashboard', :vcr do
    visit "/users/#{@user.id}/items"

    find('.navbar-brand').click
    expect(current_path).to eq('/dashboard')
  end

  it 'links to user shed', :vcr do
    within('.navbar-nav') do
      click_on 'MyShed'
    end
    expect(current_path).to eq("/users/#{@user.id}/items")
  end

  it 'links to user trips page', :vcr do
    within('.navbar-nav') do
      click_on 'MyTrips'
    end
    expect(current_path).to eq("/users/#{@user.id}/trips")
  end

  it 'logo links to rooth path when user is not logged in', :vcr do
    within('.navbar-nav') do
      click_on 'Logout'
    end
    find('.navbar-brand').click
    expect(current_path).to eq(root_path)
  end

  it 'displays only logo and Login links when user is not logged in', :vcr do
    within('.navbar-nav') do
      click_on 'Logout'
    end
    expect(page).not_to have_content('Logout')
    expect(page).not_to have_content('MyShed')
    expect(page).not_to have_content('MyTrips')

    expect(page).to have_content('Login')
  end
end