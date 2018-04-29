require 'spec_helper'

RSpec.describe Web::Controllers::Books::Create do
  let(:interactor) { instance_double('AddBook', call: nil) }
  let(:action) { Web::Controllers::Books::Create.new(interactor: interactor) }

  describe 'with valid params' do
    let(:params) { Hash[book: { title: '1984', author: 'George Orwell' }] }

    it 'calls interactor' do
      expect(interactor).to receive(:call)
      response = action.call(params)
    end

    it 'redirects the user to the books listing' do
      response = action.call(params)

      expect(response[0]).to eq(302)
      expect(response[1]['Location']).to eq('/books')
    end
  end

  describe 'with invalid params' do
    let(:params) { Hash[book: {}] }

    it 'calls interactor' do
      expect(interactor).to receive(:call)
      response = action.call(params)
    end

    it 're-renders the books#new view' do
      response = action.call(params)
      expect(response[0]).to eq(422)
    end

    it 'sets errors attribute accordingly' do
      response = action.call(params)

      expect(action.params.errors[:book][:title]).to eq(['is missing'])
      expect(action.params.errors[:book][:author]).to eq(['is missing'])
    end
  end
end