class Fixnum
  # Returns all possible constituents for a given whole number.
  #
  # Optionally takes a limit for maximum number of constituents.
  #
  # e.g. 3.partition    => [[3], [2, 1], [1, 1, 1]]
  #      4.partition    => [[4], [3, 1], [2, 2], [2, 1, 1], [1, 1, 1, 1]]
  #      4.partition(2) => [[4], [3, 1], [2, 2]]
  #
  def partition(limit=Float::INFINITY)
    res = Fixnum.partition(self.abs, limit).lazy
    self < 0 ? res.map{|i| i.map{|j| 0 - j}} : res
  end

  private

  def self.partition_memo
    @@partition_memo ||= {}
  end

  def self.partition(n, limit=Float::INFINITY)
    partition_memo[limit] = {1 => [[1]]} unless partition_memo[limit]
    return partition_memo[limit][n] if partition_memo[limit][n]

    result = [[n]]

    (1...n).each do |i|
      a = n - i
      Fixnum.partition(i, limit).each do |r|
        next if r.count >= limit
        result.push([a] + r) if r[0] <= a
      end
    end

    partition_memo[limit][n] = result
    return result
  end
end