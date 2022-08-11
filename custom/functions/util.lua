return {
  reverseTable = function(t)
      local reversedTable = {}
      for k, v in pairs(t) do
        reversedTable[v] = k
      end
      return reversedTable
  end
}
