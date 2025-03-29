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
end 