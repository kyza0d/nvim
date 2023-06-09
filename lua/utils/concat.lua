-- Concat.lua: Concatenates a list of strings into a single string.
return function(...)
  local args = { ... }
  local result = ''

  for i = 1, #args do
    if type(args[i]) == 'table' then
      for j = 1, #args[i] do
        result = string.format('%s%s', result, args[i][j])
      end
    else
      result = string.format('%s%s', result, args[i])
    end
  end

  return result
end
