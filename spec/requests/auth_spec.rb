require 'swagger_helper'

RSpec.describe 'auth', type: :request do

  path '/auth/sign-in' do
    post('Sign-in') do
      tags 'Auth'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string },
          password: { type: :string }
        },
        required: [ 'username', 'password' ]
      }

      response(200, 'Successful') do
        schema type: :object,
          properties: {
            authorization: { type: :string }
          }
        run_test!
      end
      response(401, 'Wrong username or password') do
        run_test!
      end
    end
  end

  path '/auth/sign-up' do
    post('Sign-up') do
      tags 'Auth'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string },
          password: { type: :string }
        },
        required: [ 'username', 'password' ]
      }
      
      response(200, 'Successful') do
        schema type: :object,
          properties: {
            authorization: { type: :string }
          }
        run_test!
      end
      response(400, 'Bad request') do
        schema type: :object,
          properties: {
            errors: { 
              type: :array,
              items: {
                type: :string 
              }
            }
          }
        run_test!
      end
    end
  end
end
