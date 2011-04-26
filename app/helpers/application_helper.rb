module ApplicationHelper
# Return a title on a per-page basis.
def title
base_title = "Ruby on Rails Tutorial Sample App"
if @title.nil?
base_title
else
"#{base_title} | #{@title}"
end
end

def logo
  image_tag("logo.png", :alt => "Sample App", :class => "round")
end

###################

@@log = '/home/qraq/Desktop/hlds/cstrike/logi/log'
def hostname
         
   File.readlines(@@log).each do |line| 
   @line = line.split(':') if line =~ /hostname/    
   end
   if @line.nil?
     return nil
   else
    @line.delete("hostname")
    @line.join(' ')
   end
end

def version
         
   File.readlines(@@log).each do |line| 
   @line = line.split(':') if line =~ /version/    
   end
 @line.delete("version ")
 @line.join(' ')
end

def map
         
   File.readlines(@@log).each do |line| 
   @line = line.split(':') if line =~ /map/    
   end
 @line.delete("map     ")
 @line.join(' ')
end

def tcp
        
   File.readlines(@@log).each do |line| 
   @line = line.split(':') if line =~ /tcp\/ip/    
   end
 @line.delete("tcp/ip  ")
 @line.join(' ')
end

def players
   File.readlines(@@log).each do |line| 
   @line = line.split(':') if line =~ /players/    
   end
 @line.delete("players ")
 @line.join(' ')
end
##########################################

def parse
  trg = 0
  @score = []
          
   File.readlines(@@log).each do |line| 
    trg = 1 if line =~ /# \d/  
      @score << line.split(' ') if trg == 1
    trg = 0 if line =~ /\d/    
    end
    return @score.size-1
end


def  players_online(p,d)
  parse
  @entry = []  
  if d == 4
    if Integer(@score[p][8]) == 0 
      @entry << 0
    else
    @entry << (Float(@score[p][5])/Float(@score[p][8])).round(2)
    end
  else
  @entry << @score[p][d] #2 name
  #@entry << @score[p][5] #5 frag
  #@entry << @score[p][8] #8 death
  #@entry << @score[p][6] #6 time
  #@entry << @score[p][7] #7 ping
   return @entry.to_s.delete("\[\]\"\\")
  end
end  


def ft
 return "trololololol"
end











end

