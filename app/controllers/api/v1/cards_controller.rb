module Api::V1
  class CardsController < ApplicationController
    def index
      puts request.body.read
      render json: { "name": "John", "age": 30, "car": "yama" }
    end

    def create
      # puts request.body.read
      objArray = JSON.parse(request.body.read)
      handsJson = objArray["cards"]
      @hands = Array.new
      $errors = Array.new

      #validate input data
      # handsJson.each do |handJson|
      #   render json: { message: 'Internal error' }, status: :internal_server_error and return
      # end

      handsJson.each do |handJson|
        if (isInputDataValidated(handJson))
          @hands << Hand.new(handJson)
        end
      end

      @hands.each do |hand|
        hand.best #update new value
      end
      if $errors.length == 0
        render json: { "result": @hands }
      else
        render json: { "result": @hands, "error": $errors }
      end
    end

    def isInputDataValidated(hand)
      error = nil
      cards = hand.split(" ")
      handError = []
      #check whether the hand has 5 cards
      if (cards.size != 5)
        error = CardError.new(-1, "", "５枚のカードが必要です。")
        handError << error
        $errors << Error.new(hand, handError)
        return false
      end

      #check duplication
      if (cards.uniq.size != cards.size)
        error = CardError.new(-1, "", "カードが重複しています。")
        handError << error
        $errors << Error.new(hand, handError)
        return false
      end

      cards.each_with_index do |card, i|
        if card.match(/^[HSDC]([1-9]|1[0-3])$/)

        else
          error = CardError.new(i + 1, card, "#{i + 1}番目のカード指定文字が不正です。  #{card}")
          handError << error
        end

      end
      if !handError.empty?
        $errors << Error.new(hand, handError)
      end
      return error.nil?
    end

  end

  $map = {
    2 => [0, 2], #name|index|prime
    3 => [1, 3],
    4 => [2, 5],
    5 => [3, 7],
    6 => [4, 11],
    7 => [5, 13],
    8 => [6, 17],
    9 => [7, 19],
    10 => [8, 23],
    11 => [9, 29],
    12 => [10, 31],
    13 => [11, 37],
    1 => [12, 41]
  }
  $mapSuits = {
    "C" => 0x8000,
    "D" => 0x4000,
    "H" => 0x2000,
    "S" => 0x1000
  }
  $handTypes = %w[ロイヤルフラッシュ ストレートフラッシュ フォー・オブ・ア・カインド フルハウス フラッシュ ストレート スリー・オブ・ア・カインド ツーペア ワンペア ハイカー]
  $handTypes_royal_flush = 0
  $handTypes_straight_flush = 1
  $handTypes_4_of_a_kind = 2
  $handTypes_full_house = 3
  $handTypes_flush = 4
  $handTypes_straight = 5
  $handTypes_3_of_a_kind = 6
  $handTypes_2_pairs = 7
  $handTypes_1_pair = 8
  $handTypes_high_card = 9
  $minScore = -1

  class Hand

    def initialize(stringHand)
      @hand = stringHand
      @best = false
      cards = Array.new (5)
      stringHand.split(" ").each_with_index do |card, i|
        rank = card[1..-1].to_i # card rank
        suit = card.first # card suit
        prime = $map[rank][1]
        index = $map[rank][0]
        cards[i] = prime | (index << 8) | $mapSuits[suit] | (1 << (16 + index))
      end

      score = evaluateHand(cards)
      @rank = getHandRank(score)
      if ($minScore == -1 || score < $minScore)
        $minScore = score
        $bestRank = @rank
      end

    end

    def best
      @best = (@rank == $bestRank)
    end

    def evaluateHand(cards)
      q = (cards[0] | cards[1] | cards[2] | cards[3] | cards[4]) >> 16;

      # check for Flushes and StraightFlushes
      if (cards[0] & cards[1] & cards[2] & cards[3] & cards[4] & 0xF000) != 0
        #if above expression is non-zero
        return Flushes::DATA[q]
      end

      #  check for Straights and HighCard hands
      s = Unique5::DATA[q]
      if s != 0
        return s
      end

      #  let's do it the hard way
      q = (cards[0] & 0xFF) * (cards[1] & 0xFF) * (cards[2] & 0xFF) * (cards[3] & 0xFF) * (cards[4] & 0xFF)
      q = findIt(q)

      return Values::DATA[q]
    end

    def getHandRank(score)
      if (score > 6185)
        return $handTypes[$handTypes_high_card]#'HIGH_CARD'
      end
      if (score > 3325)
        return $handTypes[$handTypes_1_pair]#'ONE_PAIR'
      end
      if (score > 2467)
        return $handTypes[$handTypes_2_pairs]#'TWO_PAIRS'
      end
      if (score > 1609)
        return $handTypes[$handTypes_3_of_a_kind]#'THREE_OF_A_KIND'
      end
      if (score > 1599)
        return $handTypes[$handTypes_straight]#'STRAIGHT'
      end
      if (score > 322)
        return $handTypes[$handTypes_flush]#'FLUSH'
      end
      if (score > 166)
        return $handTypes[$handTypes_full_house]#'FULL_HOUSE'
      end
      if (score > 10)
        return $handTypes[$handTypes_4_of_a_kind]#'FOUR_OF_A_KIND'
      end
      if (score > 1)
        return $handTypes[$handTypes_straight_flush]#'STRAIGHT_FLUSH'
      end
      return $handTypes[$handTypes_royal_flush]#'ROYAL_FLUSH'
    end

    def findIt(key)
      low = 0
      high = 4887

      while (low <= high) do

        mid = (high + low) >> 1 # divide by two
        if (key < Products::DATA[mid])
          high = mid - 1;
        elsif (key > Products::DATA[mid])
          low = mid + 1;
        else
          return mid
        end
      end
      puts "ERROR: Impossible hand; key = #{key}"
      return -1;
    end
  end

  class Error
    def initialize(listCard, arrayError)
      @error = arrayError
      @listCard = listCard
    end
  end

  class CardError
    def initialize(index, name, message)
      @index = index
      @name = name
      @message = message
    end
  end
end

