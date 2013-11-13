module GenerateKey
  extend ActiveSupport::Concern

  included do
    after_initialize :set_key
  end

  protected

  def set_key
    self.key ||= generate_key
  end

  def generate_key(length = 10)
    begin
      key = SecureRandom.hex[0..length]
    end while self.class.where(key: key).exists?
    key
  end
end