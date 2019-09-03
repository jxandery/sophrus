Fabricator(:open_position) do
  instrument
  status { 'open' }
end

Fabricator(:closed_position) do
  instrument
  status { 'closed' }
end
