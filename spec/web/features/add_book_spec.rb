require 'features_helper'

describe 'Add a book' do 
    after do
        BookRepository.new.clear
    end

    it 'can create a new book' do
        visit '/books/new'

        within 'form#book-form' do
            fill_in 'Title', with: 'New Book'
            fill_in 'Author', with: 'Some Author'

            click_button 'Create'
        end 

        current_path.must_equal('/books')
        assert page.has_content?('New Book')
    end 
end 