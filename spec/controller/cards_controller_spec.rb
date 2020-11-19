require 'rails_helper'
require 'spec_helper'

describe V1::HandChecking do
  # include Constants
  # include Rack::Test::Methods
  #
  # def app
  #   V1::HandChecking
  # end
  #
  # context 'GET /api/statuses/public_timeline' do
  #   it 'returns an empty array of statuses' do
  #     get '/api/statuses/public_timeline'
  #     expect(response.status).to eq(200)
  #     expect(JSON.parse(response.body)).to eq []
  #   end
  # end
  #
  # describe 'ok' do
  #   describe "ROYAL_FLUSH hand", :type => :request do
  #     before do
  #       post '/api/v1/hand_checkings', params: { "cards": [
  #         "H1 H13 H12 H11 H10"
  #       ] }.to_json
  #     end
  #
  #     it 'returns ROYAL_FLUSH' do
  #       expect(response).to have_http_status(:success)
  #       expect(JSON.parse(response.body)['result'][0]['rank']).to eq($handTypes[$handTypes_royal_flush])
  #       expect(JSON.parse(response.body)['result'][0]['best']).to be_truthy
  #       expect(JSON.parse(response.body)['result'][0]['hand']).to eq("H1 H13 H12 H11 H10")
  #     end
  #   end
  #
  #   describe "STRAIGHT_FLUSH hand", :type => :request do
  #     before do
  #       post '/api/v1/hand_checkings', params: { "cards": [
  #         "H1 H2 H3 H4 H5"
  #       ] }.to_json
  #     end
  #
  #     it 'returns STRAIGHT_FLUSH' do
  #       expect(response).to have_http_status(:success)
  #       expect(JSON.parse(response.body)['result'][0]['rank']).to eq($handTypes[$handTypes_straight_flush])
  #       expect(JSON.parse(response.body)['result'][0]['best']).to be_truthy
  #       expect(JSON.parse(response.body)['result'][0]['hand']).to eq("H1 H2 H3 H4 H5")
  #     end
  #   end
  #
  #   describe "FOUR_OF_A_KIND hand", :type => :request do
  #     before do
  #       post '/api/v1/hand_checkings', params: { "cards": [
  #         "H1 H7 D7 C7 S7"
  #       ] }.to_json
  #     end
  #
  #     it 'returns FOUR_OF_A_KIND' do
  #       expect(response).to have_http_status(:success)
  #       expect(JSON.parse(response.body)['result'][0]['rank']).to eq($handTypes[$handTypes_4_of_a_kind])
  #       expect(JSON.parse(response.body)['result'][0]['best']).to be_truthy
  #       expect(JSON.parse(response.body)['result'][0]['hand']).to eq("H1 H7 D7 C7 S7")
  #     end
  #   end
  #
  #   describe "ROYAL_FLUSH hand", :type => :request do
  #     before do
  #       post '/api/v1/hand_checkings', params: { "cards": [
  #         "H1 H13 H12 H11 H10"
  #       ] }.to_json
  #     end
  #
  #     it 'returns ROYAL_FLUSH' do
  #       expect(response).to have_http_status(:success)
  #       expect(JSON.parse(response.body)['result'][0]['rank']).to eq($handTypes[$handTypes_royal_flush])
  #       expect(JSON.parse(response.body)['result'][0]['best']).to be_truthy
  #       expect(JSON.parse(response.body)['result'][0]['hand']).to eq("H1 H13 H12 H11 H10")
  #     end
  #   end
  #
  #   describe "STRAIGHT_FLUSH hand", :type => :request do
  #     before do
  #       post '/api/v1/hand_checkings', params: { "cards": [
  #         "H1 H2 H3 H4 H5"
  #       ] }.to_json
  #     end
  #
  #     it 'returns STRAIGHT_FLUSH' do
  #       expect(response).to have_http_status(:success)
  #       expect(JSON.parse(response.body)['result'][0]['rank']).to eq($handTypes[$handTypes_straight_flush])
  #       expect(JSON.parse(response.body)['result'][0]['best']).to be_truthy
  #       expect(JSON.parse(response.body)['result'][0]['hand']).to eq("H1 H2 H3 H4 H5")
  #     end
  #   end
  #
  #   describe "FOUR_OF_A_KIND hand", :type => :request do
  #     before do
  #       post '/api/v1/hand_checkings', params: { "cards": [
  #         "H1 H7 D7 C7 S7"
  #       ] }.to_json
  #     end
  #
  #     it 'returns FOUR_OF_A_KIND' do
  #       expect(response).to have_http_status(:success)
  #       expect(JSON.parse(response.body)['result'][0]['rank']).to eq($handTypes[$handTypes_4_of_a_kind])
  #       expect(JSON.parse(response.body)['result'][0]['best']).to be_truthy
  #       expect(JSON.parse(response.body)['result'][0]['hand']).to eq("H1 H7 D7 C7 S7")
  #     end
  #   end
  #
  #   describe "FULL_HOUSE hand", :type => :request do
  #     before do
  #       post '/api/v1/hand_checkings', params: { "cards": [
  #         "H1 S1 D1 H5 D5"
  #       ] }.to_json
  #     end
  #
  #     it 'returns FULL_HOUSE' do
  #       expect(response).to have_http_status(:success)
  #       expect(JSON.parse(response.body)['result'][0]['rank']).to eq($handTypes[$handTypes_full_house])
  #       expect(JSON.parse(response.body)['result'][0]['best']).to be_truthy
  #       expect(JSON.parse(response.body)['result'][0]['hand']).to eq("H1 S1 D1 H5 D5")
  #     end
  #   end
  #
  #   describe "FLUSH hand", :type => :request do
  #     before do
  #       post '/api/v1/hand_checkings', params: { "cards": [
  #         "H1 H13 H5 H6 H10"
  #       ] }.to_json
  #     end
  #
  #     it 'returns FLUSH' do
  #       expect(response).to have_http_status(:success)
  #       expect(JSON.parse(response.body)['result'][0]['rank']).to eq($handTypes[$handTypes_flush])
  #       expect(JSON.parse(response.body)['result'][0]['best']).to be_truthy
  #       expect(JSON.parse(response.body)['result'][0]['hand']).to eq("H1 H13 H5 H6 H10")
  #     end
  #   end
  #
  #   describe "STRAIGHT hand", :type => :request do
  #     before do
  #       post '/api/v1/hand_checkings', params: { "cards": [
  #         "H1 C2 D3 H4 H5"
  #       ] }.to_json
  #     end
  #
  #     it 'returns STRAIGHT' do
  #       expect(response).to have_http_status(:success)
  #       expect(JSON.parse(response.body)['result'][0]['rank']).to eq($handTypes[$handTypes_straight])
  #       expect(JSON.parse(response.body)['result'][0]['best']).to be_truthy
  #       expect(JSON.parse(response.body)['result'][0]['hand']).to eq("H1 C2 D3 H4 H5")
  #     end
  #   end
  #
  #   describe "THREE_OF_A_KIND hand", :type => :request do
  #     before do
  #       post '/api/v1/hand_checkings', params: { "cards": [
  #         "H1 D1 C1 H11 D10"
  #       ] }.to_json
  #     end
  #
  #     it 'returns THREE_OF_A_KIND' do
  #       expect(response).to have_http_status(:success)
  #       expect(JSON.parse(response.body)['result'][0]['rank']).to eq($handTypes[$handTypes_3_of_a_kind])
  #       expect(JSON.parse(response.body)['result'][0]['best']).to be_truthy
  #       expect(JSON.parse(response.body)['result'][0]['hand']).to eq("H1 D1 C1 H11 D10")
  #     end
  #   end
  #
  #   describe "TWO_PAIRS hand", :type => :request do
  #     before do
  #       post '/api/v1/hand_checkings', params: { "cards": [
  #         "H1 D1 H12 D12 C5"
  #       ] }.to_json
  #     end
  #
  #     it 'returns TWO_PAIRS' do
  #       expect(response).to have_http_status(:success)
  #       expect(JSON.parse(response.body)['result'][0]['rank']).to eq($handTypes[$handTypes_2_pairs])
  #       expect(JSON.parse(response.body)['result'][0]['best']).to be_truthy
  #       expect(JSON.parse(response.body)['result'][0]['hand']).to eq("H1 D1 H12 D12 C5")
  #     end
  #
  #     describe "check multiple hands", :type => :request do
  #       before do
  #         post '/api/v1/hand_checkings', params: { "cards": [
  #           "H1 H13 H12 H11 H10",
  #           "H1 H2 H3 H4 H5",
  #           "H1 H7 D7 C7 S7",
  #           "H1 S1 D1 H5 D5",
  #           "H1 H13 H5 H6 H10",
  #           "H1 C2 D3 H4 H5",
  #           "H1 D1 C1 H11 D10",
  #           "H1 D1 H12 D12 C5",
  #           "H1 D1 H5 S11 H10",
  #           "H1 D13 C4 S8 H10"
  #         ] }.to_json
  #       end
  #
  #       it 'return multiple hands' do
  #         expect(response).to have_http_status(:success)
  #         expect(JSON.parse(response.body)['result'][0]['best']).to be_truthy
  #         expect(JSON.parse(response.body)['result'].size).to eq(10)
  #         expect(JSON.parse(response.body)['result'][0]['rank']).to eq($handTypes[$handTypes_royal_flush])
  #         expect(JSON.parse(response.body)['result'][1]['rank']).to eq($handTypes[$handTypes_straight_flush])
  #         expect(JSON.parse(response.body)['result'][2]['rank']).to eq($handTypes[$handTypes_4_of_a_kind])
  #         expect(JSON.parse(response.body)['result'][3]['rank']).to eq($handTypes[$handTypes_full_house])
  #         expect(JSON.parse(response.body)['result'][4]['rank']).to eq($handTypes[$handTypes_flush])
  #         expect(JSON.parse(response.body)['result'][5]['rank']).to eq($handTypes[$handTypes_straight])
  #         expect(JSON.parse(response.body)['result'][6]['rank']).to eq($handTypes[$handTypes_3_of_a_kind])
  #         expect(JSON.parse(response.body)['result'][7]['rank']).to eq($handTypes[$handTypes_2_pairs])
  #         expect(JSON.parse(response.body)['result'][8]['rank']).to eq($handTypes[$handTypes_1_pair])
  #         expect(JSON.parse(response.body)['result'][9]['rank']).to eq($handTypes[$handTypes_high_card])
  #       end
  #     end
  #
  #   end
  #
  #   describe "ONE_PAIR hand", :type => :request do
  #     before do
  #       post '/api/v1/hand_checkings', params: { "cards": [
  #         "H1 D1 H5 S11 H10"
  #       ] }.to_json
  #     end
  #
  #     it 'returns ONE_PAIR' do
  #       expect(response).to have_http_status(:success)
  #       expect(JSON.parse(response.body)['result'][0]['rank']).to eq($handTypes[$handTypes_1_pair])
  #       expect(JSON.parse(response.body)['result'][0]['best']).to be_truthy
  #       expect(JSON.parse(response.body)['result'][0]['hand']).to eq("H1 D1 H5 S11 H10")
  #     end
  #   end
  #
  #   describe "HIGH_CARD hand", :type => :request do
  #     before do
  #       post '/api/v1/hand_checkings', params: { "cards": [
  #         "H1 D13 C4 S8 H10"
  #       ] }.to_json
  #     end
  #
  #     it 'returns HIGH_CARD' do
  #       expect(response).to have_http_status(:success)
  #       expect(JSON.parse(response.body)['result'][0]['rank']).to eq($handTypes[$handTypes_high_card])
  #       expect(JSON.parse(response.body)['result'][0]['best']).to be_truthy
  #       expect(JSON.parse(response.body)['result'][0]['hand']).to eq("H1 D13 C4 S8 H10")
  #     end
  #   end
  #
  # end
  #
  # describe 'exception' do
  #
  #   describe "invalid format input", :type => :request do
  #     before do
  #       post '/api/v1/hand_checkings', params: { "cards": [
  #         "H1 H13 Y12 H15 H16"
  #       ] }.to_json
  #     end
  #
  #     it 'invalid format' do
  #       expect(response).to have_http_status(:success)
  #       expect(JSON.parse(response.body)['error'][0]['error'].size).to eq(3)
  #       expect(JSON.parse(response.body)['error'][0]['error'][0]["name"]).to eq('Y12')
  #       expect(JSON.parse(response.body)['error'][0]['error'][1]["name"]).to eq('H15')
  #       expect(JSON.parse(response.body)['error'][0]['error'][2]["name"]).to eq('H16')
  #     end
  #   end
  #
  #   describe "request to check empty hand", :type => :request do
  #     before do
  #       post '/api/v1/hand_checkings', params: { "cards": [
  #         ""
  #       ] }.to_json
  #     end
  #
  #     it 'empty hand' do
  #       expect(response).to have_http_status(:success)
  #       expect(JSON.parse(response.body)['error'][0]['error'][0]["message"]).to eq('５枚のカードが必要です。')
  #     end
  #   end
  #
  #   describe "uncompleted hand", :type => :request do
  #     before do
  #       post '/api/v1/hand_checkings', params: { "cards": [
  #         "H1 H2 H3"
  #       ] }.to_json
  #     end
  #
  #     it 'error: uncompleted hand' do
  #       expect(response).to have_http_status(:success)
  #       expect(JSON.parse(response.body)['error'][0]['error'][0]["message"]).to eq('５枚のカードが必要です。')
  #     end
  #   end
  #
  #   describe "over 5 cards in a hand", :type => :request do
  #     before do
  #       post '/api/v1/hand_checkings', params: { "cards": [
  #         "H1 H2 H3 H5 H6 H7"
  #       ] }.to_json
  #     end
  #
  #     it 'over 5 cards' do
  #       expect(response).to have_http_status(:success)
  #       expect(JSON.parse(response.body)['error'][0]['error'][0]["message"]).to eq('５枚のカードが必要です。')
  #     end
  #   end
  #
  #   describe "hand with duplicated cards", :type => :request do
  #     before do
  #       post '/api/v1/hand_checkings', params: { "cards": [
  #         "H1 H2 H3 H3 H3"
  #       ] }.to_json
  #     end
  #
  #     it 'duplicated cards' do
  #       expect(response).to have_http_status(:success)
  #       expect(JSON.parse(response.body)['error'][0]['error'][0]["message"]).to include('重複')
  #       expect(JSON.parse(response.body)['error'][0]['error'][1]["message"]).to include('重複')
  #       expect(JSON.parse(response.body)['error'][0]['error'][2]["message"]).to include('重複')
  #     end
  #   end
  #
  #   describe "check multiple hands with an invalid hand", :type => :request do
  #     before do
  #       post '/api/v1/hand_checkings', params: { "cards": [
  #         "H1 H13 H12 H11 H10",
  #         "H1 H2 H3 H4 H5",
  #         "H1 H7 D7 C7 S7",
  #         "H1 S1 D1 H5 D5",
  #         "H1 H13 H5 H6 H10",
  #         "H1 C2 D3 H4 H5",
  #         "H1 D1 C1 H11 D10",
  #         "H1 D1 H12 D12 C5",
  #         "H1 D1 H5 S11 H10",
  #         "H1 D13 C4 S8 H10",
  #         "H1 D13 C4 S8 H100"
  #       ] }.to_json
  #     end
  #
  #     it 'return multiple hands' do
  #       expect(response).to have_http_status(:success)
  #       expect(JSON.parse(response.body)['result'][0]['best']).to be_truthy
  #       expect(JSON.parse(response.body)['result'].size).to eq(10)
  #       expect(JSON.parse(response.body)['result'][0]['rank']).to eq($handTypes[$handTypes_royal_flush])
  #       expect(JSON.parse(response.body)['result'][1]['rank']).to eq($handTypes[$handTypes_straight_flush])
  #       expect(JSON.parse(response.body)['result'][2]['rank']).to eq($handTypes[$handTypes_4_of_a_kind])
  #       expect(JSON.parse(response.body)['result'][3]['rank']).to eq($handTypes[$handTypes_full_house])
  #       expect(JSON.parse(response.body)['result'][4]['rank']).to eq($handTypes[$handTypes_flush])
  #       expect(JSON.parse(response.body)['result'][5]['rank']).to eq($handTypes[$handTypes_straight])
  #       expect(JSON.parse(response.body)['result'][6]['rank']).to eq($handTypes[$handTypes_3_of_a_kind])
  #       expect(JSON.parse(response.body)['result'][7]['rank']).to eq($handTypes[$handTypes_2_pairs])
  #       expect(JSON.parse(response.body)['result'][8]['rank']).to eq($handTypes[$handTypes_1_pair])
  #       expect(JSON.parse(response.body)['result'][9]['rank']).to eq($handTypes[$handTypes_high_card])
  #
  #       expect(JSON.parse(response.body)['error'][0]['error'].size).to eq(1)
  #       expect(JSON.parse(response.body)['error'][0]['error'][0]["name"]).to eq('H100')
  #     end
  #   end
  # end

end
