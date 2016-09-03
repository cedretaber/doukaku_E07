
NUMS = %w(3f 06 5b 4f 66 6d 7d 27 7f 6f)
  .zip(%w(40 79 24 30 19 12 02 58 00 10))
  .map { |xs| xs.map { |x| x.to_i(16) } }

def fin_poss(input)
  k = (input.count(":") / 2) + 1
  cbf = true

  input.split(",").tap { |on, off|
    break on.split(":").zip(off.split(":")).map { |xs| xs.map { |x| x.to_i(16) } }
  }.reduce([[], []]) { |(min, max), (on, off)|
    k -= 1
    idx = -1

    nx = NUMS.reduce([]) { |arr, (ion, ioff)|
      idx += 1
      if on | ion == ion and off | ioff == ioff
        [*arr, idx]
      else
        arr
      end
    }

    min, max = [], [] if nx.empty?

    if k != 0
      nx -= [0] if cbf
      nx << 0 if cbf && on == 0
      cbf = false if on != 0
    end

    return "-" if nx.empty?

    n, x = nx.minmax

    [min << n.to_s, max << x.to_s]
  }.map { |is| is.join.to_i.to_s }.join(",")
end

def test(input, expect)
  puts (if (result = fin_poss(input)) == expect
    "pass"
  else
    "test failed: input: #{input}, expect: #{expect}, but result: #{result}"
  end)
end

test( "06:4b:46:64:6d,79:20:10:10:02", "12345,13996" )
test( "41:00,3e:01", "-" )
test( "00:00,79:79", "1,11" )
test( "02:4b:46:64,20:20:10:10", "1234,3399" )
test( "06:2f:3f:27,40:00:00:40", "1000,7987" )
test( "00:3d:2d:26,00:00:00:00", "600,9899" )
test( "40:20:10,00:00:00", "200,998" )
test( "00:00:00,40:20:10", "1,739" )
test( "08:04:02:01,00:00:00:00", "2000,9999" )
test( "00:00:00:00,08:04:02:01", "1,7264" )
test( "08:04:02:01,01:02:04:08", "-" )
test( "04:02:01,02:04:08", "527,627" )
test( "04:02:01:40:10,02:04:08:10:20", "52732,62792" )
test( "00:30:07,00:01:10", "-" )
test( "37,00", "0,8" )
test( "3f,40", "0,0" )
test( "3f:3f,40:40", "-" )
test( "00:3f,40:40", "0,70" )
test( "00:3f,38:00", "0,18" )
test( "18,07", "-" )
test( "08,10", "3,9" )
test( "42,11", "4,4" )
test( "18,05", "-" )
test( "10:00,0b:33", "-" )
test( "14:02,00:30", "61,83" )
test( "00:1a,3d:04", "2,2" )
test( "00:28,38:40", "0,10" )
test( "20:08:12,4f:37:24", "-" )
test( "02:4c:18,00:00:04", "132,992" )
test( "4a:7a:02,10:00:30", "381,983" )
test( "00:00:06,0b:11:08", "1,47" )
test( "04:20:2c:14,39:08:50:09", "-" )
test( "02:06:02:02,00:31:18:11", "1111,9174" )
test( "00:04:48:50,03:02:20:02", "526,636" )
test( "00:58:42:40,00:20:08:12", "245,9245" )
test( "08:08:60:00:32,76:67:02:16:04", "-" )
test( "00:00:00:08:02,06:1a:3b:20:11", "21,34" )
test( "08:58:12:06:12,10:20:20:00:04", "32202,92292" )
test( "00:10:74:4e:10,10:04:02:00:24", "2632,92692" )
test( "44:76:0a:00:0c:44,39:08:11:09:02:11", "-" )
test( "00:00:44:0a:04:00,79:06:02:04:79:28", "5211,6211" )
test( "30:02:02:2c:0e:02,00:08:04:02:20:01", "612531,872634" )
test( "00:00:04:10:00:60,25:19:01:02:24:00", "1624,44629" )
test( "04:18:54:38:00:14:70,10:65:09:01:6c:00:0d", "-" )
test( "18:04:26:20:04:24:1a,02:21:50:48:02:08:00", "6177540,6177678" )
test( "00:08:34:00:00:64:06,18:24:02:00:61:08:61", "260141,7269141" )
test( "00:02:0a:04:4a:00:20,18:21:24:02:04:60:19", "125214,7126214" )
