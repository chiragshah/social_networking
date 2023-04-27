require 'swagger_helper'

RSpec.describe 'api/v1/comments', type: :request do

  path '/api/v1/posts/{post_id}/comments' do
    # You'll want to customize the parameter types...
    parameter name: 'post_id', in: :path, type: :string, description: 'post_id'

    get('list comments') do
      tags 'Comments'
      security [Bearer: {}]

      response(200, 'successful') do
        let(:post_id) { '123' }

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

    post('create comment & reply') do
      tags 'Comments'
      consumes "application/json"
      security [Bearer: {}]

      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          body: { type: :string },
          parent_id: { type: :integer, description: "Add comment id for reply" }
        }
      }

      response(200, 'successful') do
        let(:post_id) { '123' }

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

  path '/api/v1/posts/{post_id}/comments/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'post_id', in: :path, type: :string, description: 'post_id'
    parameter name: 'id', in: :path, type: :string, description: 'id'

    patch('update comment') do
      tags 'Comments'
      security [Bearer: {}]

      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          body: { type: :string },
          parent_id: { type: :integer, description: "Add comment id for reply" }
        }
      }

      response(200, 'successful') do
        let(:post_id) { '123' }
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

    put('update comment') do
      tags 'Comments'
      security [Bearer: {}]

      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          body: { type: :string },
          parent_id: { type: :integer, description: "Add comment id for reply" }
        }
      }

      response(200, 'successful') do
        let(:post_id) { '123' }
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

    delete('delete comment') do
      tags 'Comments'
      security [Bearer: {}]

      response(200, 'successful') do
        let(:post_id) { '123' }
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
