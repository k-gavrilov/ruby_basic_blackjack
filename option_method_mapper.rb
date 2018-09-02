class OptionMethodMapper
  attr_reader :options_str_arr

  def initialize
    @options_hash = {}
    @options_str_arr = []
  end

  def add_option(lambda_block, option_str)
    options_str_arr << "#{options_hash.size}: #{option_str}"
    options_hash[options_hash.size] = lambda_block
  end

  def get_action(option)
    options_hash[option]
  end

  protected

  attr_reader :options_hash
end
