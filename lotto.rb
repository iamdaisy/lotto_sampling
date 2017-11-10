require 'httparty'
require 'json'

url = "http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo="
response = HTTParty.get(url)
result = JSON.parse(response.body)  #header랑 status 코드도 같이 와서body만 파싱

arr = Array.new

# 6.times do |i|
#     arr << result["drwtNo#{i+1}"]
# end
# puts arr

result.each do |key, value|
    arr << value if key.include? "drwtNo"
end

puts arr.sort

