class Form::HoleCollection < Form::Base
  FORM_COUNT = 9
  attr_accessor :holes

  def initialize(attributes = {})
    super attributes
    self.holes = FORM_COUNT.times.map { |n| Hole.new(hole_number: n + 1, number_of_pars: 3 ) } unless self.holes.present?
  end
  
  # 上でsuper attributesとしているので必要
  def holes_attributes=(attributes)
    self.holes = attributes.map { |_, v| Hole.new(v) }
  end

  def save
    # 実際にやりたいことはこれだけ
    # self.holes.map(&:save!)

    # 複数件全て保存できた場合のみ実行したいので、transactionを使用する
    Hole.transaction do
      self.holes.map(&:save!)
    end
      return true
    rescue => e
      return false
  end
end