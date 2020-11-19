require 'rails_helper'
require 'spec_helper'

describe V1::HandChecking, :type => :request do
  include Constants
  include Rack::Test::Methods

  context 'POST /api/v1/hand_checkings' do
    describe "ok" do
      it 'return ROYAL_FLUSH hand' do
        body = { "cards": [
          "H1 H13 H12 H11 H10"
        ] }
        post '/api/v1/hand_checkings', body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(JSON.parse(last_response.body)["result"][0]["rank"]).to eq $handTypes[$handTypes_royal_flush]
      end

      it 'return STRAIGHT_FLUSH hand' do
        body = { "cards": [
          "H1 H2 H3 H4 H5"
        ] }
        post '/api/v1/hand_checkings', body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(JSON.parse(last_response.body)["result"][0]["rank"]).to eq $handTypes[$handTypes_straight_flush]
      end

      it 'return FOUR_OF_A_KIND hand' do
        body = { "cards": [
          "H1 H7 D7 C7 S7"
        ] }
        post '/api/v1/hand_checkings', body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(JSON.parse(last_response.body)["result"][0]["rank"]).to eq $handTypes[$handTypes_4_of_a_kind]
      end

      it 'return FULL_HOUSE hand' do
        body = { "cards": [
          "H1 S1 D1 H5 D5"
        ] }
        post '/api/v1/hand_checkings', body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(JSON.parse(last_response.body)["result"][0]["rank"]).to eq $handTypes[$handTypes_full_house]
      end

      it 'return FLUSH hand' do
        body = { "cards": [
          "H1 H13 H5 H6 H10"
        ] }
        post '/api/v1/hand_checkings', body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(JSON.parse(last_response.body)["result"][0]["rank"]).to eq $handTypes[$handTypes_flush]
      end

      it 'return STRAIGHT hand' do
        body = { "cards": [
          "H1 C2 D3 H4 H5"
        ] }
        post '/api/v1/hand_checkings', body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(JSON.parse(last_response.body)["result"][0]["rank"]).to eq $handTypes[$handTypes_straight]
      end

      it 'return THREE_OF_A_KIND hand' do
        body = { "cards": [
          "H1 D1 C1 H11 D10"
        ] }
        post '/api/v1/hand_checkings', body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(JSON.parse(last_response.body)["result"][0]["rank"]).to eq $handTypes[$handTypes_3_of_a_kind]
      end

      it 'return TWO_PAIRS hand' do
        body = { "cards": [
          "H1 D1 H12 D12 C5"
        ] }
        post '/api/v1/hand_checkings', body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(JSON.parse(last_response.body)["result"][0]["rank"]).to eq $handTypes[$handTypes_2_pairs]
      end

      it 'return ONE_PAIR hand' do
        body = { "cards": [
          "H1 D1 H5 S11 H10"
        ] }
        post '/api/v1/hand_checkings', body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(JSON.parse(last_response.body)["result"][0]["rank"]).to eq $handTypes[$handTypes_1_pair]
      end

      it 'return HIGH_CARD hand' do
        body = { "cards": [
          "H1 D13 C4 S8 H10"
        ] }
        post '/api/v1/hand_checkings', body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(JSON.parse(last_response.body)["result"][0]["rank"]).to eq $handTypes[$handTypes_high_card]
      end

      it 'return result of multiple hand' do
        body = { "cards": [
          "H1 H13 H12 H11 H10",
          "H1 H2 H3 H4 H5",
          "H1 H7 D7 C7 S7",
          "H1 S1 D1 H5 D5",
          "H1 H13 H5 H6 H10",
          "H1 C2 D3 H4 H5",
          "H1 D1 C1 H11 D10",
          "H1 D1 H12 D12 C5",
          "H1 D1 H5 S11 H10",
          "H1 D13 C4 S8 H10"
        ] }
        post '/api/v1/hand_checkings', body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(JSON.parse(last_response.body)['result'][0]['best']).to be_truthy
        expect(JSON.parse(last_response.body)['result'].size).to eq(10)
        expect(JSON.parse(last_response.body)['result'][0]['rank']).to eq($handTypes[$handTypes_royal_flush])
        expect(JSON.parse(last_response.body)['result'][1]['rank']).to eq($handTypes[$handTypes_straight_flush])
        expect(JSON.parse(last_response.body)['result'][2]['rank']).to eq($handTypes[$handTypes_4_of_a_kind])
        expect(JSON.parse(last_response.body)['result'][3]['rank']).to eq($handTypes[$handTypes_full_house])
        expect(JSON.parse(last_response.body)['result'][4]['rank']).to eq($handTypes[$handTypes_flush])
        expect(JSON.parse(last_response.body)['result'][5]['rank']).to eq($handTypes[$handTypes_straight])
        expect(JSON.parse(last_response.body)['result'][6]['rank']).to eq($handTypes[$handTypes_3_of_a_kind])
        expect(JSON.parse(last_response.body)['result'][7]['rank']).to eq($handTypes[$handTypes_2_pairs])
        expect(JSON.parse(last_response.body)['result'][8]['rank']).to eq($handTypes[$handTypes_1_pair])
        expect(JSON.parse(last_response.body)['result'][9]['rank']).to eq($handTypes[$handTypes_high_card])
      end

    end

    describe "failure" do
      it 'invalid format input' do
        body = { "cards": [
          "H1 H13 Y12 H15 H16"
        ] }
        post '/api/v1/hand_checkings', body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(JSON.parse(last_response.body)['error'][0]['error'].size).to eq(3)
        expect(JSON.parse(last_response.body)['error'][0]['error'][0]["name"]).to eq('Y12')
        expect(JSON.parse(last_response.body)['error'][0]['error'][1]["name"]).to eq('H15')
        expect(JSON.parse(last_response.body)['error'][0]['error'][2]["name"]).to eq('H16')
      end

      it 'request to check empty hand' do
        body = { "cards": [
          ""
        ] }
        post '/api/v1/hand_checkings', body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(JSON.parse(last_response.body)['error'][0]['error'][0]["message"]).to eq('５枚のカードが必要です。')
      end

      it 'uncompleted hand' do
        body = { "cards": [
          "H1 H2 H3"
        ] }
        post '/api/v1/hand_checkings', body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(JSON.parse(last_response.body)['error'][0]['error'][0]["message"]).to eq('５枚のカードが必要です。')
      end

      it 'over 5 cards in a hand' do
        body = { "cards": [
          "H1 H2 H3 H5 H6 H7"
        ] }
        post '/api/v1/hand_checkings', body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(JSON.parse(last_response.body)['error'][0]['error'][0]["message"]).to eq('５枚のカードが必要です。')
      end

      it 'hand with duplicated cards' do
        body = { "cards": [
          "H1 H5 H3 H5 H5"
        ] }
        post '/api/v1/hand_checkings', body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(JSON.parse(last_response.body)['error'][0]['error'][0]["message"]).to include('重複')
        expect(JSON.parse(last_response.body)['error'][0]['error'][1]["message"]).to include('重複')
        expect(JSON.parse(last_response.body)['error'][0]['error'][2]["message"]).to include('重複')
      end

      it 'check multiple hands with an invalid hand' do
        body = { "cards": [
          "H1 H13 H12 H11 H10",
          "H1 H2 H3 H4 H5",
          "H1 H7 D7 C7 S7",
          "H1 S1 D1 H5 D5",
          "H1 H13 H5 H6 H10",
          "H1 C2 D3 H4 H5",
          "H1 D1 C1 H11 D10",
          "H1 D1 H12 D12 C5",
          "H1 D1 H5 S11 H10",
          "H1 D13 C4 S8 H10",
          "H1 D13 C4 S8 H100"
        ] }
        post '/api/v1/hand_checkings', body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(JSON.parse(last_response.body)['result'][0]['best']).to be_truthy
        expect(JSON.parse(last_response.body)['result'].size).to eq(10)
        expect(JSON.parse(last_response.body)['result'][0]['rank']).to eq($handTypes[$handTypes_royal_flush])
        expect(JSON.parse(last_response.body)['result'][1]['rank']).to eq($handTypes[$handTypes_straight_flush])
        expect(JSON.parse(last_response.body)['result'][2]['rank']).to eq($handTypes[$handTypes_4_of_a_kind])
        expect(JSON.parse(last_response.body)['result'][3]['rank']).to eq($handTypes[$handTypes_full_house])
        expect(JSON.parse(last_response.body)['result'][4]['rank']).to eq($handTypes[$handTypes_flush])
        expect(JSON.parse(last_response.body)['result'][5]['rank']).to eq($handTypes[$handTypes_straight])
        expect(JSON.parse(last_response.body)['result'][6]['rank']).to eq($handTypes[$handTypes_3_of_a_kind])
        expect(JSON.parse(last_response.body)['result'][7]['rank']).to eq($handTypes[$handTypes_2_pairs])
        expect(JSON.parse(last_response.body)['result'][8]['rank']).to eq($handTypes[$handTypes_1_pair])
        expect(JSON.parse(last_response.body)['result'][9]['rank']).to eq($handTypes[$handTypes_high_card])

        expect(JSON.parse(last_response.body)['error'][0]['error'].size).to eq(1)
        expect(JSON.parse(last_response.body)['error'][0]['error'][0]["name"]).to eq('H100')
      end

      it 'check invalid format and duplication at once' do
        body = { "cards": [
          "H1 H2 H30 H5 H5"
        ] }
        post '/api/v1/hand_checkings', body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(JSON.parse(last_response.body)['error'][0]['error'].size).to eq 3
        expect(JSON.parse(last_response.body)['error'][0]['error'][0]["index"]).to eq 3
        expect(JSON.parse(last_response.body)['error'][0]['error'][1]["index"]).to eq 3
        expect(JSON.parse(last_response.body)['error'][0]['error'][2]["index"]).to eq 4
        expect(JSON.parse(last_response.body)['error'][0]['error'][0]["message"]).to include('不正')
        expect(JSON.parse(last_response.body)['error'][0]['error'][1]["message"]).to include('重複')
        expect(JSON.parse(last_response.body)['error'][0]['error'][2]["message"]).to include('重複')
      end

      it 'request get method' do
        get '/api/v1/hand_checkings'
        expect(last_response.status).to eq 405
      end

      it 'body request is not json' do
        post '/api/v1/hand_checkings', "sahgaks", 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 400
        expect(last_response.body).to include "does not match"
      end

      it 'body request without card param' do
        body = { "card": [
          "H1 H2 H30 H5 H5"
        ] }
        post '/api/v1/hand_checkings', body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 400
        expect(last_response.body).to include "is missing"
      end
    end

  end

end
