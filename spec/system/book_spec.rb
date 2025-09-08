require 'rails_helper'

RSpec.describe 'Books', type: :system do
  def pick_date(year, month_name, day)
    select year.to_s,  from: 'book_published_date_1i'
    select month_name, from: 'book_published_date_2i'
    select day.to_s,   from: 'book_published_date_3i'
  end

  it 'creates a book successfully (sunny day)' do
    visit new_book_path

    fill_in 'Title',  with: 'Title of the test book, Harry Potter'
    fill_in 'Author', with: 'J.K Rowling'
    fill_in 'Price',  with: '13'
    pick_date 2002, 'August', 11

    expect { click_button 'Create Book' }.to change(Book, :count).by(1)
    expect(page).to have_text('Book was successfully created.')
    expect(Book.where(title: 'Title of the test book, Harry Potter', author: 'J.K Rowling', price: 13)).to exist
  end

  it 'fails to create a book with blank title (rainy day)' do
    visit new_book_path

    fill_in 'Title',  with: ''
    fill_in 'Author', with: 'J.K Rowling'
    fill_in 'Price',  with: '13'
    pick_date 2002, 'August', 11

    expect { click_button 'Create Book' }.not_to change(Book, :count)
    expect(page).to have_text("Title can't be blank")
  end
  it 'fails to create a book with blank author (rainy day)' do
    visit new_book_path

    fill_in 'Title',  with: 'Missing author tst'
    fill_in 'Author', with: ''
    fill_in 'Price',  with: '13'
    pick_date 2002, 'August', 11

    expect { click_button 'Create Book' }.not_to change(Book, :count)
    expect(page).to have_text("Author can't be blank")
  end

  it 'creates a book with a price (sunny day)' do
    visit new_book_path

    fill_in 'Title',  with: 'has Price- test'
    fill_in 'Author', with: 'Some Author'
    fill_in 'Price',  with: '13'
    pick_date 2002, 'August', 11

    expect { click_button 'Create Book' }.to change(Book, :count).by(1)
    expect(page).to have_text('Book was successfully created.')
    expect(Book.where(title: 'has Price- test', price: 13)).to exist
  end
  it 'does not create a book when price is blank (rainy day)' do
    visit new_book_path

    fill_in 'Title',  with: 'Missing Price test'
    fill_in 'Author', with: 'Some Author'
    fill_in 'Price',  with: ''
    pick_date 2002, 'August', 11

    expect { click_button 'Create Book' }.not_to change(Book, :count)
    expect(page).to have_text("Price can't be blank")
  end

  it 'creates a book with a published date (sunny day)' do
    visit new_book_path

    fill_in 'Title',  with: 'Has Date - test'
    fill_in 'Author', with: 'Some Author'
    fill_in 'Price',  with: '12.50'
    pick_date 2002, 'August', 11

    expect { click_button 'Create Book' }.to change(Book, :count).by(1)
    expect(page).to have_text('Book was successfully created.')
  end
  it 'does not create a book when published date is missing (rainy day)' do
    visit new_book_path

    fill_in 'Title',  with: 'Missing Date'
    fill_in 'Author', with: 'Some Author'
    fill_in 'Price',  with: '12.50'

    expect { click_button 'Create Book' }.not_to change(Book, :count)
    expect(page).to have_text("Published date can't be blank")
  end
end
