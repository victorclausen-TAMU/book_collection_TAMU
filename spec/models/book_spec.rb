require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validations' do
    let(:valid_date) { Date.new(2000, 1, 1) }

    it 'is valid with title, author, price, and published_date' do
      book = Book.new(
        title: 'Clean Code',
        author: 'Victor Clausen',
        price: 99.99,
        published_date: valid_date
      )
      expect(book).to be_valid
    end

    it "is invalid without a title" do
      book = Book.new(
        title: '',
        author: 'Victor Clausen',
        price: 1000000,
        published_date: valid_date
      )
      expect(book).not_to be_valid
      expect(book.errors[:title]).to include("can't be blank")
    end

    it "is invalid without an author" do
      book = Book.new(
        title: 'Has no author - test',
        author: '',
        price: 1,
        published_date: valid_date
      )
      expect(book).not_to be_valid
      expect(book.errors[:author]).to include("can't be blank")
    end

    it 'is invalid without a price' do
      book = Book.new(
        title: 'Has no price - test',
        author: 'Victor Clausen',
        price: nil,
        published_date: valid_date
      )
      expect(book).not_to be_valid
      expect(book.errors[:price]).to include("can't be blank")
    end

    it 'is invalid without a published_date' do
      book = Book.new(
        title: 'Has no date - Test',
        author: 'Victor Clausen',
        price: 999999,
        published_date: nil
      )
      expect(book).not_to be_valid
      expect(book.errors[:published_date]).to include("can't be blank")
    end
  end
end
