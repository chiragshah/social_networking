require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request do

  path '/api/v1/users/sign_up' do

    post('sign_up user') do
      tags 'SignUp'
      consumes "application/json"
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          first_name: { type: :string },
          last_name: { type: :string },
          username: { type: :string },
          email: { type: :string },
          password: { type: :string },
          description: { type: :string }
        },
        required: [ 'username', 'email', 'password' ]
      }

      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/search' do

    get('Search users and posts') do
      tags 'Search'
      consumes "application/json"
      security [Bearer: {}]

      parameter name: :term, in: :query, schema: {
        type: :string
      }

      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}/share' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('share user') do
      tags 'Users'
      consumes "application/json"
      
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}/follow' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    post('follow user') do
      tags 'Users'
      consumes "application/json"
      security [Bearer: {}]
      
      response(200, 'successful') do
        let(:id) { '123' }
        let(:"Authorization") { "Bearer #{token_for(user)}" }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}/unfollow' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    post('unfollow user') do
      tags 'Users'
      consumes "application/json"
      security [Bearer: {}]

      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/users/followees' do

    get('followees user') do
      tags 'Users'
      consumes "application/json"
      security [Bearer: {}]

      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/users/followers' do

    get('followers user') do
      tags 'Users'
      consumes "application/json"
      security [Bearer: {}]

      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    put('update user') do
      tags 'Users'
      consumes "application/json"
      security [Bearer: {}]

      consumes "application/json"
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          first_name: { type: :string },
          last_name: { type: :string },
          username: { type: :string },
          email: { type: :string },
          password: { type: :string },
          description: { type: :string },
          is_public: { type: :boolean }
        }
      }

      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
