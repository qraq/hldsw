class Status
  require "fileutils"
  @@log = '/home/qraq/Desktop/hlds/cstrike/logi/log'
  
 

            
   File.readlines(@@log).each do |line| 
   @hostname = line.split(':') if line =~ /hostname/    
   @version = line.split(':') if line =~ /version/ 
   @tcp = line.split(':') if line =~ /tcp\/ip/ 
   @map = line.split(":") if line =~ /map/ 
   @players = line.split(":") if line =~ /players/ 
    end

 
 @hostname.delete("hostname")
 @version.delete("version ")
 @tcp.delete("tcp/ip  ")
 @map.delete("map     ")
 @players.delete("players ")
 @hostname.join(' ')
 @version.join(' ')
 @map.join(' ')
 @players.join(' ')

def hostname
  print @hostname
end

def version
  print @version
end

def tcp 
  print @tcp
end

def map 
  print @map
end

def players
  print @players
end

end

