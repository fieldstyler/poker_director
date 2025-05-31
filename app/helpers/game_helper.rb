module GameHelper
    def add_commas(string, comma=4, multiplier=1)
        length = string.length
        length%3 == 0 ? count = (length / 3) - 1 : count = length / 3
        count.times do
            string.insert("-#{comma*multiplier}".to_i, ",")
            multiplier += 1
        end
        string
    end

    def add_dollar_sign(number)
        "$#{number}"
    end

    def payout_percentages(places_paid)
        base_weights = {
          1 => 5,
          2 => 3,
          3 => 2,
          4 => 1.5,
          5 => 1.2,
          6 => 1,
          7 => 0.9,
          8 => 0.8,
          9 => 0.7,
          10 => 0.6
        }
    
        weights = (1..places_paid).map { |i| base_weights[i] || 1 }
    
        total_weight = weights.sum
        weights.map { |w| (w / total_weight.to_f).round(4) }
    end
end 