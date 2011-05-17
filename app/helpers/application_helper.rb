module ApplicationHelper
# Return a title on a per-page basis.
def title
base_title = "HLDS-Web Server Konfigurator"
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
 
 str = @line[0]
 str[-2..-1] = ""
 return str
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

def how_many_players
  server = GoldSrcServer.new(@ip_server)
  @lines = []
 begin
  server.rcon_auth('haslo')
  @lines << server.rcon_exec('users')
  
  rescue RCONNoAuthException
  warn 'Niepoprawne haslo dostepu do serwera.'
 end
  return @lines.to_s.delete("\[\]\"\\")[88..89].to_i
end


def  players_online(p,d)
  parse
  @entry = []  
  if d == 10 #steam ID
    return @score[p][4].to_s.delete("\[\]\"\\")
  end
  if d == 4
    if Integer(@score[p][8]) == 0 
      @entry << Float(@score[p][5])/1
    else
    @entry << (Float(@score[p][5])/Float(@score[p][8])).round(2)
    end
  else
  @entry << @score[p][d] #2 name
  #@entry << @score[p][5] #5 frag
  #@entry << @score[p][8] #8 death
  #@entry << @score[p][6] #6 time
  #@entry << @score[p][7] #7 ping
   #@entry << @score[p][7] #9 ip
   return @entry.to_s.delete("\[\]\"\\")
  end
end  



def detect_ip
    if request.remote_ip == '127.0.0.1'
      '192.168.0.150'
    else
      request.remote_ip
    end
end

  def sort_link(title, column, options = {})
    condition = options[:unless] if options.has_key?(:unless)
    sort_dir = params[:d] == 'up' ? 'down' : 'up'
    link_to_unless condition, title, request.parameters.merge( {:c => column, :d => sort_dir} )
  end
######################## RCON ############################

 @ip_server = '127.0.0.1'
def rcon_status
 server = GoldSrcServer.new(@ip_server)
 begin
  server.rcon_auth('haslo')
  puts server.rcon_exec('status')
 rescue RCONNoAuthException
  warn 'Niepoprawne haslo dostepu do serwera.'
 end
end


def rcon_command(command, value)
 if value.nil?
   return nil
 else
 server = GoldSrcServer.new(@ip_server)
 begin
  server.rcon_auth('haslo')
  puts server.rcon_exec(command.to_s+ " " +value.to_s)
 #  puts command.to_s+ " " +value.to_s
      sleep 5 if command.to_s == 'changelevel2' || command.to_s == 'changelevel' 
    
      flash[:notice] = "Polecenie ["+command.to_s+ " " +value.to_s+ "] wyslano na serwer"
    
rescue RCONNoAuthException
  warn 'Niepoprawne haslo dostepu do serwera.'
 end
 end
end

def rcon_ban(value)
 if value.nil?
   return nil
 else
 server = GoldSrcServer.new(@ip_server)
 begin
  server.rcon_auth('haslo')
  puts server.rcon_exec("banid 1".to_s+ " " +value.to_s+" kick")    
      flash[:notice] = "Polecenie [banid 1".to_s+ " " +value.to_s+" kick] wyslano na serwer"
    
rescue RCONNoAuthException
  warn 'Niepoprawne haslo dostepu do serwera.'
 end
 end
end




























end

