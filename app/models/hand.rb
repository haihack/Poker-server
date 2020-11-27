class Hand
  include Constants

  $min_score = -1

  def initialize(string_hand)
    @card = string_hand
    @best = false
    cards = Array.new (5)
    string_hand.split(" ").each_with_index do |card, i|
      rank = card[1..-1].to_i # card rank
      suit = card.first # card suit
      prime = MAP[rank][1]
      index = MAP[rank][0]
      cards[i] = prime | (index << 8) | MAP_SUITS[suit] | (1 << (16 + index))
    end

    score = evaluate_hand(cards)
    @hand = get_hand_rank(score)
    if ($min_score == -1 || score < $min_score)
      $min_score = score
      $best_rank = @hand
    end

  end

  def best
    @best = (@hand == $best_rank)
  end

  private
  def evaluate_hand(cards)
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
    q = find_it(q)

    return Values::DATA[q]
  end

  def get_hand_rank(score)
    if (score > 6185)
      return HAND_TYPES[HANDTYPES_HIGH_CARD]#'HIGH_CARD'
    end
    if (score > 3325)
      return HAND_TYPES[HANDTYPES_1_PAIR]#'ONE_PAIR'
    end
    if (score > 2467)
      return HAND_TYPES[HANDTYPES_2_PAIRS]#'TWO_PAIRS'
    end
    if (score > 1609)
      return HAND_TYPES[HANDTYPES_3_OF_A_KIND]#'THREE_OF_A_KIND'
    end
    if (score > 1599)
      return HAND_TYPES[HANDTYPES_STRAIGHT]#'STRAIGHT'
    end
    if (score > 322)
      return HAND_TYPES[HANDTYPES_FLUSH]#'FLUSH'
    end
    if (score > 166)
      return HAND_TYPES[HANDTYPES_FULL_HOUSE]#'FULL_HOUSE'
    end
    if (score > 10)
      return HAND_TYPES[HANDTYPES_4_OF_A_KIND]#'FOUR_OF_A_KIND'
    end
    if (score > 1)
      return HAND_TYPES[HANDTYPES_STRAIGHT_FLUSH]#'STRAIGHT_FLUSH'
    end
    return HAND_TYPES[HANDTYPES_ROYAL_FLUSH]#'ROYAL_FLUSH'
  end

  def find_it(key)
    low = 0
    high = 4887

    while (low <= high) do

      mid = (high + low) >> 1 # divide by two
      if (key < Products::DATA[mid])
        high = mid - 1
      elsif (key > Products::DATA[mid])
        low = mid + 1
      else
        return mid
      end
    end
    puts "ERROR: Impossible hand; key = #{key}"
    return -1
  end
end
