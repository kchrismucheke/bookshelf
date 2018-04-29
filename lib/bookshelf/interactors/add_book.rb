require 'hanami/interactor'

class AddBook
    include Hanami::Interactor

    expose :book

    def initialize(repository: BookRepository.new)
        @repository = repository
        #set up the object
    end

    def call
        @book = BookRepository.new.create(book_attributes)
    end
end