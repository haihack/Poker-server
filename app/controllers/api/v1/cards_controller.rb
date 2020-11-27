module API::V1
  class CardsController < ApplicationController
    include Constants

    # def create
    #   # puts request.body.read
    #   $min_score = -1;
    #   objArray = JSON.parse(request.body.read)
    #   handsJson = objArray["cards"]
    #   @hands = Array.new
    #   $errors = Array.new
    #
    #   handsJson.each do |handJson|
    #       @hands << Hand.new(handJson) if (isInputDataValidated(handJson))
    #   end
    #
    #   @hands.each do |hand|
    #     hand.best #update new value
    #   end
    #   if $errors.length == 0
    #     render json: { "result": @hands }
    #   else
    #     render json: { "result": @hands, "error": $errors }
    #   end
    # end
    #
    # private
    # def isInputDataValidated(hand)
    #   error = nil
    #   cards = hand.squish.split(" ")
    #   handError = []
    #   #check whether the hand has 5 cards
    #   if (cards.size != 5)
    #     error = CardError.new(-1, "", "５枚のカードが必要です。")
    #     handError << error
    #     $errors << Error.new(hand, handError)
    #     return false
    #   end
    #
    #   #allow only 1 whitespace
    #   unless hand.strip.match(/^\S+(?: \S+)*$/)
    #     error = CardError.new(-1, "", "5つのカード指定文字を半角スペース区切りで入力してください。")
    #     handError << error
    #     $errors << Error.new(hand, handError)
    #     return false
    #   end
    #
    #   #check format
    #   cards.each_with_index do |card, i|
    #     unless card.match(/^[HSDC]([1-9]|1[0-3])$/)
    #       error = CardError.new(i + 1, card, "#{i + 1}番目のカード指定文字が不正です。  #{card}")
    #       handError << error
    #     end
    #   end
    #
    #   #check duplication
    #   duplicates = cards.each_with_index.group_by(&:first).inject({}) do |result, (val, group)|
    #     next result if group.length == 1
    #     result.merge val => group.map { |pair| pair[1] }
    #   end
    #   duplicates.values.flatten.each do |i|
    #     error = CardError.new(i, cards[i], "#{i + 1}番目のカード指定文字が重複しています。  #{cards[i]}")
    #     handError << error
    #   end
    #
    #   if !handError.empty?
    #     $errors << Error.new(hand, handError)
    #   end
    #   return error.nil?
    # end

  end

end

