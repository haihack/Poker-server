module V1
    class HandChecking < Grape::API
      version 'v1', using: :path

      #use command rails grape:routes to get available routes

      resource :hand_checkings do
        desc 'Create product'
        params do
          requires :cards, type: Array
        end
        post do
          $min_score = -1;
          obj_array = JSON.parse(request.body.read)
          hands_json = obj_array["cards"]
          @hands = Array.new
          $errors = Array.new

          hands_json.each do |handJson|
            @hands << Hand.new(handJson) if (is_input_data_validated(handJson))
          end

          @hands.each do |hand|
            hand.best #update new value
          end
          if $errors.length == 0
            { "result": @hands }
          else
            { "result": @hands, "error": $errors }
          end
        end

      end

      helpers do
        def is_input_data_validated(hand)
          error = nil
          cards = hand.squish.split(" ")
          hand_error = []
          #check whether the hand has 5 cards
          if (cards.size != 5)
            error = CardError.new(-1, "", "５枚のカードが必要です。")
            hand_error << error
            $errors << Error.new(hand, hand_error)
            return false
          end

          #allow only 1 whitespace
          unless hand.strip.match(/^\S+(?: \S+)*$/)
            error = CardError.new(-1, "", "5つのカード指定文字を半角スペース区切りで入力してください。")
            hand_error << error
            $errors << Error.new(hand, hand_error)
            return false
          end

          #check format
          cards.each_with_index do |card, i|
            unless card.match(/^[HSDC]([1-9]|1[0-3])$/)
              error = CardError.new(i + 1, card, "#{i + 1}番目のカード指定文字が不正です。  #{card}")
              hand_error << error
            end
          end

          #check duplication
          duplicates = cards.each_with_index.group_by(&:first).inject({}) do |result, (val, group)|
            next result if group.length == 1
            result.merge val => group.map { |pair| pair[1] }
          end
          duplicates.values.flatten.each do |i|
            error = CardError.new(i, cards[i], "#{i + 1}番目のカード指定文字が重複しています。  #{cards[i]}")
            hand_error << error
          end

          if !hand_error.empty?
            $errors << Error.new(hand, hand_error)
          end
          return error.nil?
        end
      end

    end


end
