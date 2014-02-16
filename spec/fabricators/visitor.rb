Fabricator(:visitor, from: Mousereco::Visitor) do
  key { SecureRandom.hex }
end