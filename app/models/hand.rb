class Hand

  $minScore = -1

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

  private
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

  private
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

  private
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
