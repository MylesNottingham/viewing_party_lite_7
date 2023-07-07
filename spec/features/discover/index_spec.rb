require "rails_helper"

RSpec.describe "user's discover page", type: :feature do
  before(:each) do
    @user1 = User.create!(name: "John", email: "john@example.com")
    @user2 = User.create!(name: "Myles", email: "myles@example.com")
    @user3 = User.create!(name: "Boston", email: "boston@example.com")
  end

  describe "when I visit a user's discover page" do
    context "User 1" do
      before(:each) do
        visit user_discover_index_path(@user1.id)
      end

      it "displays a link to the home page, 'Viewing Party', and 'Discover Movies' at the top of the page" do
        expect(page).to have_link("Home")
        expect(page).to have_content("Viewing Party")
        within("#title") do
          expect(page).to have_content("Discover Movies")
        end
      end

      it "displays a button to 'Discover Top Rated Movies' that links to user_movies_path" do
        expect(page).to have_button("Discover Top Rated Movies")

        click_button("Discover Top Rated Movies")

        expect(current_path).to eq(user_movies_path(@user1.id))
      end

      it "displays a search field to 'Find Movies' that links to user_movies_path" do
        within("#movie-search") do
          expect(page).to have_field("Movie Title:")
          expect(page).to have_button("Find Movies")

          fill_in "Movie Title:", with: "The Matrix"
          click_button("Find Movies")

          expect(current_path).to eq(user_movies_path(@user1.id))
        end
      end
    end
  end
end
