module StrategyInfosHelper
  def shot_btns_default(shots, n)
    # byebug
    @default_number = 0
    shots[1].each_with_index do |shot, num|
      @default_number = num if shot[:user_id] == current_user.id
    end
    # byebug
    return @default_number
  end
end
