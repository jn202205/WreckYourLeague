json.array!(@sports) do |sport|
  json.extract! sport, :id, :name, :created_at, :updated_at

  # json.positions sport.postions do |position|
  # end
end
