local scriptUtil = {}

function scriptUtil.print_letters(console, reader, string, wait_time, color_index)
  for i=1, #string do
    local char = string:sub(i,i)
    console:print(char, color_index)
    reader:wait(wait_time)
  end
end

function scriptUtil.print_letters_at(console, reader, string, wait_time, position, color_index)
  for i=1, #string do
    local char = string:sub(i,i)
    console:print_at(char, position, color_index)
    position.x = position.x + 1
    if position.x >= console.num_columns then
      position.x = 0
      position.y = position.y + 1
    end
    reader:wait(wait_time)
  end
end

function scriptUtil.print_centered(console, string, color_index)
  local num_columns = console.num_columns
  local left_side = true

  while #string < num_columns do
    if left_side then
      string = ' ' .. string
    else
      string = string .. ' '
    end

    left_side = not left_side
  end

  console:println(string, color_index)
end

function scriptUtil.get_date()
  return os.date("%m/%d/%Y %I:%M %p")
end

return scriptUtil