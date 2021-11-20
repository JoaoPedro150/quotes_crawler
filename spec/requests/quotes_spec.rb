require 'swagger_helper'

RSpec.describe 'quotes', type: :request do

  path '/quotes' do

    get('List cached quotes') do
      tags 'Quotes'
      security [ jwt: [] ]
    
      produces 'application/json'
      
      response(200, 'Successful') do
        schema type: :object,
          properties: {
            quotes: { 
              type: :array,
              items: {
                type: :object,
                properties: {
                  author: { type: :string },
                  author_about: { type: :string },
                  quote: { type: :string },
                  tags: { 
                    type: :array,
                    items: {
                      type: :string
                    }
                  }
                }
              }
            }
          }
        run_test!
      end
    end

    delete('Delete cached quotes') do
      tags 'Quotes'
      security [ jwt: [] ]
      
      response(204, 'Successful') do
        run_test!
      end
    end
  end

  path '/quotes/{tag}' do
    parameter name: 'tag', in: :path, type: :string

    get('Search quotes by tag') do
      tags 'Quotes'
      security [ jwt: [] ]

      produces 'application/json'
      
      response(200, 'Successful') do
        schema type: :object,
          properties: {
            quotes: { 
              type: :array,
              items: {
                type: :object,
                properties: {
                  author: { type: :string },
                  author_about: { type: :string },
                  quote: { type: :string },
                  tags: { 
                    type: :array,
                    items: {
                      type: :string
                    }
                  }
                }
              }
            }
          }
        run_test!
      end
    end
  end
end
