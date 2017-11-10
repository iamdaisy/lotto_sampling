class LottoController < ApplicationController
  def index
    
  end

  def show
    @lotto = [*1..45].sample(6)
  end
  
  def api
    # require 'httparty' 전역으로 추가되있어서 따로 안해줘도됨
    require 'json'
    
    url = "http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo="
    response = HTTParty.get(url)
    result = JSON.parse(response.body)
    
  
    bonus = result["bnusNo"]
    
    @arr = Array.new
    result.each do |key, value|
      @arr << value if key.include? "drwtNo"
    end
    
    @lotto = [*1..45].sample(6)
    
    @arr.sort!
    # api로 가져온 이번주 당첨 코드
    
    # lotto 추첨된 숫자와 arr안에 담긴 숫자를 비교
    @matching = @arr & @lotto
    # 6개 1등 / 5개 2등 / 4개 3등 / 1개 6등
    
    if @matching.count == 6
     @result = "1등"
    elsif @matching.count == 5 && @lotto.include?(bonus) #우리 추천 번호에 bonus가 있니?
     @result = "2등"
    elsif @matching.count == 5
     @result = "3등"
    elsif @matching.count == 3
     @result = "4등(5만원)"
    elsif @matching.count == 2
     @result = "5등(5천원)"
    elsif @matching.count == 1
     @result = "6등"
    else
     @result = "꽝"
    end
  
    # case @matching.count
    # when 6
    #   "1등"
    # when 5
    #   "2등"
    # when 4
    #   "3등"
    # when 3
    #   "4등"
    # when 2
    #   "5등"
    # when 1
    #   "6등"
    # end
    
  end
end
