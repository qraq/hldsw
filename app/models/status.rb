
  require "fileutils"
  @@log = '/home/qraq/Desktop/hlds/cstrike/logi/log'
  
   trg = 0
  @score = []
            
   File.readlines(@@log).each do |line| 
    trg = 1 if line =~ /# \d/  
      @score << line.split(' ') if trg == 1
    trg = 0 if line =~ /\d/    
    end


@player= []
def  player_name
  for i in 0..@score.size-1
   return @player << @score[i][2] + "\n"
  
  end
end  