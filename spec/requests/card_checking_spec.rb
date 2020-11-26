require 'rails_helper'
require 'spec_helper'

describe V1::HandChecking, :type => :request do

  include Constants
  HAND_TYPES = %w[ロイヤルフラッシュ ストレートフラッシュ フォー・オブ・ア・カインド フルハウス フラッシュ ストレート スリー・オブ・ア・カインド ツーペア ワンペア ハイカー]
  HANDTYPES_ROYAL_FLUSH = 0
  HANDTYPES_STRAIGHT_FLUSH = 1
  HANDTYPES_4_OF_A_KIND = 2
  HANDTYPES_FULL_HOUSE = 3
  HANDTYPES_FLUSH = 4
  HANDTYPES_STRAIGHT = 5
  HANDTYPES_3_OF_A_KIND = 6
  HANDTYPES_2_PAIRS = 7
  HANDTYPES_1_PAIR = 8
  HANDTYPES_HIGH_CARD = 9

  include Rack::Test::Methods

  let(:url) { '/api/v1/hand_checkings' }

  def getRank(last_response, index)
    JSON.parse(last_response.body)["result"][index]["rank"]
  end

  def getError(last_response)
    JSON.parse(last_response.body)['error'][0]['error']
  end

  context 'POST /api/v1/hand_checkings' do
    describe "ok" do
      it 'return ROYAL_FLUSH hand' do
        body = { "cards": [
          "H1 H13 H12 H11 H10"
        ] }
        post url, body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(getRank(last_response, 0)).to eq HAND_TYPES[HANDTYPES_ROYAL_FLUSH]
      end

      it 'return STRAIGHT_FLUSH hand' do
        body = { "cards": [
          "H1 H2 H3 H4 H5"
        ] }
        post url, body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(getRank(last_response, 0)).to eq HAND_TYPES[HANDTYPES_STRAIGHT_FLUSH]
      end

      it 'return FOUR_OF_A_KIND hand' do
        body = { "cards": [
          "H1 H7 D7 C7 S7"
        ] }
        post url, body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(getRank(last_response, 0)).to eq HAND_TYPES[HANDTYPES_4_OF_A_KIND]
      end

      it 'return FULL_HOUSE hand' do
        body = { "cards": [
          "H1 S1 D1 H5 D5"
        ] }
        post url, body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(getRank(last_response, 0)).to eq HAND_TYPES[HANDTYPES_FULL_HOUSE]
      end

      it 'return FLUSH hand' do
        body = { "cards": [
          "H1 H13 H5 H6 H10"
        ] }
        post url, body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(getRank(last_response, 0)).to eq HAND_TYPES[HANDTYPES_FLUSH]
      end

      it 'return STRAIGHT hand' do
        body = { "cards": [
          "H1 C2 D3 H4 H5"
        ] }
        post url, body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(getRank(last_response, 0)).to eq HAND_TYPES[HANDTYPES_STRAIGHT]
      end

      it 'return THREE_OF_A_KIND hand' do
        body = { "cards": [
          "H1 D1 C1 H11 D10"
        ] }
        post url, body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(getRank(last_response, 0)).to eq HAND_TYPES[HANDTYPES_3_OF_A_KIND]
      end

      it 'return TWO_PAIRS hand' do
        body = { "cards": [
          "H1 D1 H12 D12 C5"
        ] }
        post url, body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(getRank(last_response, 0)).to eq HAND_TYPES[HANDTYPES_2_PAIRS]
      end

      it 'return ONE_PAIR hand' do
        body = { "cards": [
          "H1 D1 H5 S11 H10"
        ] }
        post url, body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(getRank(last_response, 0)).to eq HAND_TYPES[HANDTYPES_1_PAIR]
      end

      it 'return HIGH_CARD hand' do
        body = { "cards": [
          "H1 D13 C4 S8 H10"
        ] }
        post url, body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(getRank(last_response, 0)).to eq HAND_TYPES[HANDTYPES_HIGH_CARD]
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
        post url, body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(JSON.parse(last_response.body)['result'][0]['best']).to be_truthy
        expect(JSON.parse(last_response.body)['result'].size).to eq(10)
        expect(getRank(last_response, 0)).to eq(HAND_TYPES[HANDTYPES_ROYAL_FLUSH])
        expect(getRank(last_response, 1)).to eq(HAND_TYPES[HANDTYPES_STRAIGHT_FLUSH])
        expect(getRank(last_response, 2)).to eq(HAND_TYPES[HANDTYPES_4_OF_A_KIND])
        expect(getRank(last_response, 3)).to eq(HAND_TYPES[HANDTYPES_FULL_HOUSE])
        expect(getRank(last_response, 4)).to eq(HAND_TYPES[HANDTYPES_FLUSH])
        expect(getRank(last_response, 5)).to eq(HAND_TYPES[HANDTYPES_STRAIGHT])
        expect(getRank(last_response, 6)).to eq(HAND_TYPES[HANDTYPES_3_OF_A_KIND])
        expect(getRank(last_response, 7)).to eq(HAND_TYPES[HANDTYPES_2_PAIRS])
        expect(getRank(last_response, 8)).to eq(HAND_TYPES[HANDTYPES_1_PAIR])
        expect(getRank(last_response, 9)).to eq(HAND_TYPES[HANDTYPES_HIGH_CARD])
      end

    end

    describe "failure" do
      it 'invalid format input' do
        body = { "cards": [
          "H1 H13 Y12 H15 H16"
        ] }
        post url, body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(getError(last_response).size).to eq(3)
        expect(getError(last_response)[0]["name"]).to eq('Y12')
        expect(getError(last_response)[1]["name"]).to eq('H15')
        expect(getError(last_response)[2]["name"]).to eq('H16')
      end

      it 'request to check empty hand' do
        body = { "cards": [
          ""
        ] }
        post url, body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(getError(last_response)[0]["message"]).to eq('５枚のカードが必要です。')
      end

      it 'uncompleted hand' do
        body = { "cards": [
          "H1 H2 H3"
        ] }
        post url, body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(getError(last_response)[0]["message"]).to eq('５枚のカードが必要です。')
      end

      it 'over 5 cards in a hand' do
        body = { "cards": [
          "H1 H2 H3 H5 H6 H7"
        ] }
        post url, body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(getError(last_response)[0]["message"]).to eq('５枚のカードが必要です。')
      end

      it 'hand with duplicated cards' do
        body = { "cards": [
          "H1 H5 H3 H5 H5"
        ] }
        post url, body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(getError(last_response)[0]["message"]).to include('重複')
        expect(getError(last_response)[1]["message"]).to include('重複')
        expect(getError(last_response)[2]["message"]).to include('重複')
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
        post url, body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(JSON.parse(last_response.body)['result'][0]['best']).to be_truthy
        expect(JSON.parse(last_response.body)['result'].size).to eq(10)
        expect(getRank(last_response, 0)).to eq(HAND_TYPES[HANDTYPES_ROYAL_FLUSH])
        expect(getRank(last_response, 1)).to eq(HAND_TYPES[HANDTYPES_STRAIGHT_FLUSH])
        expect(getRank(last_response, 2)).to eq(HAND_TYPES[HANDTYPES_4_OF_A_KIND])
        expect(getRank(last_response, 3)).to eq(HAND_TYPES[HANDTYPES_FULL_HOUSE])
        expect(getRank(last_response, 4)).to eq(HAND_TYPES[HANDTYPES_FLUSH])
        expect(getRank(last_response, 5)).to eq(HAND_TYPES[HANDTYPES_STRAIGHT])
        expect(getRank(last_response, 6)).to eq(HAND_TYPES[HANDTYPES_3_OF_A_KIND])
        expect(getRank(last_response, 7)).to eq(HAND_TYPES[HANDTYPES_2_PAIRS])
        expect(getRank(last_response, 8)).to eq(HAND_TYPES[HANDTYPES_1_PAIR])
        expect(getRank(last_response, 9)).to eq(HAND_TYPES[HANDTYPES_HIGH_CARD])

        expect(getError(last_response).size).to eq(1)
        expect(getError(last_response)[0]["name"]).to eq('H100')
      end

      it 'check invalid format and duplication at once' do
        body = { "cards": [
          "H1 H2 H30 H5 H5"
        ] }
        post url, body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 201
        expect(getError(last_response).size).to eq 3
        expect(getError(last_response)[0]["index"]).to eq 3
        expect(getError(last_response)[1]["index"]).to eq 3
        expect(getError(last_response)[2]["index"]).to eq 4
        expect(getError(last_response)[0]["message"]).to include('不正')
        expect(getError(last_response)[1]["message"]).to include('重複')
        expect(getError(last_response)[2]["message"]).to include('重複')
      end

      it 'request get method' do
        get '/api/v1/hand_checkings'
        expect(last_response.status).to eq 405
      end

      it 'body request is not json' do
        post url, "sahgaks", 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 400
        expect(last_response.body).to include "does not match"
      end

      it 'body request without card param' do
        body = { "card": [
          "H1 H2 H30 H5 H5"
        ] }
        post url, body.to_json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq 400
        expect(last_response.body).to include "is missing"
      end
    end

  end

end
